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
     * @tc.desc: 测试表达式8×9+1-7计算，预期得到66
     */
    it('calculationTest_001', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 输入8×9+1-7
       */
      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const minus = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期计算结果为66
       */
      const result = await driver.findComponent(ON.id('id_second_text'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('66');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_002
     * @tc.name: 测试mr功能
     * @tc.type: 0
     * @tc.desc: 1、输入一串数字如29，点击m+，点击C 2、输入计算式如7×9以数字结尾的算式，点击mr，预期：算式被清除，显示存储中的数据29
     */
    it('calculationTest_002', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 输入一串数字如29
       */
      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击m+
       */
      const mPlus = await driver.findComponent(ON.id('keyCode_20'));
      expect(mPlus).not().assertNull();
      await mPlus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 点击C,清除输入内容
       */
      const clearButton = await driver.findComponent(ON.id('keyCode_16'));
      expect(clearButton).not().assertNull();
      await clearButton.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 输入表达式7×9
       */
      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 点击mr
       */
      const mr = await driver.findComponent(ON.id('keyCode_22'));
      expect(mr).not().assertNull();
      await mr.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step6. 验证结果，预期：算式被清除，显示存储中的数据29
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('29');
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step7. 点击mc清空存储
       */
      const mc = await driver.findComponent(ON.id('keyCode_19'));
      expect(mc).not().assertNull();
      await mc.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_003
     * @tc.name: 测试mr功能
     * @tc.type: 0
     * @tc.desc: 1、点击c清空屏幕 2、点击mr 3、点击mc清空存储 预期：1、屏幕左侧无M标志 2、显示的默认存储为空
     */
    it('calculationTest_003', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 点击c清空屏幕
       */
      const clear = await driver.findComponent(ON.id('keyCode_16'));
      expect(clear).not().assertNull();
      await clear.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击mr
       */
      const mr = await driver.findComponent(ON.id('keyCode_22'));
      expect(mr).not().assertNull();
      await mr.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期：屏幕左侧无M标志
       */
      const memoryIcon = await driver.findComponent(ON.id('id_memory'));
      expect(memoryIcon).assertNull();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 点击mc清空存储
       */
      const mc = await driver.findComponent(ON.id('keyCode_19'));
      expect(mc).not().assertNull();
      await mc.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_004
     * @tc.name: 测试mr功能
     * @tc.type: 0
     * @tc.desc: 1、输入算式7+8，点击M- 2、点击mr 预期：1、显示屏左侧有M显示，表示有存储内容 2、显示为存储结果-15
     */
    it('calculationTest_004', 0, async () => {
      /**
       * @tc.steps: step1. 输入算式7+8
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击m-
       */
      const mMinus = await driver.findComponent(ON.id('keyCode_21'));
      expect(mMinus).not().assertNull();
      await mMinus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 点击mr
       */
      const mr = await driver.findComponent(ON.id('keyCode_22'));
      expect(mr).not().assertNull();
      await mr.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 验证结果，预期：屏幕左侧有M标志，显示为存储结果-15
       */
      const memoryIcon = await driver.findComponent(ON.id('id_memory'));
      expect(memoryIcon).not().assertNull();
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('-15');
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 点击mc清空存储
       */
      const mc = await driver.findComponent(ON.id('keyCode_19'));
      expect(mc).not().assertNull();
      await mc.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_005
     * @tc.name: 测试mr功能
     * @tc.type: 0
     * @tc.desc: 1、输入算式7+8，点击M+ 3、点击mr 预期：1、显示屏左侧有M显示，表示有存储内容 2、显示为存储结果15
     */
    it('calculationTest_005', 0, async () => {
      /**
       * @tc.steps: step1. 输入算式7+8
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击m+
       */
      const mMinus = await driver.findComponent(ON.id('keyCode_20'));
      expect(mMinus).not().assertNull();
      await mMinus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 点击mr
       */
      const mr = await driver.findComponent(ON.id('keyCode_22'));
      expect(mr).not().assertNull();
      await mr.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 验证结果，预期：屏幕左侧有M标志，显示为存储结果15
       */
      const memoryIcon = await driver.findComponent(ON.id('id_memory'));
      expect(memoryIcon).not().assertNull();
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('15');
      await driver.delayMs(DELAY_INTERVAL_TIME);
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 点击mc清空存储
       */
      const mc = await driver.findComponent(ON.id('keyCode_19'));
      expect(mc).not().assertNull();
      await mc.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_006
     * @tc.name: 测试错误表达式
     * @tc.type: 0
     * @tc.desc: 进入计算器，在计算器中输入1÷0,查看结果； 预期：提示：“错误”
     */
    it('calculationTest_006', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 输入算式1÷0
       */
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期提示“错误”
       */
      const result = await driver.findComponent(ON.id('id_second_text'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('错误');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_007
     * @tc.name: 测试小数除法
     * @tc.type: 0
     * @tc.desc: 在计算器中输入48.56÷4=，查看结果；预期：结果为12.14
     */
    it('calculationTest_007', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 输入48.56÷4
       */
      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
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
       * @tc.steps: step3. 验证结果，预期结果为12.14
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('12.14');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_008
     * @tc.name: 测试删除键
     * @tc.type: 0
     * @tc.desc: 输入一串数字如1,234×76.8，单击删除键三下；预期结果：删除3个字符，输入框显示为1,234*7
     */
    it('calculationTest_008', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 输入1,234×76.8
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

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 单击删除键三下
       */
      const deleteButton = await driver.findComponent(ON.id('keyCode_17'));
      expect(deleteButton).not().assertNull();
      await deleteButton.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      await deleteButton.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      await deleteButton.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期输入框显示为1,234*7
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('1,234×7');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_009
     * @tc.name: 测试小数乘法
     * @tc.type: 0
     * @tc.desc: 输入4.86×39.06=，查看结果，预期结果为189.8316
     */
    it('calculationTest_009', 0, async () => {
      /**
       * @tc.steps: step1. 输入4.86×39.06
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
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
       * @tc.steps: step3. 验证结果，预期为189.8316
       */
      const result: Component = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('189.8316');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_010
     * @tc.name: 测试小数减法
     * @tc.type: 0
     * @tc.desc: 输入9.65-34.99=，查看结果，预期结果为-25.34
     */
    it('calculationTest_010', 0, async () => {
      /**
       * @tc.steps: step1. 输入9.65-34.99
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await driver.delayMs(DELAY_INTERVAL_TIME);
      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const minus = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
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
       * @tc.steps: step3. 验证结果，预期为-25.34
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('-25.34');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_011
     * @tc.name: 测试表达式计算
     * @tc.type: 0
     * @tc.desc: 1、在计算器中输入14.7+35.96 2、按等号，查看结果
     */
    it('calculationTest_011', 0, async () => {
      /**
       * @tc.steps: step1. 在计算器中输入14.7+35.96
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
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
       * @tc.steps: step3. 验证结果，预期结果为50.66
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('50.66');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_012
     * @tc.name: 测试显示结果
     * @tc.type: 0
     * @tc.desc: 1、进入计算器，算术输入尾数超过7个0，例如：1*700000000 2、不显示科学计数E，显示结果为700000000
     */
    it('calculationTest_012', 0, async () => {
      /**
       * @tc.steps: step1. 在计算器中输入1*70000000，查看结果
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      for (let i = 0; i < 11; i++) {
        await zero.click();
        await driver.delayMs(DELAY_INTERVAL_TIME);
      }

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为700000000
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('700,000,000,000');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_013
     * @tc.name: 测试错误表达式
     * @tc.type: 0
     * @tc.desc: 进入计算器，在计算器中输入0÷0,查看结果； 预期：提示：“错误”
     */
    it('calculationTest_013', 0, async () => {
      /**
       * @tc.steps: step1. 输入算式0÷0
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期提示“错误”
       */
      const result = await driver.findComponent(ON.id('id_second_text'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('错误');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_014
     * @tc.name: 测试错误表达式
     * @tc.type: 0
     * @tc.desc: 进入计算器，在计算器中输入-1÷0,查看结果； 预期：提示：“错误”
     */
    it('calculationTest_014', 0, async () => {
      /**
       * @tc.steps: step1. 输入算式-1÷0
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const minus = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期提示“错误”
       */
      const result = await driver.findComponent(ON.id('id_second_text'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('错误');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_015
     * @tc.name: 测试错误表达式
     * @tc.type: 0
     * @tc.desc: 进入计算器，在计算器中输入123*9.5+6123+48-7÷0,查看结果； 预期：提示：“错误”
     */
    it('calculationTest_015', 0, async () => {
      /**
       * @tc.steps: step1. 123*9.5+6123+48-7÷0
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

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const minus = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期提示“错误”
       */
      const result = await driver.findComponent(ON.id('id_second_text'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('错误');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_016
     * @tc.name: 测试错误表达式
     * @tc.type: 0
     * @tc.desc: 进入计算器，在计算器中输入88÷2+106-1.5*100÷0,查看结果； 预期：提示：“错误”
     */
    it('calculationTest_016', 0, async () => {
      /**
       * @tc.steps: step1. 88÷2+106-1.5*100÷0
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const minus = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期提示“错误”
       */
      const result = await driver.findComponent(ON.id('id_second_text'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('错误');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_017
     * @tc.name: 测试多次运算结果
     * @tc.type: 0
     * @tc.desc: 1、输入21.7÷3.1+1.9x888-29.7，点击等于，结果显示1664.5
     * 2、接着分别输入+2.55  、-2.55  、*2.5   、 /2.5，点击等于
     * 3、输入+2.55结果显示：1667.05
     *    输入-2.55结果显示：1664.5
     *    输入*2.55结果显示：4244.475
     *    输入/2.55结果显示：1664.5
     */
    it('calculationTest_017', 0, async () => {
      /**
       * @tc.steps: step1. 21.7÷3.1+1.9x888-29.7
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

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

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const minus = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为1664.5
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('1,664.5');
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 输入+2.55
       */
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step5. 点击等于
       */
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step6. 验证结果，预期结果为1667.05
       */
      const result1 = await driver.findComponent(ON.id('id_global_exp'));
      expect(result1).not().assertNull();
      const text1: string = await result1.getText();
      expect(text1).assertEqual('1,667.05');
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step7. 输入-2.55
       */
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step8. 点击等于
       */
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step9. 验证结果，预期结果为1664.5
       */
      const result2 = await driver.findComponent(ON.id('id_global_exp'));
      expect(result2).not().assertNull();
      const text2: string = await result2.getText();
      expect(text2).assertEqual('1,664.5');
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step10. 输入*2.55
       */
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step11. 点击等于
       */
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step12. 验证结果，预期结果为1664.5
       */
      const result3 = await driver.findComponent(ON.id('id_global_exp'));
      expect(result3).not().assertNull();
      const text3: string = await result3.getText();
      expect(text3).assertEqual('4,244.475');
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step13. 输入÷2.55
       */
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step14. 点击等于
       */
      const equal4 = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal4).not().assertNull();
      await equal4.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step15. 验证结果，预期结果为1664.5
       */
      const result4 = await driver.findComponent(ON.id('id_global_exp'));
      expect(result4).not().assertNull();
      const text4: string = await result4.getText();
      expect(text4).assertEqual('1,664.5');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_018
     * @tc.name: 测试计算精度功能
     * @tc.type: 0
     * @tc.desc: 1、进入计算器输入1÷3x3 2、按等号后，观察结果是否为1
     */
    it('calculationTest_0018', 0, async () => {
      /**
       * @tc.steps: step1. 输入1÷3x3
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
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
       * @tc.steps: step3. 验证结果，预期结果为1
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('1');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_019
     * @tc.name: 测试删除功能
     * @tc.type: 0
     * @tc.desc: 1、输入一长串字符后点击C键 2、观察结果
     */
    it('calculationTest_019', 0, async () => {
      /**
       * @tc.steps: step1. 输入1876/.42.+541+.92-77
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const minus = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击C,清除输入内容
       */
      const clearButton = await driver.findComponent(ON.id('keyCode_16'));
      expect(clearButton).not().assertNull();
      await clearButton.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期结果为空
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });


    /**
     * @tc.number: calculationTest_020
     * @tc.name: 测试错误表达式
     * @tc.type: 0
     * @tc.desc: 进入计算器，在计算器中输入-1+456-789÷0,查看结果； 预期：提示：“错误”
     */
    it('calculationTest_020', 0, async () => {
      /**
       * @tc.steps: step1. 输入算式-1+456-789÷0
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      const minus = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
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

      await minus.click();
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

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期提示“错误”
       */
      const result = await driver.findComponent(ON.id('id_second_text'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('错误');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_021
     * @tc.name: 测试删除字符时，更新当前计算结果
     * @tc.type: 0
     * @tc.desc: 进入计算器，在计算器中输入123+5.67×70.9,点击删除键,点击等号 预期结果：输入框显示结果为519.9
     */
    it('calculationTest_021', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 输入1,23+5.67×70.9
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

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击删除键
       */
      const deleteButton = await driver.findComponent(ON.id('keyCode_17'));
      expect(deleteButton).not().assertNull();
      await deleteButton.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      await deleteButton.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step4. 验证结果，预期输入框显示结果为519.9
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('519.9');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_022
     * @tc.name: 测试四则运算-混合运算功能
     * @tc.type: 0
     * @tc.desc: 进入计算器，在计算器中输入21.8÷10.9+14.3x46.5-20.7,点击等号 预期结果：输入框显示结果为646.25
     */
    it('calculationTest_022', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 输入21.8÷10.9+14.3x46.5-20.7
       */
      const two = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const one = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const dot = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const divide = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const zero = await driver.findComponent(ON.id('keyCode_0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const plus = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const four = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const three = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const six = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const five = await driver.findComponent(ON.id('keyCode_5'));
      expect(five).not().assertNull();
      await five.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const minus = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await dot.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      const seven = await driver.findComponent(ON.id('keyCode_7'));
      expect(seven).not().assertNull();
      await seven.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 点击等于号
       */
      const equal = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step3. 验证结果，预期输入框显示结果为646.25
       */
      const result = await driver.findComponent(ON.id('id_global_exp'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('646.25');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationTest_023
     * @tc.name: 测试乘号后加负号的表达式计算
     * @tc.type: 0
     * @tc.desc: 测试表达式8×-9计算，预期得到-72
     */
    it('calculationTest_023', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 输入8×-9
       */
      let eight = await driver.findComponent(ON.id('keyCode_8'));
      expect(eight).not().assertNull();
      await eight.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let multiply = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let minus = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let nine = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期计算结果为-72
       */
      const result = await driver.findComponent(ON.id('id_second_text'));
      expect(result).not().assertNull();
      const text: string = await result.getText();
      expect(text).assertEqual('-72');
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });
  });
}