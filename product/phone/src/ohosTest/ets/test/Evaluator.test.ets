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
const KEYCODE_ADD: number = 12;
const workerInstance: worker.ThreadWorker = new worker.ThreadWorker('../../../main/ets/workers/worker.ts');

/**
 * Evaluator testcases
 *
 * @since 2023-11-11
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
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_ADD;
      temp.keyText = '+';
      evaluator!.addExpression(() => {
      }, temp, '');
    });

    it('evaluatorAddExpression_02', 0, async () => {
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_9;
      temp.keyText = '9';
      evaluator!.addExpression(() => {
      }, temp, '');
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
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_9;
      temp.keyText = '9';
      evaluator!.updateMemoryDisplay(temp, () => {
      });
    });

    it('getPreference', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.getPreference();
    });

    it('getMemoryDisplay_01', 0, async () => {
      evaluator!.getPreference();
      evaluator!.sharePreference = null;
      let myPromise: Promise<boolean> = evaluator!.getMemoryDisplay();
      myPromise.then((flag) => {
        expect(flag).assertEqual(true);
      });
    });

    it('getMemoryDisplay_02', 0, async () => {
      evaluator!.sharePreference = null;
      let myPromise: Promise<boolean> = evaluator!.getMemoryDisplay();
      myPromise.then((flag) => {
        expect(flag).assertEqual(true);
      });
    });

    it('isOperator_01', 0, async () => {
      let flag: boolean = evaluator!.isOperator(KEYCODE_ADD);
      expect(flag).assertEqual(true);
    });

    //新增 ZL
    it('updateMemoryDisplay_01', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_MEM_CLEAR;
      temp.keyText = '19';
      evaluator!.updateMemoryDisplay(temp, () => {
      });
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('updateMemoryDisplay_02', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_MEM_ADD;
      temp.keyText = '20';
      evaluator!.updateMemoryDisplay(temp, () => {
      });
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('updateMemoryDisplay_03', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_MEM_SUBTRACT;
      temp.keyText = '21';
      evaluator!.updateMemoryDisplay(temp, () => {
      });
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_01', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_0;
      temp.keyText = "0";
      evaluator!.addExpression(() => {
      }, temp, '%');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_02', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_PERCENT;
      temp.keyText = '%';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_03', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = 'error';
      evaluator!.addExpression(() => {
      }, temp, 'error');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addKeyboardValue_01',0, async () => {
      evaluator!.addExpression(()=>{},undefined,'C');
      evaluator!.addExpression(()=>{},undefined,'');
      evaluator!.addExpression(()=> {},undefined,'+');
      evaluator!.addExpression(()=> {},undefined,'1');
      evaluator!.addExpression(()=> {},undefined,'=');
      evaluator!.addExpression(()=> {},undefined,'.');
      evaluator!.addExpression(()=> {},undefined,'s');
      evaluator!.addExpression(()=> {},undefined,'k');
      expect(evaluator).not().assertNull();
      AppStorage,set('isSelectAll','true');
      evaluator!.addExpression(()=>{},undefined,'');
      let evaluator2: Evaluator = new Evaluator(workerInstance);
      evaluator2.setState(CalculatorState.RESULT)
      evaluator2.addExpression(()=> {},undefined,'%');
      evaluator2.setState(CalculatorState.RESULT)
      evaluator2.addExpression(()=> {},undefined,'^(2)');
      evaluator2.setState(CalculatorState.RESULT)
      evaluator2.addExpression(()=> {},undefined,'s');
      expect(evaluator2).not().assertNull();
      AppStorage.set('globalExpression','1.0213112323E+12123');
      evaluator2.setState(CalculatorState.RESULT)
      evaluator2.addExpression(()=> {},undefined,'');
      AppStorage.set('globalExpression','00000000001.0213112323E+12123');
      evaluator2.setState(CalculatorState.RESULT)
      evaluator2.addExpression(()=> {},undefined,'');
      AppStorage.set('globalExpression','1.0213112323E+12123');
      evaluator2.setState(CalculatorState.RESULT)
      evaluator2.addExpression(()=> {},undefined,'.');
      AppStorage.set('globalExpression','1.0213112323E+12123');
      AppStorage.setOrCreate('textInputIndex', 19);
      evaluator2.setState(CalculatorState.RESULT)
      evaluator2.addExpression(()=> {},undefined,'.');
      AppStorage.set('globalExpression','1.02');
      AppStorage.setOrCreate('textInputIndex', 4);
      evaluator2.setState(CalculatorState.RESULT)
      evaluator2.addExpression(()=> {},undefined,'+');
      AppStorage.set('globalExpression',undefined);
      evaluator2.setState(CalculatorState.RESULT)
      evaluator2.addExpression(()=> {},undefined,'+');

      AppStorage.set('globalExpression','12col(');
      AppStorage.setOrCreate('textInputIndex', 4);
      evaluator2.setState(CalculatorState.RESULT)
      evaluator2.addExpression(()=> {},undefined,'+');

      AppStorage.set('globalExpression','0.00100');
      AppStorage.setOrCreate('textInputIndex', 5);
      evaluator2.setState(CalculatorState.RESULT)
      evaluator2.addExpression(()=> {},undefined,'');

      AppStorage.set('globalExpression','123.+.0');
      AppStorage.setOrCreate('textInputIndex', 5);
      evaluator2.setState(CalculatorState.RESULT)
      evaluator2.addExpression(()=> {},undefined,'');
      AppStorage.set('globalExpression','123');
      AppStorage.setOrCreate('textInputIndex', 0);
      evaluator2.setState(CalculatorState.RESULT)
      evaluator2.addExpression(()=> {},undefined,'');
      AppStorage.set('globalExpression','1');
      AppStorage.setOrCreate('textInputIndex', 1);
      evaluator2.setState(CalculatorState.RESULT)
      evaluator2.addExpression(()=> {},undefined,'');
      expect(evaluator2).not().assertNull();



    })
    it('addExpression_04', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let expression="";
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_DEGREE;
      temp.keyText = 'deg';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_05', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let expression="expression";
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_RAD;
      temp.keyText = 'rad';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_06', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let expression="";
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_INVERSE_MATRIX;
      temp.keyText = 'Inv';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_07', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let expression="";
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_MEM_CLEAR;
      temp.keyText = 'MC';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_08', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let expression="";
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_MEM_ADD;
      temp.keyText = 'M+';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_09', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let expression="";
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_MEM_SUBTRACT;
      temp.keyText = 'M-';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_10', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let expression="";
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_MEM_RECOVERY;
      temp.keyText = 'MR';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_11', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let expression="";
      let isMemRecovery=true;
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_MEM_RECOVERY;
      temp.keyText = 'MR';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });


    it('addExpression_12', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let index  = 0;
      let isMemRecovery=true;
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_BACK;
      temp.keyText = '删';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_13', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let index  = 1;
      let expression="expression";
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_CLEAR;
      temp.keyText = 'C';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_13_01', 0, async () => {
      AppStorage.set('globalExpression','123.+.0');
      AppStorage.setOrCreate('textInputIndex', 0);
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_CLEAR;
      temp.keyText = 'C';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_14', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let expression="";
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_CLEAR;
      temp.keyText = 'C';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_15', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let index  = 0;
      let isMemRecovery=true;
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_CLEAR;
      temp.keyText = 'C';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });
    it('addExpression_15_1', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.ANIMATE);
      evaluator!.setGlobalExpression('')
      let index  = 1;
      let isMemRecovery=true;
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_BACK;
      temp.keyText = '删';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_15_1', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.INPUT);
      evaluator!.setGlobalExpression('')
      let index  = 1;
      let isMemRecovery=true;
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_DEGREE;
      temp.keyText = 'Deg';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_15_2', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.INPUT);
      evaluator!.setGlobalExpression('')
      let index  = 1;
      let isMemRecovery=true;
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_RAD;
      temp.keyText = 'Rad';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_16', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.INPUT);
      evaluator!.setGlobalExpression('')
      let index  = 1;
      let isMemRecovery=true;
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_BACK;
      temp.keyText = '删';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_17', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('')
      let index  = 1;
      let isMemRecovery=true;
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_BACK;
      temp.keyText = '删';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_17', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('')
      let index  = 1;
      let isMemRecovery=true;
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_BACK;
      temp.keyText = '删';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_18', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let expression="";
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyCode = KeyCode.KEYCODE_9;
      temp.keyText = '9';
      evaluator!.addExpression(() => {
      }, temp, "");
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_19', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = 'error';
      evaluator!.addExpression(() => {
      }, temp, 'error');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });
    // zhf补充
    it('addExpression_20', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.ERROR);
      let controller = new TextInputController();
      controller.caretPosition(8)
      evaluator!.setTextInputController(controller)
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = 'error';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_21', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('')
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = 'error';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_22', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('1.111+111')
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = '.';
      evaluator!.addExpression(() => {
      }, temp, '.');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_23', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('1.111+111(')
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = '.';
      evaluator!.addExpression(() => {
      }, temp, '.');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_24', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('1.111+111(')
      let controller = new TextInputController();
      controller.caretPosition(4)
      evaluator!.setTextInputController(controller)
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = '+';
      evaluator!.addExpression(() => {
      }, temp, '+');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });



    it('addExpression_25', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression(undefined)
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = '';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });
    it('addExpression_26', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression(this.context.resourceManager.getStringSync($r('app.string.invalid_input').id))
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = '';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });
    it('addExpression_26_1', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('1111+cos(123123)+213')
      let controller = new TextInputController();
      controller.caretPosition(6)
      evaluator!.setTextInputController(controller)
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = '1';
      evaluator!.addExpression(() => {
      }, temp, '1');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });
    it('addExpression_26_2', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('00000000001111+cos(123123)+213')
      let controller = new TextInputController();
      controller.caretPosition(1)
      evaluator!.setTextInputController(controller)
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = '0';
      evaluator!.addExpression(() => {
      }, temp, '0');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_27', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('0.2123123E1+000000001111+cos(123123)+213')
      let controller = new TextInputController();
      controller.caretPosition(1)
      evaluator!.setTextInputController(controller)
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = '0';
      evaluator!.addExpression(() => {
      }, temp, '0');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });



    it('addExpression_28', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('21+23')
      let controller = new TextInputController();
      controller.caretPosition(2)
      evaluator!.setTextInputController(controller)
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = '0';
      evaluator!.addExpression(() => {
      }, temp, '0');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_29', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('1.111+111(')
      let controller = new TextInputController();
      controller.caretPosition(4)
      evaluator!.setTextInputController(controller)
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = '+';
      evaluator!.addExpression(() => {
      }, temp, '+');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_30', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('0.2')
      let controller = new TextInputController();
      controller.caretPosition(1)
      evaluator!.setTextInputController(controller)
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = '0';
      evaluator!.addExpression(() => {
      }, temp, '0');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('addExpression_31', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('0.2')
      let controller = new TextInputController();
      controller.caretPosition(1)
      evaluator!.setTextInputController(controller)
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = '';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });
    it('addExpression_32', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('0.0002')
      let controller = new TextInputController();
      controller.caretPosition(1)
      evaluator!.setTextInputController(controller)
      let temp: PhysicsButtonInfo = new PhysicsButtonInfo();
      temp.keyText = '';
      evaluator!.addExpression(() => {
      }, temp, '');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });
    it('checkArithmeticExp', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('0.0002')

      evaluator!.checkArithmeticExp('-.1 2 3 4');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });
    it('checkArithmeticExp_01', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      evaluator!.setState(CalculatorState.RESULT);
      evaluator!.setGlobalExpression('0.0002')

      evaluator!.checkArithmeticExp('1 2 3 4');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });


  });
}