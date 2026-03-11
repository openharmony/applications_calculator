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

import { ON, Driver, Component } from '@ohos.UiTest';
import {
  describe,
  beforeEach,
  beforeAll,
  afterAll,
  it,
  expect,
} from '@ohos/hypium';

const DELAY_LONG_TIME: number = 3000; // waiting for page
const DELAY_INTERVAL_TIME: number = 300; // interval between function call

/**
 * Calculation testcases
 *
 * @since 2023-12-05
 */
export default function CalculationPartTwoTest() {
  describe('CalculationPartTwoTest', () => {
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
    });

    /**
     * @tc.number: calculationPartTwoTest_001
     * @tc.name: 测试大数乘法计算
     * @tc.type: 0
     * @tc.desc: 1、输入1,324,657,809,641,794 * 9,423,154,647,480 2、观察结果
     */
    it('calculationPartTwoTest_001', 0, async () => {
      /**
       * @tc.steps: step1. 输入1,324,657,809,641,794 * 9,423,154,647,480
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为1.24824553952e+29
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('1.24824553952e+29');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_002
     * @tc.name: 测试大数除法计算
     * @tc.type: 0
     * @tc.desc: 1、输入123,456,789,482,486 ÷ 678,426,016,356,886 2、观察结果
     */
    it('calculationPartTwoTest_002', 0, async () => {
      /**
       * @tc.steps: step1. 输入123,456,789,482,486 ÷ 678,426,016,356,886
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为0.181975317139874
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.181975317139874');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_003
     * @tc.name: 测试大数加法计算
     * @tc.type: 0
     * @tc.desc: 1、输入123,456,789,643,179 + 854,779,868,187,823 2、观察结果
     */
    it('calculationPartTwoTest_003', 0, async () => {
      /**
       * @tc.steps: step1. 输入123,456,789,643,179 + 854,779,868,187,823
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为978,236,657,831,002
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('978,236,657,831,002');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_004
     * @tc.name: 测试大数减法计算
     * @tc.type: 0
     * @tc.desc: 1、输入123,789,456,117,911 - 654,212,697,548,330 2、观察结果
     */
    it('calculationPartTwoTest_004', 0, async () => {
      /**
       * @tc.steps: step1. 输入123,789,456,117,911 - 654,212,697,548,330
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const minus = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为-530,423,241,430,419
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('-530,423,241,430,419');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_005
     * @tc.name: 测试小数乘法计算
     * @tc.type: 0
     * @tc.desc: 1、输入0.0000000000001 * 0.0000000000002 2、观察结果
     */
    it('calculationPartTwoTest_005', 0, async () => {
      /**
       * @tc.steps: step1. 输入0.0000000000001 * 0.0000000000002
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      for (let index = 0; index < 12; index++) {
        await zero.click();
        await driver.delayMs(DELAY_INTERVAL_TIME);
      }

      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      for (let index = 0; index < 12; index++) {
        await zero.click();
        await driver.delayMs(DELAY_INTERVAL_TIME);
      }

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为2e-26
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('2e-26');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_006
     * @tc.name: 测试极小数除法计算
     * @tc.type: 0
     * @tc.desc: 1、输入0.0000000000001 ÷ 0.0000000000002 2、观察结果
     */
    it('calculationPartTwoTest_006', 0, async () => {
      /**
       * @tc.steps: step1. 输入0.0000000000001 ÷ 0.0000000000002
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      for (let index = 0; index < 12; index++) {
        await zero.click();
        await driver.delayMs(DELAY_INTERVAL_TIME);
      }

      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_13'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      for (let index = 0; index < 12; index++) {
        await zero.click();
        await driver.delayMs(DELAY_INTERVAL_TIME);
      }

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为0.5
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.5');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_007
     * @tc.name: 测试极小数加法计算
     * @tc.type: 0
     * @tc.desc: 1、输入0.0000000000001 + 0.0000000000002 2、观察结果
     */
    it('calculationPartTwoTest_007', 0, async () => {
      /**
       * @tc.steps: step1. 输入0.0000000000001 + 0.0000000000002
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      for (let index = 0; index < 12; index++) {
        await zero.click();
        await driver.delayMs(DELAY_INTERVAL_TIME);
      }

      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      for (let index = 0; index < 12; index++) {
        await zero.click();
        await driver.delayMs(DELAY_INTERVAL_TIME);
      }

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为3e-13
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('3e-13');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_008
     * @tc.name: 测试极小数减法计算
     * @tc.type: 0
     * @tc.desc: 1、输入0.0000000000001 － 0.0000000000002 2、观察结果
     */
    it('calculationPartTwoTest_008', 0, async () => {
      /**
       * @tc.steps: step1. 输入0.0000000000001 - 0.0000000000002
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      for (let index = 0; index < 12; index++) {
        await zero.click();
        await driver.delayMs(DELAY_INTERVAL_TIME);
      }

      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const minus = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      for (let index = 0; index < 12; index++) {
        await zero.click();
        await driver.delayMs(DELAY_INTERVAL_TIME);
      }

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为-1e-13
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('-1e-13');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_009
     * @tc.name: 测试小数乘法计算
     * @tc.type: 0
     * @tc.desc: 1、输入0.123,789,456,117,911 - 0.654,212,697,548,330 2、观察结果
     */
    it('calculationPartTwoTest_009', 0, async () => {
      /**
       * @tc.steps: step1. 输入0.123,789,456,117,911 - 0.654,212,697,548,330
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为0.080984634014939
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.080984634014939');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_010
     * @tc.name: 测试小数除法计算
     * @tc.type: 0
     * @tc.desc: 1、输入0.123,789,456 ÷ 0.654 2、观察结果
     */
    it('calculationPartTwoTest_010', 0, async () => {
      /**
       * @tc.steps: step1. 输入0.123,789,456 ÷ 0.654
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为0.189280513761467
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.189280513761467');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_011
     * @tc.name: 测试小数加法计算
     * @tc.type: 0
     * @tc.desc: 1、输入0.123,789 + 0.654 2、观察结果
     */
    it('calculationPartTwoTest_011', 0, async () => {
      /**
       * @tc.steps: step1. 输入0.123,789 + 0.456
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为0.271467105263157
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.271467105263157');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_012
     * @tc.name: 测试小数减法计算
     * @tc.type: 0
     * @tc.desc: 1、输入0.123,654 - 0.789 2、观察结果
     */
    it('calculationPartTwoTest_012', 0, async () => {
      /**
       * @tc.steps: step1. 输入0.123,456 - 0.789
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为0.156471482889733
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0.156471482889733');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_013
     * @tc.name: 测试MR功能，精度无丢失
     * @tc.type: 0
     * @tc.desc: 1、输入1.7，点击m+，记忆该数据 2、然后点击c清零，再输入8.2，点击m+，记忆结果 3、最后点击mr显示结果
     */
    it('calculationPartTwoTest_013', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 输入1.7
       */
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击m+，记忆该数据
       */
      const mPlus = await driver.findComponent(ON.id('keyCode_20'));
      expect(mPlus).not().assertNull();
      await mPlus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 点击c清零
       */
      const clear = await driver.findComponent(ON.id('keyCode_16'));
      expect(clear).not().assertNull();
      await clear.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 再输入8.2
       */
      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 点击m+，记忆结果
       */
      await mPlus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step6. 点击mr,显示结果
       */
      const mr = await driver.findComponent(ON.id('keyCode_22'));
      expect(mr).not().assertNull();
      await mr.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step7. 验证结果，预期结果为9.9
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('9.9');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_014
     * @tc.name: 验证首位不可输入多个0
     * @tc.type: 0
     * @tc.desc: 1、点击计算器0000 2、验证结果，预期结果为0 3、点击c清零 4、点击计算器1000 5、验证结果，预期结果为1,000
     */
    it('calculationPartTwoTest_014', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 点击计算器0000
       */
      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期结果为0
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('0');
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 点击c清零
       */
      const clear = await driver.findComponent(ON.id('keyCode_16'));
      expect(clear).not().assertNull();
      await clear.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 点击计算器1000
       */
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 验证结果，预期结果为1,000
       */
      const txt: string = await result.getText();
      expect(txt).assertEqual('1,000');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_015
     * @tc.name: 计算结果与输入数值分隔符显示验证
     * @tc.type: 0
     * @tc.desc: 1、输入进行运算12,345+5 2、验证此时表达式与结果显示，预期表达式显示结果为12,345+5，结果显示为12,350  3、点击c清零
     * 4、输入进行运算123,456+12,345 5、验证此时表达式与结果显示，预期表达式显示结果为123,456+12,345，结果显示为135,801
     */
    it('calculationPartTwoTest_015', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 输入表达式12,345+5
       */
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证表达式显示，预期显示结果为12,345+5
       */
      const expression = await driver.findComponent(ON.id('id_global_exp'));
      expect(expression).not().assertNull();
      const mText: string = await expression.getText();
      expect(mText).assertEqual('12,345+5');
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期计算结果为12,350
       */
      const result = await driver.findComponent(ON.id('id_second_text'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('12,350');
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 点击c清零
       */
      const clear = await driver.findComponent(ON.id('keyCode_16'));
      expect(clear).not().assertNull();
      await clear.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 输入表达式123,456+12,345
       */
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step6. 验证表达式显示，预期显示结果为123,456+12,345
       */
      const mTxt: string = await expression.getText();
      expect(mTxt).assertEqual('123,456+12,345');
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step7. 验证结果，预期计算结果为135,801
       */
      const txt: string = await result.getText();
      expect(txt).assertEqual('135,801');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationPartTwoTest_016
     * @tc.name: 小数数值分隔符显示验证
     * @tc.type: 0
     * @tc.desc: 1、输入表达式1,234.123+1.1=进行计算 2、观察运算结果
     */
    it('calculationPartTwoTest_016', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      /**
       * @tc.steps: step1. 输入表达式1234.123+1.1
       */
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期计算结果为1,235.223
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('1,235.223');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });
  });
}