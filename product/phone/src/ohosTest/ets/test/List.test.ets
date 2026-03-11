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

import CalculatorAbilityTest from './CalculatorAbility.test';
import EvaluatorTest from './Evaluator.test';
import ExpressionsDataSourceTest from './ExpressionsDataSource.test';
import GlobalThisHelperTest from './GlobalThisHelper.test';
import InputUtilTest from './util/InputUtil.test';
import LogUtilTest from './util/LogUtil.test';
import MainPartOnePageTest from './MainPartOne.test';
import MainPartTwoPageTest from './MainPartTwo.test';
import HistoryRecordControllerTest from './historyrecord/HistoryRecordController.test';
import CommonUtilTest from './util/CommonUtil.test';
import DateUtilTest from './util/DateUtil.test';
import DisplayUtilTest from './util/DisplayUtil.test';
import CalculationPartOneTest from './CalculationPartOne.test';
import CalculationPartTwoTest from './CalculationPartTwo.test';
import RdbHelperTest from './util/RdbHelper.test';
import WorkerUtilTest from './util/WorkerUtil.test';
/**
 * Unit-test entrance
 *
 * @since 2023-07-15
 */
export default function testsuite() {
  MainPartOnePageTest();
  MainPartTwoPageTest();
  CalculationPartOneTest();
  CalculationPartTwoTest();
  GlobalThisHelperTest();
  InputUtilTest();
  LogUtilTest();
  HistoryRecordControllerTest();
  CommonUtilTest();
  DateUtilTest();
  DisplayUtilTest();
  RdbHelperTest();
  EvaluatorTest();
  ExpressionsDataSourceTest();
  CalculatorAbilityTest();
  WorkerUtilTest();
}