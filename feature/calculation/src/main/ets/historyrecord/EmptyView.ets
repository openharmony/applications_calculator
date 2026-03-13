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

import { LogUtil, AdaptiveAgingUtil } from '@hmos/common';

const TAG: string = 'HistoryEmptyView';

/**
 * Empty View of History record page
 *
 * @since 2024-04-08
 */

@Component
export struct EmptyView {
  @Link adaptiveAging: AdaptiveAgingUtil;
  build() {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Column() {
        Image($r('app.media.search_no_result'))
          .width($r('app.float.empty_image_width'))
          .height($r('app.float.empty_image_height'))
        Text($r('app.string.record_empty'))
          .margin({ top: $r('app.float.empty_text_top_margin') })
          .fontWeight(FontWeight.Regular)
          .fontFamily('HarmonyHeiTi')
          .fontSize((this.adaptiveAging.getSysFontScale('app.float.history_empty_view_font_size')))
          .fontColor($r('sys.color.font_tertiary'))
      }
      .offset({ y: $r('app.float.empty_view_offset_y') })
    }
    .width('100%')
    .height('100%')
  }
}