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
 * MainPage testcases
 *
 * @since 2023-11-11
 */
export default function MainPartTwoPageTest() {
  describe('MainPartTwoPageTest', () => {
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

    it('clickMrButton', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let button: Component = await driver.findComponent(ON.text('MR'));
      expect(button).not().assertNull();
      await button.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('clickMcButton', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let button: Component = await driver.findComponent(ON.text('MC'));
      expect(button).not().assertNull();
      await button.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('displayCheck', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let nine: Component = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      let one: Component = await driver.findComponent(ON.id('keyCode_1'));
      expect(one).not().assertNull();
      await one.click();
      // check display value
      await driver.assertComponentExist(ON.text('91'));
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('clickDot', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let two: Component = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      let dot: Component = await driver.findComponent(ON.id('keyCode_11'));
      expect(dot).not().assertNull();
      await dot.click();
      let three: Component = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      // check display value
      await driver.assertComponentExist(ON.text('2.3'));
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('clickPercent', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let four: Component = await driver.findComponent(ON.text('4'));
      expect(four).not().assertNull();
      await four.click();
      let percent: Component = await driver.findComponent(ON.text('%'));
      expect(percent).not().assertNull();
      await percent.click();
      // check display value
      await driver.assertComponentExist(ON.text('4%'));
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: plusCheck
     * @tc.name: 加法测试
     * @tc.type: 0
     * @tc.desc: 1、输入44+4= 2、验证结果，预期计算结果为48
     */
    it('plusCheck', 0, async () => {
      /**
       * @tc.steps: step1. 输入44+4=
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let four: Component = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let plus: Component = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let equal: Component = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期计算结果为48
       */
      await driver.assertComponentExist(ON.text('48'));
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: subtractCheck
     * @tc.name: 减法测试
     * @tc.type: 0
     * @tc.desc: 1、输入66-4= 2、验证结果，预期计算结果为62
     */
    it('subtractCheck', 0, async () => {
      /**
       * @tc.steps: step1. 输入66-4=
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let six: Component = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let minus: Component = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let four: Component = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let equal: Component = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期计算结果为62
       */
      await driver.assertComponentExist(ON.text('62'));
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: multiplyCheck
     * @tc.name: 乘法测试
     * @tc.type: 0
     * @tc.desc: 1、输入22*4= 2、验证结果，预期计算结果为88
     */
    it('multiplyCheck', 0, async () => {
      /**
       * @tc.steps: step1. 输入22*4=
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let two: Component = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let multiply: Component = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let four: Component = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let equal: Component = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期计算结果为88
       */
      await driver.assertComponentExist(ON.text('88'));
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: divideCheck
     * @tc.name: 除法测试
     * @tc.type: 0
     * @tc.desc: 1、输入9/4= 2、验证结果，预期计算结果为2.25
     */
    it('divideCheck', 0, async () => {
      /**
       * @tc.steps: step1. 输入9/4=
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let nine: Component = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let divide: Component = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let four: Component = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let equal: Component = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期计算结果为2.25
       */
      await driver.assertComponentExist(ON.text('2.25'));
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: multipleOperatorCheck
     * @tc.name: 混合运算测试
     * @tc.type: 0
     * @tc.desc: 1、输入9/3-6×4+2= 2、验证结果，预期计算结果为-19
     */
    it('multipleOperatorCheck', 0, async () => {
      /**
       * @tc.steps: step1. 输入9/3-6×4+2=
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let nine: Component = await driver.findComponent(ON.id('keyCode_9'));
      expect(nine).not().assertNull();
      await nine.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let divide: Component = await driver.findComponent(ON.id('keyCode_13'));
      expect(divide).not().assertNull();
      await divide.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let three: Component = await driver.findComponent(ON.id('keyCode_3'));
      expect(three).not().assertNull();
      await three.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let minus: Component = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let six: Component = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let multiply: Component = await driver.findComponent(ON.id('keyCode_14'));
      expect(multiply).not().assertNull();
      await multiply.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let four: Component = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let plus: Component = await driver.findComponent(ON.id('keyCode_12'));
      expect(plus).not().assertNull();
      await plus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let two: Component = await driver.findComponent(ON.id('keyCode_2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let equal: Component = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期计算结果为-19
       */
      await driver.assertComponentExist(ON.text('-19'));
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: minusSignOperation
     * @tc.name: 减法测试
     * @tc.type: 0
     * @tc.desc: 1、输入-66-4= 2、验证结果，预期计算结果为2.25
     */
    it('minusSignOperation', 0, async () => {
      /**
       * @tc.steps: step1. 输入-66-4=
       */
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let minus: Component = await driver.findComponent(ON.id('keyCode_15'));
      expect(minus).not().assertNull();
      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let six: Component = await driver.findComponent(ON.id('keyCode_6'));
      expect(six).not().assertNull();
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      await six.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      await minus.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let four: Component = await driver.findComponent(ON.id('keyCode_4'));
      expect(four).not().assertNull();
      await four.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      let equal: Component = await driver.findComponent(ON.id('keyCode_18'));
      expect(equal).not().assertNull();
      await equal.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step2. 验证结果，预期计算结果为-70
       */
      await driver.assertComponentExist(ON.text('-70'));
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('checkTextTen', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let one: Component = await driver.findComponent(ON.text('1'));
      expect(one).not().assertNull();
      await one.click();
      let zero: Component = await driver.findComponent(ON.text('0'));
      expect(zero).not().assertNull();
      await zero.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      await driver.assertComponentExist(ON.text('10'));
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('checkTextTwelve', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let one: Component = await driver.findComponent(ON.text('1'));
      expect(one).not().assertNull();
      await one.click();
      let two: Component = await driver.findComponent(ON.text('2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      await driver.assertComponentExist(ON.text('12'));
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });
  });
}