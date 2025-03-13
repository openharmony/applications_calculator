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

import { describe, it, expect } from '@ohos/hypium';
import { GlobalThisHelper } from '@hmos/common';

const TAG: string = 'GlobalThisHelperTest';

/**
 * GlobalThisHelper testcase
 *
 * @since 2023-11-20
 */
export default function GlobalThisHelperTest() {
  describe('GlobalThisHelperTest', () => {
    it('GlobalThisHelperTest_01', 0, () => {
      let flag: boolean = GlobalThisHelper.isEmptyString(null);
      expect(flag).assertEqual(true);
    });

    it('GlobalThisHelperTest_02', 0, () => {
      let flag: boolean = GlobalThisHelper.isEmptyString('');
      expect(flag).assertEqual(true);
    });

    it('GlobalThisHelperTest_03', 0, () => {
      let flag: boolean = GlobalThisHelper.isEmptyString(TAG);
      expect(flag).assertEqual(false);
    });

    it('GlobalThisHelperTest_04', 0, () => {
      let res: string = GlobalThisHelper.get(null, 'GlobalThisHelperTest_04');
      expect(res).assertEqual('GlobalThisHelperTest_04');
    });

    it('GlobalThisHelperTest_05', 0, () => {
      let res: number = GlobalThisHelper.get('', 5);
      expect(res).assertEqual(5);
    });

    it('GlobalThisHelperTest_06', 0, () => {
      GlobalThisHelper.set(TAG, 6);
      let res: number = GlobalThisHelper.get(TAG, 5);
      expect(res).assertEqual(6);
    });

    it('GlobalThisHelperTest_07', 0, () => {
      GlobalThisHelper.set(TAG, 9);
      GlobalThisHelper.set(null, 7);
      let res: number = GlobalThisHelper.get(TAG, 5);
      expect(res).assertEqual(9);
    });

    it('GlobalThisHelperTest_08', 0, () => {
      GlobalThisHelper.set(TAG, 9);
      GlobalThisHelper.set('', 8);
      let res: number = GlobalThisHelper.get(TAG, 5);
      expect(res).assertEqual(9);
    });

    /**
     * @tc.number: removeTest_01
     * @tc.name: 移除测试
     * @tc.type: 0
     * @tc.desc: 移除对应的key，应该返回默认值
     */
    it('removeTest_01', 0, () => {
      GlobalThisHelper.set(TAG, 9);
      GlobalThisHelper.remove(TAG);
      let res: number = GlobalThisHelper.get(TAG, 5);
      expect(res).assertEqual(5);
    });

    /**
     * @tc.number: removeTest_02
     * @tc.name: 移除测试
     * @tc.type: 0
     * @tc.desc: 移除错误的key，应该返回9
     */
    it('removeTest_02', 0, () => {
      GlobalThisHelper.set(TAG, 9);
      GlobalThisHelper.remove('text');
      let res: number = GlobalThisHelper.get(TAG, 5);
      expect(res).assertEqual(9);
    });

    /**
     * @tc.number: isEmptyString_001
     * @tc.name: 判断字符串是否为空
     * @tc.type: 0
     * @tc.desc: 判断字符串'test'是否为空，应该返回false
     */
    it('isEmptyString_01', 0, () => {
      let isEmpty: boolean = GlobalThisHelper.isEmptyString('test');
      expect(isEmpty).assertFalse();
    });

    /**
     * @tc.number: isEmptyString_002
     * @tc.name: 判断字符串是否为空
     * @tc.type: 0
     * @tc.desc: 判断字符串''是否为空，应该返回true
     */
    it('isEmptyString_02', 0, () => {
      let isEmpty: boolean = GlobalThisHelper.isEmptyString('');
      expect(isEmpty).assertTrue();
    });

    /**
     * @tc.number: isEmptyString_003
     * @tc.name: 判断字符串是否为空
     * @tc.type: 0
     * @tc.desc: 判断null是否为空，应该返回true
     */
    it('isEmptyString_03', 0, () => {
      let isEmpty: boolean = GlobalThisHelper.isEmptyString(null);
      expect(isEmpty).assertTrue();
    });
  });
}