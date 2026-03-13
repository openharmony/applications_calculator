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

import rdb from '@ohos.data.rdb';

/**
 * table constant.
 *
 * @since 2023-02-14
 */
interface Config extends rdb.StoreConfig {
  name: string;
  securityLevel: number;
}

interface StoreConfig {
  config: Config;
  version: number;
  tableName: string;
}

interface Table {
  expression: string;
}

interface ExpressionField {
  id: string;
  expression: string;
  result: string;
  timeStamp: string;
}

class TableData {
  public STORE_CONFIGV9: StoreConfig = {
    config: {
      name: 'expression.db',
      securityLevel: 1,
    },
    version: 1,
    tableName: 'expression',
  }
  public table: Table = {
    // expression table
    expression:
    'CREATE TABLE IF NOT EXISTS expression (' +
      'id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
      'expression TEXT NOT NULL, ' +
      'result TEXT NOT NULL, ' +
      'time_stamp INTEGER DEFAULT 0' +
      ');',
  }
  public expressionField: ExpressionField = {
    id: 'id',
    expression: 'expression',
    result: 'result',
    timeStamp: 'time_stamp',
  }
  public queryCount: string = 'SELECT COUNT(*) FROM expression';
  public queryMinRecord: string = 'SELECT MIN(time_stamp) FROM expression';
}

export default new TableData();