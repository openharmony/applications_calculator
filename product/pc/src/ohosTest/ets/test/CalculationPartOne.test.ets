/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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
  });
}