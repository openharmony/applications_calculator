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

const TAG: string = 'BasicDataSource';

/**
 * BasicDataSource
 *
 * @since 2023-02-14
 */
export default class BasicDataSource implements IDataSource {
  // data change listener
  private listeners: DataChangeListener[] = [];

  /**
   * total count
   *
   * @return count, type is number
   */
  public totalCount(): number {
    return 0;
  }

  /**
   * Return the data of index.
   *
   * @param index data index
   * @return data of index
   */
  public getData(index: number): LooseObject | null {
    return null;
  }

  /**
   * Register data change listener.
   *
   * @param listener DataChangeListener
   */
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      LogUtil.info(TAG, 'add listener');
      this.listeners.push(listener);
    }
  }

  /**
   * Unregister data change listener.
   *
   * @param listener DataChangeListener
   */
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos: number = this.listeners.indexOf(listener);
    if (pos >= 0) {
      LogUtil.info(TAG, 'remove listener');
      this.listeners.splice(pos, 1);
    }
  }

  /**
   * notify data reload
   */
  notifyDataReload(): void {
    this.listeners.forEach(listener => {
      listener.onDataReloaded();
    })
  }

  /**
   * notify data add
   *
   * @param index data of index
   */
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index);
    });
  }

  /**
   * notify data change
   *
   * @param index data of index
   */
  notifyDataChange(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataChange(index);
    });
  }

  /**
   * notify data delete
   *
   * @param index data of index
   */
  notifyDataDelete(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataDelete(index);
    });
  }

  /**
   * notify data move.
   *
   * @param from index
   * @param to index
   */
  notifyDataMove(from: number, to: number): void {
    this.listeners.forEach(listener => {
      listener.onDataMove(from, to);
    });
  }
}