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
import UIAbility from '@ohos.app.ability.UIAbility';
import { GlobalThisHelper, LogUtil } from '@hmos/common';

const TAG: string = 'CalculatorAbility';

export default class CalculatorAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    LogUtil.info(TAG, 'CalculatorAbility onCreate');
  }

  onDestroy(): void {
    LogUtil.info(TAG, 'CalculatorAbility onDestroy');
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
      GlobalThisHelper.set('mainWindow', windowIns);
      windowIns.setUIContent('pages/main', (err) => {
        if (err.code) {
          LogUtil.error(TAG, 'Failed to load the content. Cause:', err.message);
          return;
        }
        LogUtil.info(TAG, 'Succeeded in loading the content.');
      });
    } catch (err) {
      LogUtil.error(TAG, 'Failed to obtain the windowMainClass properties. Cause: ', err?.message);
    };
  }
};