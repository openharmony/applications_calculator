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

import {
  BREAKPOINT_LG_MD,
  BREAKPOINT_MD_LG,
  BREAKPOINT_MD_MD,
  BREAKPOINT_MD_SM,
  BREAKPOINT_SM_MD,
} from '../types';

const TAG: string = 'BreakPoint';

declare interface BreakPointTypeOption {
  smMd?: Length;
  mdSm?: Length;
  mdMd?: Length;
  mdLg?: Length;
  lgMd?: Length;
  base: Length;
}

export class BreakPointType {
  private options: BreakPointTypeOption;

  constructor(option: BreakPointTypeOption) {
    this.options = option;
  }

  getValue(currentBreakPoint: string): Length {
    let result: Length = this.options.base;
    switch (currentBreakPoint) {
      case BREAKPOINT_SM_MD:
        if (this.options.smMd !== undefined) {
          result = this.options.smMd!;
        }
        break;
      case BREAKPOINT_MD_SM:
        if (this.options.mdSm !== undefined) {
          result = this.options.mdSm!;
        }
        break;
      case BREAKPOINT_MD_MD:
        if (this.options.mdMd !== undefined) {
          result = this.options.mdMd!;
        }
        break;
      case BREAKPOINT_MD_LG:
        if (this.options.mdLg !== undefined) {
          result = this.options.mdLg!;
        }
        break;
      case BREAKPOINT_LG_MD:
        if (this.options.lgMd !== undefined) {
          result = this.options.lgMd!;
        }
        break;
      default:
        result = this.options.base;
        break;
    }
    return result;
  }
}