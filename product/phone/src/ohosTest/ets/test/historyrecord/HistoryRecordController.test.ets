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

import {
  describe,
  beforeAll,
  beforeEach,
  afterEach,
  afterAll,
  it,
  expect,
} from '@ohos/hypium';
import { ExpressionsDataSource, HistoryRecordController } from '@hmos/calculation';

const TAG: string = 'HistoryRecordControllerTest';

/**
 * HistoryRecordController testcase
 *
 * @since 2023-12-01
 */
export default function HistoryRecordControllerTest() {
  describe('HistoryRecordControllerTest', () => {
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
     * @tc.number: getExpDataSource_001
     * @tc.name: 获取HistoryRecordController实例
     * @tc.type: 0
     * @tc.desc: 获取HistoryRecordController实例，应该不为Null
     */
    it('getInstance_001', 0, () => {
      let instance: HistoryRecordController = HistoryRecordController.getInstance();
      expect(instance).not().assertNull();
    });

    /**
     * @tc.number: getExpDataSource_001
     * @tc.name: 获取数据源
     * @tc.type: 0
     * @tc.desc: 获取数据源，应该不为Null
     */
    it('getExpDataSource_001', 0, () => {
      let instance: HistoryRecordController = HistoryRecordController.getInstance();
      expect(instance).not().assertNull();
      let expDataSource: ExpressionsDataSource = instance.getExpDataSource();
      expect(expDataSource).not().assertNull();
    });

    /**
     * @tc.number: getIsEmptyView_001
     * @tc.name: 判断是否没有历史记录
     * @tc.type: 0
     * @tc.desc: 判断是否为EmptyView，应该返回true
     */
    it('getIsEmptyView_001', 0, () => {
      let instance: HistoryRecordController = HistoryRecordController.getInstance();
      expect(instance).not().assertNull();
      let isEmptyView: boolean = instance.getIsEmptyView();
      expect(isEmptyView).assertTrue();
    });

    /**
     * @tc.number: deleteAllRecords_001
     * @tc.name: 删除所有历史记录
     * @tc.type: 0
     * @tc.desc: 删除所有历史记录后判断是否为EmptyView，应该返回true
     */
    it('deleteAllRecords_001', 0, () => {
      let instance: HistoryRecordController = HistoryRecordController.getInstance();
      expect(instance).not().assertNull();
      instance.deleteAllRecords();
      let isEmptyView: boolean = instance.getIsEmptyView();
      expect(isEmptyView).assertTrue();
    });

    /**
     * @tc.number: queryAllRecords_001
     * @tc.name: 查询历史记录
     * @tc.type: 0
     * @tc.desc: 未插入记录，查询历史记录后判断是否为EmptyView，应该返回true
     */
    it('queryAllRecords_001', 0, () => {
      let instance: HistoryRecordController = HistoryRecordController.getInstance();
      instance.queryAllRecords();
      let isEmptyView: boolean = instance.getIsEmptyView();
      expect(isEmptyView).assertTrue();
    });

    /**
     * @tc.number: clearData_001
     * @tc.name: 清除历史数据
     * @tc.type: 0
     * @tc.desc: 清除历史数据后判断是否为EmptyView，应该返回true
     */
    it('clearData_001', 0, () => {
      let instance: HistoryRecordController = HistoryRecordController.getInstance();
      instance.clearData();
      let isEmptyView: boolean = instance.getIsEmptyView();
      expect(isEmptyView).assertTrue();
    });
  })
}