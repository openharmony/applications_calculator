/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import Want from '@ohos.app.ability.Want';
import window from '@ohos.window';
import ConfigurationConstant from '@ohos.app.ability.ConfigurationConstant';
import { Configuration } from '@ohos.app.ability.Configuration';
import UIAbility from '@ohos.app.ability.UIAbility';
import { LogUtil, CommonUtil, GlobalThisHelper, GlobalContext } from '@hmos/common';
import { DigitPanelController } from '@hmos/calculation';

const TAG: string = 'CalculatorAbility';
const WHITE: string = '#DBFFFFFF';
const BLACK: string = '#E5000000';

export default class CalculatorAbility extends UIAbility {
  private windowInstance: window.Window | null = null;

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    GlobalContext.getContext().setObject('resourceManager', this.context.resourceManager);
    AppStorage.setOrCreate('localString', this.context.config.language);
    LogUtil.info(TAG, 'CalculatorAbility onCreate');
  }

  onDestroy(): void {
    LogUtil.info(TAG, 'CalculatorAbility onDestroy');
    if (this.windowInstance) {
      this.unRegisterWindowCallBack(this.windowInstance);
      this.windowInstance = null;
    }
    this.context.terminateSelf((error) => {
      if (error.code) {
        LogUtil.error(TAG, 'TerminateSelf failed, error.code: ' + JSON.stringify(error.code) +
          ' error.message: ' + JSON.stringify(error.message));
        return;
      }
      LogUtil.info(TAG, 'CalculatorAbility terminateSelf');
    });
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    LogUtil.info(TAG, 'CalculatorAbility onWindowStageCreate');
    this.reLoadWindow(windowStage);
  }

  onWindowStageDestroy() {
    LogUtil.info(TAG, 'CalculatorAbility onWindowStageDestroy');
  }

  async reLoadWindow(windowStage: window.WindowStage): Promise<void> {
    try {
      let windowIns: window.Window = windowStage.getMainWindowSync();
      AppStorage.setOrCreate('isMainPageReport', true);

      await windowIns.setPreferredOrientation(window.Orientation.PORTRAIT);
      await windowIns.setWindowSystemBarEnable(['status', 'navigation']);
      await windowIns.setWindowLayoutFullScreen(true);
      let topArea: window.AvoidArea = windowIns.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      CommonUtil.updateTopSafeHeight(topArea.topRect.height);
      let bottomArea: window.AvoidArea = windowIns.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      CommonUtil.updateBottomSafeHeight(bottomArea.bottomRect.height);

      let properties: window.WindowProperties = windowIns.getWindowProperties();
      let rect: window.Rect = properties.windowRect;
      if (rect === null || rect.width === 0 || rect.height === 0) {
        this.reLoadWindow(windowStage);
        return;
      }
      CommonUtil.updateWindowSize({
        width: rect.width,
        height: rect.height
      } as window.Size);
      if (this.windowInstance) {
        this.unRegisterWindowCallBack(this.windowInstance);
        this.windowInstance = null;
      }
      this.windowInstance = windowIns;
      GlobalThisHelper.set('mainWindow', windowIns);
      this.registerWindowCallBack(windowIns);
      windowStage.loadContent('pages/main', (err) => {
        if (err.code) {
          LogUtil.error(TAG, `Failed to load the content. Cause: ${err.message}`);
          return;
        }
        LogUtil.info(TAG, 'Succeeded in loading the content.');
      });
    } catch (err) {
      LogUtil.error(TAG, `Failed to obtain the windowMainClass properties. Cause: ${err?.message}`);
    }
  }

  onConfigurationUpdate(newConfig: Configuration): void {
    LogUtil.error(TAG, 'onConfigurationUpdate: ' + JSON.stringify(newConfig));
    AppStorage.setOrCreate('localString', newConfig.language);
    this.changeStatusBarContentColor(newConfig.colorMode);
  }

  private changeStatusBarContentColor(mode: ConfigurationConstant.ColorMode | undefined): void {
    if (mode === ConfigurationConstant.ColorMode.COLOR_MODE_DARK) {
      this.windowInstance?.setWindowSystemBarProperties({
        statusBarContentColor: WHITE,
      });
    } else if (mode === ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT) {
      this.windowInstance?.setWindowSystemBarProperties({
        statusBarContentColor: BLACK,
      });
    } else {
      LogUtil.info(TAG, 'Current mode is not dark or light');
    }
  }

  private registerWindowCallBack(windowInstance: window.Window): void {
    try {
      windowInstance.on('windowSizeChange', (windowSize) => {
        CommonUtil.updateWindowSize(windowSize)
      })
    } catch (exception) {
      LogUtil.error(TAG, 'Failed to enable the listener for system window size changes.');
    }
  }

  private unRegisterWindowCallBack(windowInstance: window.Window): void {
    try {
      windowInstance.off('windowSizeChange', () => {
      });
    } catch (exception) {
      LogUtil.error(TAG, 'Failed to off the listener for window.');
    }
  }
}