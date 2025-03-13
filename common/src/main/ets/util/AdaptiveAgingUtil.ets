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

import { LogUtil } from './LogUtil';
// import systemParameterEnhance from '@ohos.systemParameterEnhance';

const TAG: string = 'AdaptiveAgingUtil';
const DEFAULT_FONT_SCALE: string = '1.45';
const SUFFIX_TAG: string = '_large';
const PERSIST_SYS_FONT_SIZE_SCALE: string = 'persist.sys.font_scale_for_user0';
const DEFAULT_FONT_SIZE_SCALE: string = '1';

/**
 * 适老化字体
 *
 * @since 2024-04-24
 */
export class AdaptiveAgingUtil {
  // 系统字体大小
  private sysFontScale: string = '1.5';

  getSysFontScale(fontSetting: string): Resource {
    // try {
    //   this.sysFontScale = systemParameterEnhance.getSync(PERSIST_SYS_FONT_SIZE_SCALE, DEFAULT_FONT_SIZE_SCALE);
    // } catch (error) {
    //   LogUtil.error(TAG, 'failed to load system font-size: ', error.message);
    //   return $r(fontSetting);
    // }
    this.sysFontScale = DEFAULT_FONT_SCALE;
    if (Number(this.sysFontScale) > Number(DEFAULT_FONT_SCALE)) {
      fontSetting = fontSetting + SUFFIX_TAG;
    }
    LogUtil.info(TAG, 'system font-size: ', this.sysFontScale);
    return $r(fontSetting);
  }

  static getDigitFontScale(): string {
    let sysFontScale: string = '1'
    // try {
    //   sysFontScale = systemParameterEnhance.getSync(PERSIST_SYS_FONT_SIZE_SCALE, DEFAULT_FONT_SIZE_SCALE);
    // } catch (error) {
    //   LogUtil.error(TAG, 'failed to load system font-size: ', error.message);
    //   return sysFontScale;
    // }
    return sysFontScale;
  }
}

export interface IStandardPanelInfo {
  isFont: boolean;
  suffix: string;
}