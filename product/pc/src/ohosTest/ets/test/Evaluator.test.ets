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

import worker from '@ohos.worker';
import { Driver } from '@ohos.UiTest';
import {
  describe,
  beforeAll,
  it,
  expect,
} from '@ohos/hypium';
import {
  CalculatorState,
  Evaluator,
  KeyCode,
  PhysicsButtonInfo,
} from '@hmos/calculation';

const DELAY_INTERVAL_TIME: number = 300; // interval between function call
const ERROR_CODE: string = 'error';
const workerInstance: worker.ThreadWorker = new worker.ThreadWorker('../../../main/ets/workers/worker.ts');

/**
 * Evaluator testcases
 *
 * @since 2024-02-21
 */
export default function EvaluatorTest() {
  describe('EvaluatorTest', () => {
    const driver: Driver = Driver.create();
    let evaluator: Evaluator | null = null;

    beforeAll(async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator = new Evaluator(workerInstance);
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('evaluatorUndefined', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.addExpression(() => {
      }, undefined, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('evaluatorError', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_9;
      temp.keyText = '9';
      evaluator!.addExpression(() => {
      }, temp, ERROR_CODE);
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('evaluatorClear', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_CLEAR;
      temp.keyText = 'C';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('evaluatorEquals', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_EQUALS;
      temp.keyText = '=';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('evaluatorAddExpression_01', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_ADD;
      temp.keyText = '+';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('evaluatorAddExpression_02', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_9;
      temp.keyText = '9';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('setState_01', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.EVALUATE);
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('setState_02', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.ANIMATE);
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('setState_03', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('onClear', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.onClear();
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('updateMemoryDisplay', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_9;
      temp.keyText = '9';
      evaluator!.updateMemoryDisplay(temp, () => {
      });
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('getPreference', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.getPreference();
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('getMemoryDisplay_01', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.getPreference();
      let myPromise: Promise<boolean> = evaluator!.getMemoryDisplay();
      myPromise.then((flag) => {
        expect(flag).assertEqual(false);
      });
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });
  });
}