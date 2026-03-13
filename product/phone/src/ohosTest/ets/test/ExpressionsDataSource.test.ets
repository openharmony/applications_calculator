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

import { describe, it, expect } from '@ohos/hypium';
import { ExpressionsDataSource } from '@hmos/calculation';
import { LooseObject } from '@hmos/common';

const TAG: string = 'ExpressionsDataSourceTest';

/**
 * ExpressionsDataSource testcase
 *
 * @since 2023-11-20
 */
export default function ExpressionsDataSourceTest() {
  describe('ExpressionsDataSourceTest', () => {
    const dataSource: ExpressionsDataSource = new ExpressionsDataSource();

    it('getData_001', 0, () => {
      let res: LooseObject | null = dataSource.getData(1);
      expect(res).assertNull();
    });

    it('getData_002', 0, () => {
      let expList: Array<LooseObject> = [];
      let exp: LooseObject = new LooseObject();
      exp.dbId = '1';
      exp.expression = '2';
      exp.result = '3';
      expList.push(exp);
      dataSource.refresh(expList);
      let res: LooseObject | null = dataSource.getData(0);
      expect(res).assertEqual(exp);
    });

    it('totalCount_001', 0, () => {
      let expList: Array<LooseObject> = [];
      let exp: LooseObject = new LooseObject();
      exp.dbId = '1';
      exp.expression = '1+2';
      exp.result = '3';
      expList.push(exp);
      dataSource.refresh(expList);
      const count: number = dataSource.totalCount();
      expect(count).assertEqual(1);
    });
  });
}