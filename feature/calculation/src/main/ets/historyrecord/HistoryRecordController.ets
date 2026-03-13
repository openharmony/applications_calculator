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

import { LogUtil, LooseObject } from '@hmos/common';
import { ExpressionsModel } from '../model/ExpressionsModel';
import { ExpressionsDataSource } from '../model/ExpressionsDataSource';

const TAG: string = 'HistoryRecordController';

/**
 * History record controller
 *
 * @since 2023-02-13
 */
export class HistoryRecordController {
  // is display empty view
  private isEmptyView: boolean = true;

  // HistoryRecordController single instance
  private static instance: HistoryRecordController;

  // expressions model
  private expressionsModel = new ExpressionsModel();

  // exp list adapters
  private expDataSource: ExpressionsDataSource = new ExpressionsDataSource();

  /**
   * private constructor
   */
  private constructor() {
  }

  /**
   * single instance
   *
   * @return instance
   */
  public static getInstance(): HistoryRecordController {
    if (HistoryRecordController.instance == null) {
      HistoryRecordController.instance = new HistoryRecordController();
    }
    return HistoryRecordController.instance;
  }

  /**
   * retrun expDataSource
   *
   * @return expDataSource
   */
  getExpDataSource(): ExpressionsDataSource {
    return this.expDataSource;
  }

  getIsEmptyView(): boolean {
    return this.isEmptyView;
  }

  /**
   * delete all history records
   */
  deleteAllRecords(): void {
    LogUtil.info(TAG, 'deleteRecords start');
    this.expressionsModel.deleteAllRecords((rows: number) => {
      if (rows >= 1) {
        this.isEmptyView = true;
        this.expDataSource.refresh();
      }
    });
  }

  /**
   * delete current record
   *
   * @param record id
   */
  deleteRecordById(id: string): void {
    LogUtil.info(TAG, 'deleteRecords start');
    this.expressionsModel.deleteRecordById(id, (rows: number) => {
      if (this.expDataSource.totalCount() === 0) {
        this.isEmptyView = true;
      }
      this.expDataSource.refresh(this.expDataSource.getRecordList());
    });
  }

  /**
   * query all history records
   *
   * @returns history records
   */
  public queryAllRecords(): Array<LooseObject> {
    LogUtil.info(TAG, 'queryAllRecords start');
    this.expressionsModel.queryAllRecords((expList: Array<LooseObject>) => {
      if (expList !== null && expList.length !== 0) {
        this.isEmptyView = false;
      }
      this.expDataSource.refresh(expList);
    });

    return this.expDataSource.getRecordList();
  }

  /**
   * query all history records
   *
   * @param callback
   */
  public queryPhoneRecords(callback: Function): void {
    LogUtil.info(TAG, 'query phone records start');
    this.expressionsModel.queryAllRecords((expList: Array<LooseObject>) => {
      if (expList !== null && expList.length !== 0) {
        this.isEmptyView = false;
      }
      this.expDataSource.refresh(expList);
      callback(expList);
    });
  }

  /**
   * recordsIsEmpty
   *
   * @param callback
   */
  public recordsIsEmpty(callback: Function): void {
    LogUtil.info(TAG, 'query phone records start');
    this.expressionsModel.isEmpty(callback);
  }

  /**
   * clear expDataSource.expList
   */
  public clearData(): void {
    this.expDataSource.refresh();
  }

  /**
   * call on HistoryRecord show
   */
  public shown(): void {
    this.expDataSource.shown();
  }

  public update(historyRecordList: Array<LooseObject>): void {
    this.expDataSource.update(historyRecordList)
  }
}