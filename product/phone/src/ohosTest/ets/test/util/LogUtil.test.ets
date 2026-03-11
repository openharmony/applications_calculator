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

import { describe, it } from '@ohos/hypium';
import { LogUtil } from '@hmos/common';

const TAG: string = 'LogUtilTest';

/**
 * LogUtil testcase
 *
 * @since 2023-07-17
 */
export default function LogUtilTest() {

  describe('LogUtilTest', () => {
    it('debug', 0, () => {
      LogUtil.debug(TAG, 'debug test');
    });

    it('info', 0, () => {
      LogUtil.info(TAG, 'info test');
    });

    it('warn', 0, () => {
      LogUtil.warn(TAG, 'warn test');
    });

    it('error', 0, () => {
      LogUtil.error(TAG, 'error test');
    });

    it('formatDebug', 0, () => {
      let bundle = 'Calculator';
      let module = 'Log';
      LogUtil.debug(TAG, `bundleName: ${bundle}, moduleName: ${module}`);
    });

    it('formatInfo', 0, () => {
      let bundle = 'Calculator';
      let module = 'Log';
      LogUtil.info(TAG, `bundleName: ${bundle}, moduleName: ${module}`);
    });

    it('formatWarn', 0, () => {
      let bundle = 'Calculator';
      let module = 'Log';
      LogUtil.warn(TAG, `bundleName: ${bundle}, moduleName: ${module}`);
    });

    it('formatError', 0, () => {
      let bundle = 'Calculator';
      let module = 'Log';
      LogUtil.error(TAG, `bundleName: ${bundle}, moduleName: ${module}`);
    });
  });
}