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

import Intl from '@ohos.intl';

const TAG: string = 'DataUtil';

/**
 * Auxiliary class for date internationalization formatting.
 *
 * @since 2023-09-25
 */
export class DateUtil {
  // DateUtil single instance
  private static instance: DateUtil;

  // Format the time based on the locale of the mobile phone.
  private local: Intl.Locale = new Intl.Locale();
  public localStr: string = this.local.toString();
  private relativeTimeFormat: Intl.RelativeTimeFormat = new Intl.RelativeTimeFormat(this.localStr, { numeric: 'auto' });
  public today: string = this.relativeTimeFormat.format(0, 'day');
  public yesterday: string = this.relativeTimeFormat.format(-1, 'day');
  public monthDayDateFormat: Intl.DateTimeFormat = new Intl.DateTimeFormat(this.localStr, {
    month: 'long',
    day: 'numeric',
  });
  public yearMonthDayFormat: Intl.DateTimeFormat = new Intl.DateTimeFormat(this.localStr, { dateStyle: 'long' });

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
  public static getInstance(): DateUtil {
    if (DateUtil.instance == null) {
      DateUtil.instance = new DateUtil();
    }
    return DateUtil.instance;
  }

  /**
   * Check whether the language of the mobile phone changes.
   *
   * @return {boolean} Whether the language of the mobile phone changes.
   */
  public isLocalChange(): boolean {
    let newLocalStr: string = new Intl.Locale().toString();
    return newLocalStr !== this.localStr;
  }

  /**
   * Updates the internationalization object in the mobile phone cache.
   */
  public refreshLocalStr(): void {
    this.localStr = new Intl.Locale().toString();
    this.relativeTimeFormat = new Intl.RelativeTimeFormat(this.localStr, { numeric: 'auto' });
    this.today = this.relativeTimeFormat.format(0, 'day');
    this.yesterday = this.relativeTimeFormat.format(-1, 'day');
    this.monthDayDateFormat = new Intl.DateTimeFormat(this.localStr, { month: 'long', day: 'numeric' });
    this.yearMonthDayFormat = new Intl.DateTimeFormat(this.localStr, { dateStyle: 'long' });
  }
}
