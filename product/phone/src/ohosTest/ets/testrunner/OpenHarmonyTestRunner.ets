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

import { BusinessError } from '@ohos.base';
import TestRunner from '@ohos.application.testRunner';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { LogUtil } from '@hmos/common';

const TAG: string = 'TestRunner';

/**
 * Test Runner for unit-test
 *
 * @since 2023-07-19
 */
export default class OpenHarmonyTestRunner implements TestRunner {
  constructor() {
  }

  onPrepare(): void {
    LogUtil.info(TAG, 'OpenHarmonyTestRunner OnPrepare ');
  }

  async onRun(): Promise<void> {
    LogUtil.info(TAG, 'OpenHarmonyTestRunner onRun run');
    let abilityDelegatorArguments: AbilityDelegatorRegistry.AbilityDelegatorArgs =
      AbilityDelegatorRegistry.getArguments();
    let abilityDelegator: AbilityDelegatorRegistry.AbilityDelegator =
      AbilityDelegatorRegistry.getAbilityDelegator();
    let testAbilityName: string = abilityDelegatorArguments.bundleName + '.TestAbility';
    let lMonitor: AbilityDelegatorRegistry.AbilityMonitor = {
      abilityName: testAbilityName,
      onAbilityCreate: onAbilityCreateCallback,
    };
    abilityDelegator.addAbilityMonitor(lMonitor, addAbilityMonitorCallback);
    let cmd: string = 'aa start -d 0 -a TestAbility' + ' -b ' + abilityDelegatorArguments.bundleName;
    let debug: string = abilityDelegatorArguments.parameters['-D'];
    if (debug === 'true') {
      cmd += ' -D';
    }
    LogUtil.info(TAG, 'cmd : ', cmd);
    abilityDelegator.executeShellCommand(cmd, (err, result) => {
      LogUtil.info(TAG, 'executeShellCommand : err :', JSON.stringify(err) ?? '');
      LogUtil.info(TAG, 'executeShellCommand : data :', JSON.stringify(result) ?? '');
    });
    LogUtil.info(TAG, 'OpenHarmonyTestRunner onRun end');
  }
}

async function onAbilityCreateCallback(): Promise<void> {
  LogUtil.info(TAG, 'onAbilityCreateCallback');
}

async function addAbilityMonitorCallback(err: BusinessError): Promise<void> {
  LogUtil.info(TAG, 'addAbilityMonitorCallback', JSON.stringify(err) ?? '');
}