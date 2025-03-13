/*
 * Copyright (c) 2023-2024 Huawei Device Co., Ltd.
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

import UIAbility from '@ohos.app.ability.UIAbility';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { Hypium, coverageCollectHelp } from '@ohos/hypium';
import Window from '@ohos.window';
import Want from '@ohos.app.ability.Want';
import AbilityConstant from '@ohos.app.ability.AbilityConstant';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { LogUtil, RdbHelper } from '@hmos/common';
import { DigitPanelController } from '@hmos/calculation';
import testsuite from '../test/List.test';

const DELEGATOR: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator();
const TAG: string = 'TestAbility';

/**
 * Calculator Test Ability
 *
 * @since 2023-07-15
 */
export default class TestAbility extends UIAbility {
  private mDigitPanelController: DigitPanelController = DigitPanelController.getInstance();
  private mRdbHelper: RdbHelper = RdbHelper.getInstance();

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    LogUtil.info(TAG, 'TestAbility onCreate');
    this.mDigitPanelController = DigitPanelController.getInstance();
    this.mRdbHelper = RdbHelper.getInstance();
    let abilityDelegator: AbilityDelegatorRegistry.AbilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
    let abilityDelegatorArguments: AbilityDelegatorRegistry.AbilityDelegatorArgs = AbilityDelegatorRegistry
      .getArguments();
    LogUtil.info(TAG, 'start run testcase!!!');
    coverageCollectHelp.setSavePath('/data/storage/el2/base/js_coverage.json');
    let uid: number =
      Math.floor(AbilityDelegatorRegistry.getAbilityDelegator().getAppContext().applicationInfo.uid / 200000);
    const bundleName: string = AbilityDelegatorRegistry.getArguments().bundleName;
    let readPath: string = '/data/app/el2/' + uid + '/base/' + bundleName + '/js_coverage.json';
    coverageCollectHelp.setReadPath(readPath);
    Hypium.hypiumTest(abilityDelegator, abilityDelegatorArguments, testsuite);

  }

  onDestroy(): void {
    LogUtil.info(TAG, 'TestAbility onDestroy');
  }

  onWindowStageCreate(windowStage: Window.WindowStage): void {
    LogUtil.info(TAG, 'CalculatorAbility onWindowStageCreate');
    this.reLoadWindow(windowStage);
  }

  async reLoadWindow(windowStage: Window.WindowStage): Promise<void> {
    try {
      await DELEGATOR.startAbility({
        'bundleName': 'com.ohos.calculator',
        'abilityName': 'CalculatorAbility',
      }).then(() => {
        LogUtil.info('com.ohos.calculator.CalculatorAbility start success');      });
    } catch (exception) {
      LogUtil.error('Failed to startAbility');
    }
  }
}