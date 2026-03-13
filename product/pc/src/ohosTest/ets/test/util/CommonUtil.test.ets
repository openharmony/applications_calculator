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

import {
  describe,
  beforeAll,
  beforeEach,
  afterEach,
  afterAll,
  it,
  expect,
} from '@ohos/hypium';
import { CommonUtil } from '@hmos/common';

/**
 * CommonUtil testcase
 *
 * @since 2024-02-21
 */
export default function CommonUtilTest() {
  describe('CommonUtilTest', () => {
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
     * @tc.number: checkIfDeviceIsPhone_001
     * @tc.name: 判断当前设备是否为手机
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否为手机，应该返回false
     */
    it('checkIfDeviceIsPhone_001', 0, () => {
      const isPhone: boolean = CommonUtil.checkIfDeviceIsPhone();
      expect(isPhone).assertFalse();
    });

    /**
     * @tc.number: checkIfDeviceIsPC_001
     * @tc.name: 判断当前设备是否为PC
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否为PC，应该返回true
     */
    it('checkIfDeviceIsPC_001', 0, () => {
      const isPC: boolean = CommonUtil.checkIfDeviceIsPC();
      expect(isPC).assertTrue();
    });

    /**
     * @tc.number: checkIfDeviceIsTablet_001
     * @tc.name: 判断当前设备是否为平板
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否为平板，应该返回false
     */
    it('checkIfDeviceIsTablet_001', 0, () => {
      const isTablet: boolean = CommonUtil.checkIfDeviceIsTablet();
      expect(isTablet).assertFalse();
    });

    /**
     * @tc.number: checkIfDeviceIsFold_001
     * @tc.name: 判断当前设备是否为折叠屏
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否为折叠屏，应该返回false
     */
    it('checkIfDeviceIsFold_001', 0, () => {
      const isFold: boolean = CommonUtil.checkIfDeviceIsFold();
      expect(isFold).assertFalse();
    });

    /**
     * @tc.number: checkFoldIsExpanded_001
     * @tc.name: 判断当前设备是否为折叠屏-展开态
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否为折叠屏-展开态，应该返回false
     */
    it('checkFoldIsExpanded_001', 0, () => {
      const isExpanded: boolean = CommonUtil.checkFoldIsExpanded();
      expect(isExpanded).assertFalse();
    });

    /**
     * @tc.number: checkFoldIsFolded_001
     * @tc.name: 判断当前设备是否为折叠屏-折叠态
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否为折叠屏-折叠态，应该返回false
     */
    it('checkFoldIsFolded_001', 0, () => {
      const isFolded: boolean = CommonUtil.checkFoldIsFolded();
      expect(isFolded).assertFalse();
    });

    /**
     * @tc.number: checkFoldIsHalfFolded_001
     * @tc.name: 判断当前设备是否为折叠屏-半折叠态
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否为折叠屏-半折叠态，应该返回false
     */
    it('checkFoldIsHalfFolded_001', 0, () => {
      const isHalfFolded: boolean = CommonUtil.checkFoldIsHalfFolded();
      expect(isHalfFolded).assertFalse();
    });
  })
}