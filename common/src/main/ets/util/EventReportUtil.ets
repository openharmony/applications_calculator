/*
 * Copyright (c) 2022-2024 Huawei Device Co., Ltd.
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

import common from '@ohos.app.ability.common';
import hiAppEvent from '@ohos.hiviewdfx.hiAppEvent';
import { LogUtil } from './LogUtil';

const TAG: string = 'EventReportUtil';
const DOMAIN: string = 'CALCULATOR';

/**
 * Event Report Util
 *
 * @since 2022-11-03
 */
export class EventReportUtil {
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;

  static async writeAppEvent(eventName: string, eventType: hiAppEvent.EventType, eventParam: object): Promise<void> {
    try {
      hiAppEvent.write({
        domain: DOMAIN,
        name: eventName,
        eventType: eventType,
        params: eventParam,
        });
      LogUtil.info(TAG, 'success to write event');
    } catch (error) {
      LogUtil.error(TAG, 'failed to write event because: ', error.message);
    }
  }

  async writeDrawnCompleted(): Promise<void> {
    this.context.reportDrawnCompleted((err) => {
      if (err.code) {
        // 处理业务逻辑错误
        LogUtil.error(TAG, `reportDrawnCompleted failed, code is ${err.code}, message is ${err.message}`);
        return;
      }
      // 执行正常业务
      LogUtil.info(TAG, 'reportDrawnCompleted succeed');
    });
  }
}