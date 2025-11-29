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

import BaseDataSource from './BaseDataSource';
import {
  DateUtil,
  HistoryObject,
  LogUtil,
  LooseObject,
} from '@hmos/common';

const TAG: string = 'ExpressionsDataSource';

/**
 * ExpressionsDataSource
 *
 * @since 2023-02-14
 */
export class ExpressionsDataSource extends BaseDataSource {
  private expList: Array<LooseObject> = [];
  private dateUtil: DateUtil = DateUtil.getInstance();

  /**
   * get record list
   *
   * @return record list
   */
  public getRecordList(): Array<LooseObject> {
    return this.expList;
  }

  /**
   *  total count
   *
   * @return count
   */
  public totalCount(): number {
    return this.expList?.length;
  }

  /**
   * return data
   *
   * @param index list of index
   * @return data item for index
   */
  public getData(index: number): LooseObject | null {
    if (this.expList == null || index >= this.expList?.length) {
      LogUtil.info(TAG, 'getData is empty');
      return null;
    } else {
      let looseObject: LooseObject = (this.expList[index]) as LooseObject;
      return looseObject;
    }
  }

  /**
   * refresh list
   *
   * @param expList target data source
   */
  public refresh(expList?: Array<LooseObject>): void {
    LogUtil.info(TAG, 'refresh!');
    if (expList && expList.length > 0) {
      this.buildExpList(expList);
    }
    this.expList = expList || [];
    this.notifyDataReload();
  }

  /**
   * 页面可见时的逻辑
   */
  public shown(): void {
    if (this.dateUtil.isLocalChange()) {
      this.dateUtil.refreshLocalStr();
      if (this.expList.length > 0) {
        this.buildExpList(this.expList);
        this.notifyDataReload();
      }
    }
  }

  /**
   * 数据更新时的逻辑
   */
  public update(expList: Array<LooseObject>): void {
    if (expList && expList.length > 0) {
      this.buildExpList(expList);
    }
    this.expList = expList || [];
    this.notifyDataReload();
  }

  /**
   * handle expLists, add property isVisible.
   *
   * @param expLists
   */
  private buildExpList(expLists: Array<LooseObject>): void {
    this.dateUtil.refreshLocalStr();
    let preDateId: string = this.dateUtil.today;
    for (let i = 0; i < expLists.length; i++) {
      let curItemData: LooseObject = expLists[i];
      curItemData.id = curItemData.dbId + this.dateUtil.localStr;
      this.convertTimeStampToDate(curItemData, preDateId, (dateId: string) => {
        preDateId = dateId;
      });
      let isVisible: boolean = i === 0 ? true : curItemData.isDateVisible;
      curItemData.isDateVisible = isVisible;
      if (curItemData.history.length === 0) {
        let resultItem: HistoryObject = new HistoryObject();
        resultItem.expression = curItemData.expression;
        resultItem.result = curItemData.result;
        resultItem.id = curItemData.id;
        resultItem.isDateVisible = curItemData.isDateVisible;
        curItemData.history.push(resultItem);
      }
    }
  }

  /**
   * Converts the timestamp form to the date form.
   *
   * @param recordItem history record item.
   */
  private convertTimeStampToDate(recordItem: LooseObject, preId: string, callBack: Function): void {
    let date: string = this.dateUtil.today;
    let expDate: Date = new Date(recordItem.time_stamp);
    let yearOfExp: number = expDate.getFullYear();
    let monthOfExp: number = expDate.getMonth() + 1;
    let dayOfExp: number = expDate.getDate();
    let now: Date = new Date();
    let yearOfNow: number = now.getFullYear();
    let monthOfNow: number = now.getMonth() + 1;
    let dayOfNow: number = now.getDate();
    if (yearOfNow == yearOfExp && monthOfNow == monthOfExp && dayOfNow == dayOfExp) {
      date = this.dateUtil.today;
    } else if (yearOfNow == yearOfExp && monthOfNow == monthOfExp && dayOfNow - dayOfExp == 1) {
      date = this.dateUtil.yesterday;
    } else if (yearOfNow == yearOfExp) {
      date = this.dateUtil.monthDayDateFormat.format(expDate);
    } else {
      date = this.dateUtil.yearMonthDayFormat.format(expDate);
    }
    recordItem.date = date;
    let isVisible: boolean = preId !== date;
    recordItem.isDateVisible = isVisible;
    callBack(date);
  }
}