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

import ExpressionsDataSourceTest from './ExpressionsDataSource.test';
import GlobalThisHelperTest from './GlobalThisHelper.test';
import InputUtilTest from './util/InputUtil.test';
import LogUtilTest from './util/LogUtil.test';
import CommonUtilTest from './util/CommonUtil.test';
import DateUtilTest from './util/DateUtil.test';
import DisplayUtilTest from './util/DisplayUtil.test';
import RdbHelperTest from './util/RdbHelper.test';
import EvaluatorTest from './Evaluator.test';

/**
 * Unit-test entrance
 *
 * @since 2024-02-21
 */
export default function testsuite() {
  GlobalThisHelperTest();
  InputUtilTest();
  LogUtilTest();
  CommonUtilTest();
  DateUtilTest();
  DisplayUtilTest();
  RdbHelperTest();
  ExpressionsDataSourceTest();
  EvaluatorTest();
}