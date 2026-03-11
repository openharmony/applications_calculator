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

const DELAY_INTERVAL_TIME: number = 300; // interval between function call

/**
 * MainPage testcases
 *
 * @since 2023-11-11
 */
export default function MainPartOnePageTest() {
  describe('MainPartOnePageTest', () => {
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

    it('clickNumbers', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let numbers: string[] = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
      for (const item of numbers) {
        let number: Component = await driver.findComponent(ON.text(item));
        expect(number).not().assertNull();
        await number.click();
      }
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * Click button on digit panel
     */
    it('clickOperate', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      // Click the coordinates here. In the future, the ID can be used for binding.
      interface Point {
        x: number;
        y: number;
      };
      const plusPoint: Point = {
        x: 1130, y: 2020
      }; // ‘+’ Coordinates on the mobile phone
      const subtractPoint: Point = {
        x: 1130, y: 1730
      }; // ‘-’ Coordinates on the mobile phone
      const multiplyPoint: Point = {
        x: 820, y: 1450
      }; // ‘×’ Coordinates on the mobile phone
      const dividePoint: Point = {
        x: 510, y: 1450
      }; // ‘÷’ Coordinates on the mobile phone
      const equalPoint: Point = {
        x: 1130, y: 2450
      }; // ‘＝’ Coordinates on the mobile phone
      let points: Point[] = [plusPoint, subtractPoint, multiplyPoint, dividePoint, equalPoint];
      for (const item of points) {
        await driver.click(item.x, item.y);
        await driver.delayMs(DELAY_INTERVAL_TIME);
      }
    });

    it('clickClear', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let one: Component = await driver.findComponent(ON.text('1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      await driver.click(205, 1450); // phone: coordinate of the key to delete characters
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('clickDelete', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let two: Component = await driver.findComponent(ON.text('2'));
      expect(two).not().assertNull();
      await two.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let one: Component = await driver.findComponent(ON.text('1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.click(1130, 1450);
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('clickMemAddButton', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let one: Component = await driver.findComponent(ON.text('1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let button: Component = await driver.findComponent(ON.text('M+'));
      expect(button).not().assertNull();
      await button.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    it('clickMemSubtractButton', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let one: Component = await driver.findComponent(ON.text('1'));
      expect(one).not().assertNull();
      await one.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
      let button: Component = await driver.findComponent(ON.text('M-'));
      expect(button).not().assertNull();
      await button.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });

    /**
     * @tc.number: calculationMTest_001
     * @tc.name: 验证左边显示M标志
     * @tc.type: 0
     * @tc.desc: 1、判断M标志是否正常显示 2、点击mc
     */
    it('calculationMTest_001', 0, async () => {
      await driver.delayMs(DELAY_INTERVAL_TIME);

      /**
       * @tc.steps: step1. 判断经过上述用例是否正常显示M标志
       */
      const memoryIcon: Component = await driver.findComponent(ON.id('id_memory'));
      expect(memoryIcon).not().assertNull();

      /**
       * @tc.steps: step2. 点击mc清空存储
       */
      const mc: Component = await driver.findComponent(ON.id('keyCode_19'));
      expect(mc).not().assertNull();
      await mc.click();
      await driver.delayMs(DELAY_INTERVAL_TIME);
    });
  });
}