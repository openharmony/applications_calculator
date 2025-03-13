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

import relationalStore from '@ohos.data.relationalStore';
import {
  describe,
  beforeAll,
  beforeEach,
  afterEach,
  afterAll,
  it,
  expect,
} from '@ohos/hypium';
import { RdbHelper } from '@hmos/common';

/**
 * EventReportUtilTest testcase
 *
 * @since 2024-02-21
 */
export default function RdbHelperTest() {
  describe('RdbHelperTest', () => {
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
     * @tc.number: getRdbHelperInstance_001
     * @tc.name: 获取RdbHelper实例
     * @tc.type: 0
     * @tc.desc: 获取RdbHelper实例，验证是否为null
     */
    it('getRdbHelperInstance_001', 0, () => {
      let rdbHelper: RdbHelper = RdbHelper.getInstance();
      expect(rdbHelper).not().assertNull();
    });

    /**
     * @tc.number: getRdbHelperInstance_002
     * @tc.name: 获取RdbHelper实例测试
     * @tc.type: 0
     * @tc.desc: 获取RdbHelper实例，两次实例应该相等
     */
    it('getRdbHelperInstance_002', 0, () => {
      let rdbHelper1: RdbHelper = RdbHelper.getInstance();
      expect(rdbHelper1).not().assertNull();
      let rdbHelper2: RdbHelper = RdbHelper.getInstance();
      expect(rdbHelper2).not().assertNull();
      expect(rdbHelper1).assertEqual(rdbHelper2);
    });

    /**
     * @tc.number: isTableFull_001
     * @tc.name: 验证Table是否存满
     * @tc.type: 0
     * @tc.desc: 验证Table是否存满，应该返回false
     */
    it('isTableFull_001', 0, async () => {
      let rdbHelper: RdbHelper = RdbHelper.getInstance();
      expect(rdbHelper).not().assertNull();
      await rdbHelper.isTableFull()
        .then((isTableFull) => {
          expect(isTableFull).assertFalse();
        }).catch(() => {
          expect(null).assertFail();
        });
    });

    /**
     * @tc.number: delOldestRecord_001
     * @tc.name: 删除陈旧历史记录
     * @tc.type: 0
     * @tc.desc: 删除陈旧历史记录，验证方法是否执行完毕
     */
    it('delOldestRecord_001', 0, async () => {
      let rdbHelper: RdbHelper = RdbHelper.getInstance();
      expect(rdbHelper).not().assertNull();
      await rdbHelper.delOldestRecord()
        .then(() => {
          expect(null).assertNull();
        }).catch(() => {
          expect(null).assertFail();
        });
    });

    /**
     * @tc.number: insertRecord_001
     * @tc.name: 插入记录测试
     * @tc.type: 0
     * @tc.desc: 插入记录测试，验证方法是否执行完毕
     */
    it('insertRecord_001', 0, async () => {
      let rdbHelper: RdbHelper = RdbHelper.getInstance();
      expect(rdbHelper).not().assertNull();
      let valueData: relationalStore.ValuesBucket = {
        'expression': '1+3',
        'result': '2',
        'time_stamp': new Date().getTime(),
      };
      await rdbHelper.insert(valueData)
        .then(() => {
          expect(null).assertNull();
        }).catch(() => {
          expect(null).assertFail();
        });
    });
  })
}