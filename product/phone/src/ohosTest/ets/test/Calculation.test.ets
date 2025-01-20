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

import { ON, Driver, Component } from '@ohos.UiTest';
import {
  describe,
  beforeEach,
  beforeAll,
  afterAll,
  it,
  expect,
} from '@ohos/hypium';
import constant from '@ohos.bluetooth.constant';

const DELAY_INTERVAL_TIME: number = 300; // interval between function call

/**
 * Calculation testcases
 *
 * @since 2023-12-05
 */
export default function CalculationPartOneTest() {
  describe('CalculationPartOneTest', () => {
    const driver: Driver = Driver.create();

    beforeAll(async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let clearButton: Component = await driver.findComponent(ON.id('keyCode_16'));
      expect(clearButton).not().assertNull();
      await clearButton.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    afterAll(async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let clearButton: Component = await driver.findComponent(ON.id('keyCode_16'));
      expect(clearButton).not().assertNull();
      await clearButton.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    beforeEach(async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let clearButton: Component = await driver.findComponent(ON.id('keyCode_16'));
      expect(clearButton).not().assertNull();
      await clearButton.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let mc: Component = await driver.findComponent(ON.id('keyCode_19'));
      expect(mc).not().assertNull();
      await mc.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_001
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 19x(51-16)+64÷8=673
     */
    it('calculationTest_001', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 19x(51-16)+64÷8
       */
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const leftParentheses = await driver.findComponent(ON.id('keyCode_23'));
      expect(leftParentheses).not().assertNull();
      await leftParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const subtract = await driver.findComponent(ON.id('keyCode_15'));
      expect(subtract).not().assertNull();
      await subtract.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 验证结果，预期计算结果为673
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('673');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_002
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 109x(1+20%+10%+20%)x9=1,553.904
     */
    it('calculationTest_002', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 输入109x(1+20%+10%+20%)x9
       */
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const leftParentheses = await driver.findComponent(ON.id('keyCode_23'));
      expect(leftParentheses).not().assertNull();
      await leftParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const percent = await driver.findComponent(ON.id('keyCode_10'));
      expect(percent).not().assertNull();
      await percent.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await percent.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await percent.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 验证结果，预期计算结果为1,553.904
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('1,553.904');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_003
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG e=2.718281828459045
     */
    it('calculationTest_003', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 输入e
       */
      const e = await driver.findComponent(ON.id('keyCode_33'));
      expect(e).not().assertNull();
      await e.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为2.718281828459045
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('2.718281828459045');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_004
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG π=3.141592653589793
     */
    it('calculationTest_004', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 输入π
       */
      const e = await driver.findComponent(ON.id('keyCode_44'));
      expect(e).not().assertNull();
      await e.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为3.141592653589793
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('3.141592653589793');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_005
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG In(ex)9=9 (备注:输入In后，点击lnv按钮切换键盘后)
     */
    it('calculationTest_005', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 输入In(ex)9
       */
      const maturalLogarithm = await driver.findComponent(ON.id('keyCode_34'));
      expect(maturalLogarithm).not().assertNull();
      await maturalLogarithm.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      //TODO

      /**
       * @tc.steps: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为9
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('9');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_006
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG log(100)=2
     */
    it('calculationTest_006', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);


      /**
       * @tc.steps: step3. 输入log(100)
       */
      const log = await driver.findComponent(ON.id('keyCode_35'));
      expect(log).not().assertNull();
      await log.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为2
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('2');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_007
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG 1+sin(30)cos(60)-tan(45）=0.321238953302848
     */
    it('calculationTest_007', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 1+sin(30)cos(60)-tan(45）
       */
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const add = await driver.findComponent(ON.id('keyCode_12'));
      expect(add).not().assertNull();
      await add.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sin=await driver.findComponent(ON.id('keyCode_36'));
      expect(sin).not().assertNull();
      await sin.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const cos = await driver.findComponent(ON.id('keyCode_37'));
      expect(cos).not().assertNull();
      await cos.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const subtract = await driver.findComponent(ON.id('keyCode_15'));
      expect(subtract).not().assertNull();
      await subtract.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const tan = await driver.findComponent(ON.id('keyCode_38'));
      expect(tan).not().assertNull();
      await tan.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step4: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为0.321238953302848
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.321238953302848');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_008
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG SIN-1(0.8)cos(30)=0.143036631850572
     */
    it('calculationTest_008', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 选中INV按钮
       */
      const invText = await driver.findComponent(ON.id('keyCode_45'));
      expect(invText).not().assertNull();
      await invText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. SIN-1(0.8)cos(30)
       */
      const aSin=await driver.findComponent(ON.id('keyCode_39'));
      expect(aSin).not().assertNull();
      await aSin.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const point = await driver.findComponent(ON.id('keyCode_11'));
      expect(point).not().assertNull();
      await point.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await invText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const cos = await driver.findComponent(ON.id('keyCode_37'));
      expect(cos).not().assertNull();
      await cos.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step5. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step6. 验证结果，预期计算结果为0.143036631850572
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.143036631850572');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    it('calculationTest_009', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. √25
       */
      const squareRooting = await driver.findComponent(ON.id('keyCode_31'));
      expect(squareRooting).not().assertNull();
      await squareRooting.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为5
       */
      const result = await driver.findComponent(ON.id(''));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('5');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_010
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG 9!=362,880
     */
    it('calculationTest_010', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step3. 9!
       */
      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const factorial = await driver.findComponent(ON.id('keyCode_30'));
      expect(factorial).not().assertNull();
      await factorial.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为362,880
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('362,880');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_011
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG 64(y√x)3=4
     */
    it('calculationTest_011', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 64(y√x)3
       */
      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const cubeRooting = await driver.findComponent(ON.id('keyCode_32'));
      expect(cubeRooting).not().assertNull();
      await cubeRooting.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为4
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('4');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_012
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG cos(π÷2)=0
     */
    it('calculationTest_012', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. cos(π÷2)
       */
      const cos = await driver.findComponent(ON.id('keyCode_37'));
      expect(cos).not().assertNull();
      await cos.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const pie = await driver.findComponent(ON.id('keyCode_44'));
      expect(pie).not().assertNull();
      await pie.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为0
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_013
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG sin(π÷2)=1
     */
    it('calculationTest_013', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. sin(π÷2)
       */
      const sin = await driver.findComponent(ON.id('keyCode_36'));
      expect(sin).not().assertNull();
      await sin.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const pie = await driver.findComponent(ON.id('keyCode_44'));
      expect(pie).not().assertNull();
      await pie.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为1
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('1');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_014
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG tan(π÷4)=1
     */
    it('calculationTest_014', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. tan(π÷4)
       */
      const tan = await driver.findComponent(ON.id('keyCode_38'));
      expect(tan).not().assertNull();
      await tan.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const pie = await driver.findComponent(ON.id('keyCode_44'));
      expect(pie).not().assertNull();
      await pie.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为1
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('1');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_015
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG 100(1/x）=0.01
     */
    it('calculationTest_015', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step3. 100(1/x）
       */
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const inverseProPorTioMal = await driver.findComponent(ON.id('keyCode_28'));
      expect(inverseProPorTioMal).not().assertNull();
      await inverseProPorTioMal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为0.01
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.01');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_016
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG 12(x2)==144
     */
    it('calculationTest_016', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 12(x2)
       */
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const squared = await driver.findComponent(ON.id('keyCode_25'));
      expect(squared).not().assertNull();
      await squared.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为144
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('144');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_017
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG 11(x3)==1331
     */
    it('calculationTest_017', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step3. 11(x3)
       */
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const cube = await driver.findComponent(ON.id('keyCode_27'));
      expect(cube).not().assertNull();
      await cube.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为1331
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();

      expect(text).assertEqual('1331');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_018
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG 9(xY)4===6561
     */
    it('calculationTest_018', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 9(xY)4
       */
      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const power = await driver.findComponent(ON.id('keyCode_29'));
      expect(power).not().assertNull();
      await power.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为6561
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();

      expect(text).assertEqual('6561');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_019
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG 输入定义域不在[-1，1]之间的反函数进行
     *           计算:如SIN-1(2)显示结果为错误
     */
    it('calculationTest_019', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 选中INV按钮
       */
      const invText = await driver.findComponent(ON.id('keyCode_45'));
      expect(invText).not().assertNull();
      await invText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. SIN-1(2)
       */
      const aSin = await driver.findComponent(ON.id('keyCode_39'));
      expect(aSin).not().assertNull();
      await aSin.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为错误
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('错误');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_020
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG 6x!cos 显示结果为错误
     */
    it('calculationTest_020', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 6x!cos
       */
      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const factorial = await driver.findComponent(ON.id('keyCode_30'));
      expect(factorial).not().assertNull();
      await factorial.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const cos = await driver.findComponent(ON.id('keyCode_37'));
      expect(cos).not().assertNull();
      await cos.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为错误
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('错误');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_021
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG 9x2-( 显示结果为错误
     */
    it('calculationTest_021', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 9x2-(
       */
      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const subtract = await driver.findComponent(ON.id('keyCode_15'));
      expect(subtract).not().assertNull();
      await subtract.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const leftParentheses = await driver.findComponent(ON.id('keyCode_23'));
      expect(leftParentheses).not().assertNull();
      await leftParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为错误
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('错误');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_022
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG 8x2sin(30) 显示结果为16
     */
    it('calculationTest_022', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 8x2sin(30)
       */
      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sin = await driver.findComponent(ON.id('keyCode_36'));
      expect(sin).not().assertNull();
      await sin.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为16
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('16');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_023
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG  选中INV按钮 cos-1(0.8) 显示结果为0.643501108793284
     */
    it('calculationTest_023', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 选中INV按钮
       */
      const inv = await driver.findComponent(ON.id('keyCode_45'));
      expect(inv).not().assertNull();
      await inv.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. cos-1(0.8)
       */
      const aCos = await driver.findComponent(ON.id('keyCode_40'));
      expect(aCos).not().assertNull();
      await aCos.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const point = await driver.findComponent(ON.id('keyCode_11'));
      expect(point).not().assertNull();
      await point.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为0.643501108793284
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.643501108793284');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_024
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG  选中INV按钮 TAN-1(0.8) 显示结果为0.674740942223552
     */
    it('calculationTest_024', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 选中INV按钮
       */
      const inv = await driver.findComponent(ON.id('keyCode_45'));
      expect(inv).not().assertNull();
      await inv.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. TAN-1(0.8)
       */
      const aTan = await driver.findComponent(ON.id('keyCode_41'));
      expect(aTan).not().assertNull();
      await aTan.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const point = await driver.findComponent(ON.id('keyCode_11'));
      expect(point).not().assertNull();
      await point.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step5. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step6. 验证结果，预期计算结果为0.674740942223552
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.674740942223552');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_025
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG  选中INV按钮 4SIN-1(0.8)COS-1
     *           (0.4) 显示结果为4.299977275223672
     */
    it('calculationTest_025', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为DEG
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 选中INV按钮
       */
      const inv = await driver.findComponent(ON.id('keyCode_45'));
      expect(inv).not().assertNull();
      await inv.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 4SIN-1(0.8)COS-1(0.4)
       */
      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const aSin = await driver.findComponent(ON.id('keyCode_39'));
      expect(aSin).not().assertNull();
      await aSin.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const point = await driver.findComponent(ON.id('keyCode_11'));
      expect(point).not().assertNull();
      await point.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const aCos = await driver.findComponent(ON.id('keyCode_40'));
      expect(aCos).not().assertNull();
      await aCos.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await point.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step5. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step6. 验证结果，预期计算结果为4.299977275223672
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('4.299977275223672');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_026
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为角度计算，键盘显示为RAD cos(π÷2)=0.999624216859481
     */
    it('calculationTest_026', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为RAD
       */
      const radText = await driver.findComponent(ON.id('keyCode_47'));
      expect(radText).not().assertNull();
      await radText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. cos(π÷2)
       */
      const cos = await driver.findComponent(ON.id('keyCode_37'));
      expect(cos).not().assertNull();
      await cos.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const pie = await driver.findComponent(ON.id('keyCode_44'));
      expect(pie).not().assertNull();
      await pie.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为0.999624216859481
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.999624216859481');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_027
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为角度计算，键盘显示为RAD sin(π÷2)=0.027412133592044
     */
    it('calculationTest_027', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为RAD
       */
      const radText = await driver.findComponent(ON.id('keyCode_47'));
      expect(radText).not().assertNull();
      await radText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);


      /**
       * @tc.steps: step3. sin(π÷2)
       */
      const sin = await driver.findComponent(ON.id('keyCode_36'));
      expect(sin).not().assertNull();
      await sin.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const pie = await driver.findComponent(ON.id('keyCode_44'));
      expect(pie).not().assertNull();
      await pie.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为0.027412133592044
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.027412133592044');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_028
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为角度计算，键盘显示为RAD tan(π÷4)=0.013708642534394
     */
    it('calculationTest_028', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为RAD
       */
      const radText = await driver.findComponent(ON.id('keyCode_47'));
      expect(radText).not().assertNull();
      await radText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. tan(π÷4)
       */
      const tan = await driver.findComponent(ON.id('keyCode_38'));
      expect(tan).not().assertNull();
      await tan.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const pie = await driver.findComponent(ON.id('keyCode_44'));
      expect(pie).not().assertNull();
      await pie.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为0.013708642534394
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.013708642534394');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_029
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为角度计算，键盘显示为RAD SIN(30)=0.5
     */
    it('calculationTest_029', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为RAD
       */
      const radText = await driver.findComponent(ON.id('keyCode_47'));
      expect(radText).not().assertNull();
      await radText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. SIN(30)
       */
      const sin = await driver.findComponent(ON.id('keyCode_36'));
      expect(sin).not().assertNull();
      await sin.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为0.5
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.5');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_030
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG SIN(30)=-0.98803162409286
     */
    it('calculationTest_030', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为RAD
       */
      const degText = await driver.findComponent(ON.id('keyCode_46'));
      expect(degText).not().assertNull();
      await degText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. SIN(30)
       */
      const sin = await driver.findComponent(ON.id('keyCode_36'));
      expect(sin).not().assertNull();
      await sin.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为-0.98803162409286
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('-0.98803162409286');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_031
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为角度计算，键盘显示为RAD 1+sin(30)cos(60)-tan(45)=0.25
     */
    it('calculationTest_031', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为RAD
       */
      const radText = await driver.findComponent(ON.id('keyCode_47'));
      expect(radText).not().assertNull();
      await radText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 1+sin(30)cos(60)-tan(45)
       */
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const add = await driver.findComponent(ON.id('keyCode_12'));
      expect(add).not().assertNull();
      await add.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sin = await driver.findComponent(ON.id('keyCode_36'));
      expect(sin).not().assertNull();
      await sin.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const cos = await driver.findComponent(ON.id('keyCode_37'));
      expect(cos).not().assertNull();
      await cos.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const subtract = await driver.findComponent(ON.id('keyCode_6'));
      expect(subtract).not().assertNull();
      await subtract.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const tan = await driver.findComponent(ON.id('keyCode_38'));
      expect(tan).not().assertNull();
      await tan.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为0.25
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.25');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });
    /**
     * @tc.number: calculationTest_032
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 角函数为弧度计算，键盘显示为RAD SIN-1(0.8)cos(30)=46.01201834436649
     */
    it('calculationTest_032', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为RAD
       */
      const radText = await driver.findComponent(ON.id('keyCode_47'));
      expect(radText).not().assertNull();
      await radText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 选中INV按钮
       */
      const invText = await driver.findComponent(ON.id('keyCode_45'));
      expect(invText).not().assertNull();
      await invText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. SIN-1(0.8)cos(30)
       */
      const aSin=await driver.findComponent(ON.id('keyCode_39'));
      expect(aSin).not().assertNull();
      await aSin.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const point = await driver.findComponent(ON.id('keyCode_11'));
      expect(point).not().assertNull();
      await point.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await invText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const cos = await driver.findComponent(ON.id('keyCode_37'));
      expect(cos).not().assertNull();
      await cos.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_37'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step4. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期计算结果为46.01201834436649
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('46.01201834436649');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_033
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为角度计算，键盘显示为RAD  选中INV按钮 cos-1(0.8) 显示结果为36.86989764584401
     */
    it('calculationTest_033', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为RAD
       */
      const radText = await driver.findComponent(ON.id('keyCode_47'));
      expect(radText).not().assertNull();
      await radText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 选中INV按钮
       */
      const invText = await driver.findComponent(ON.id('keyCode_45'));
      expect(invText).not().assertNull();
      await invText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. cos-1(0.8)
       */
      const aCos = await driver.findComponent(ON.id('keyCode_40'));
      expect(aCos).not().assertNull();
      await aCos.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const point = await driver.findComponent(ON.id('keyCode_11'));
      expect(point).not().assertNull();
      await point.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step5. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step6. 验证结果，预期计算结果为36.86989764584401
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('36.86989764584401');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_034
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为弧度计算，键盘显示为DEG  选中INV按钮 SIN-1(0.8) 显示结果为0.92729518001612
     */
    it('calculationTest_034', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为RAD
       */
      const radText = await driver.findComponent(ON.id('keyCode_47'));
      expect(radText).not().assertNull();
      await radText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 选中INV按钮
       */
      const invText = await driver.findComponent(ON.id('keyCode_45'));
      expect(invText).not().assertNull();
      await invText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. SIN-1(0.8)
       */
      const aSin = await driver.findComponent(ON.id('keyCode_39'));
      expect(aSin).not().assertNull();
      await aSin.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const point = await driver.findComponent(ON.id('keyCode_11'));
      expect(point).not().assertNull();
      await point.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step5. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step6. 验证结果，预期计算结果为0.92729518001612
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.92729518001612');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_035
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为角度计算，键盘显示为RAD  选中INV按钮 SIN-1(0.8) 显示结果为53.13010235415599
     */
    it('calculationTest_035', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为RAD
       */
      const radText = await driver.findComponent(ON.id('keyCode_47'));
      expect(radText).not().assertNull();
      await radText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 选中INV按钮
       */
      const invText = await driver.findComponent(ON.id('keyCode_45'));
      expect(invText).not().assertNull();
      await invText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. SIN-1(0.8)
       */
      const aSin = await driver.findComponent(ON.id('keyCode_39'));
      expect(aSin).not().assertNull();
      await aSin.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const point = await driver.findComponent(ON.id('keyCode_11'));
      expect(point).not().assertNull();
      await point.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step5. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step6. 验证结果，预期计算结果为53.13010235415599
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('53.13010235415599');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_036
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为角度计算，键盘显示为RAD  选中INV按钮 TAN-1(0.8) 显示结果为38.65980825409009
     */
    it('calculationTest_036', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为RAD
       */
      const radText = await driver.findComponent(ON.id('keyCode_47'));
      expect(radText).not().assertNull();
      await radText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 选中INV按钮
       */
      const invText = await driver.findComponent(ON.id('keyCode_45'));
      expect(invText).not().assertNull();
      await invText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. TAN-1(0.8)
       */
      const aTan = await driver.findComponent(ON.id('keyCode_41'));
      expect(aTan).not().assertNull();
      await aTan.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const point = await driver.findComponent(ON.id('keyCode_11'));
      expect(point).not().assertNull();
      await point.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step5. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step6. 验证结果，预期计算结果为38.65980825409009
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('38.65980825409009');
      await driver.delayMs(DELAY_INTERVAL_TIME);

    });

    /**
     * @tc.number: calculationTest_037
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 手机切换为横屏 三角函数为角度计算，键盘显示为RAD  选中INV按钮 4SIN-1(0.8)COS-1
     *           (0.4) 显示结果为14,115.99270401047
     */
    it('calculationTest_037', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 手机切换为横屏
       */
      const sci = await driver.findComponent(ON.id('id_more_menu'));
      expect(sci).not().assertNull();
      await sci.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const sciMenu = await driver.findComponent(ON.id('id_index_title_bar_std'));
      expect(sciMenu).not().assertNull();
      await sciMenu.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step2. 三角函数为弧度计算，键盘显示为RAD
       */
      const radText = await driver.findComponent(ON.id('keyCode_47'));
      expect(radText).not().assertNull();
      await radText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 选中INV按钮
       */
      const invText = await driver.findComponent(ON.id('keyCode_45'));
      expect(invText).not().assertNull();
      await invText.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 4SIN-1(0.8)COS-1(0.4)
       */
      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const aSin = await driver.findComponent(ON.id('keyCode_39'));
      expect(aSin).not().assertNull();
      await aSin.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const point = await driver.findComponent(ON.id('keyCode_11'));
      expect(point).not().assertNull();
      await point.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const rightParentheses = await driver.findComponent(ON.id('keyCode_24'));
      expect(rightParentheses).not().assertNull();
      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const aCos = await driver.findComponent(ON.id('keyCode_40'));
      expect(aCos).not().assertNull();
      await aCos.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await point.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await rightParentheses.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.step: step5. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step6. 验证结果，预期计算结果为14,115.99270401047
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('14,115.99270401047');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });
  });
}
