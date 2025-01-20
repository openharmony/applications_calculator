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

import display from '@ohos.display';
import {
  describe,
  beforeAll,
  beforeEach,
  afterEach,
  afterAll,
  it,
  expect,
} from '@ohos/hypium';
import { DisplayUtil, LogUtil } from '@hmos/common';

const TAG: string = 'DisplayUtilTest';

/**
 * DisplayUtil testcase
 *
 * @since 2024-02-21
 */
export default function DisplayUtilTest() {
  describe('DisplayUtilTest', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })

    /**
     * @tc.number: vp2pxInTs_001
     * @tc.name: 验证vp转px
     * @tc.type: 0
     * @tc.desc: PC设备上，将vp值10转成px值，预期得到12.5
     */
    it('vp2pxInTs_001', 0, () => {
      const vpValue: number = 10;
      const dftDisplayDPI: number = display.getDefaultDisplaySync().densityDPI;
      LogUtil.info(TAG, `device default display dpi is: ${dftDisplayDPI}`);
      const pxValue: number = DisplayUtil.vp2pxInTs(vpValue, dftDisplayDPI);
      expect(pxValue).assertEqual(12.5);
    });

    /**
     * @tc.number: px2vpInTs_001
     * @tc.name: 验证px转vp
     * @tc.type: 0
     * @tc.desc: PC设备上，将px值12.5转成vp值，预期得到10
     */
    it('px2vpInTs_001', 0, () => {
      const pxValue: number = 12.5;
      const dftDisplayDPI: number = display.getDefaultDisplaySync().densityDPI;
      LogUtil.info(TAG, `device default display dpi is: ${dftDisplayDPI}`);
      const vpValue: number = DisplayUtil.px2vpInTs(pxValue);
      expect(vpValue).assertEqual(10);
    });

    /**
     * @tc.number: isDigit_001
     * @tc.name: 验证单个数字
     * @tc.type: 0
     * @tc.desc: 判断字符串是否为单个数字
     */
    it('isDigit_001', 0, () => {
      let target: string = '1';
      let isDigit: boolean = DisplayUtil.isDigit(target);
      expect(isDigit).assertTrue();

      target = '13';
      isDigit = DisplayUtil.isDigit(target);
      expect(isDigit).assertFalse();
    });

    /**
     * @tc.number: isNumber_001
     * @tc.name: 验证是否为数字表达式
     * @tc.type: 0
     * @tc.desc: 验证数字+操作符
     */
    it('isNumber_001', 0, () => {
      let target: string = '1+';
      let isNumber: boolean = DisplayUtil.isNumber(target);
      expect(isNumber).assertTrue();

      target = '0.12-';
      isNumber = DisplayUtil.isNumber(target);
      expect(isNumber).assertTrue();

      target = '-3×';
      isNumber = DisplayUtil.isNumber(target);
      expect(isNumber).assertTrue();

      target = '3÷';
      isNumber = DisplayUtil.isNumber(target);
      expect(isNumber).assertTrue();
    });

    /**
     * @tc.number: isLegalFormulaTail_001
     * @tc.name: 验证表达式尾部
     * @tc.type: 0
     * @tc.desc: 验证是否是合法的表达式结尾
     */
    it('isLegalFormulaTail_001', 0, () => {
      let target: string = '0.5';
      let isLegal: boolean = DisplayUtil.isLegalFormulaTail(target);
      expect(isLegal).assertTrue();

      target = '1.23e10';
      isLegal = DisplayUtil.isLegalFormulaTail(target);
      expect(isLegal).assertTrue();
    });
  })
}