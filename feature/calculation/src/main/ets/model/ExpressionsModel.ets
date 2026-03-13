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

import relationalStore from '@ohos.data.relationalStore';
import { LogUtil, LooseObject, RdbHelper } from '@hmos/common';

const TAG: string = 'ExpressionsModel';

/**
 * ExpressionsModel
 *
 * @since 2023-03-10
 */
export class ExpressionsModel {
  private rdbHelper: RdbHelper = RdbHelper.getInstance();

  /**
   * insert record
   *
   * @param valueBucket history record entry
   */
  insertRecord(valueBucket: relationalStore.ValuesBucket): void {
    LogUtil.info(TAG, 'insertRecord');
    let promise: Promise<boolean> = this.rdbHelper.isTableFull();
    promise.then(res => {
      if (res) {
        this.rdbHelper.delOldestRecord();
      }
      this.rdbHelper.insert(valueBucket);
    });
  }

  /**
   * query all history records
   *
   * @param callback callback for resultSet
   */
  queryAllRecords(callback: Function): void {
    LogUtil.info(TAG, 'queryAllRecords start');
    this.rdbHelper.queryAll((resultSet: Array<LooseObject>) => {
      callback(resultSet);
    });
  }

  /**
   * delete all history records
   *
   * @param callback callback delete count
   */
  deleteAllRecords(callback: Function): void {
    LogUtil.info(TAG, 'deleteRecords start');
    this.rdbHelper.deleteItem('', callback);
  }

  /**
   * delete current records
   *
   * @param callback callback delete count
   */
  deleteRecordById(id: string, callback: Function): void {
    LogUtil.info(TAG, 'deleteRecords start');
    this.rdbHelper.deleteItemById(id, callback);
  }

  /**
   * 历史记录是否为空
   *
   * @param callback 返回查询结果
   */
  isEmpty(callback: Function): void {
    LogUtil.info(TAG, 'isEmpty start');
    this.rdbHelper.isEmpty(callback);
  }
}