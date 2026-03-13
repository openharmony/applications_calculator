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

import { LogUtil, AdaptiveAgingUtil, AccessibilityPlayUtil } from '@hmos/common';
import { HistoryRecordController } from '..';
import {
  AccessibilityInfo,
  ACCESSIBILITY_CLEAR_RECORD,
  ACCESSIBILITY_NAVIGATE_UP,
} from '../info/AccessibilityInfo';

const TAG: string = 'HistoryTitleBar';
const TEXT_WEIGHT: number = 500;

/**
 * Title Bar of History record page
 *
 * @since 2024-04-08
 */
@Component
export struct TitleBar {
  @Link historyRecordCtrl: HistoryRecordController;
  @Link adaptiveAging: AdaptiveAgingUtil;
  @Consume('pageInfos') pageInfos: NavPathStack;
  private delRecordController?: CustomDialogController;

  build() {
    Row() {
      Button({ type: ButtonType.Normal }) {
        Image($r('app.media.ic_circle_back'))
          .width($r('app.float.icon_history_width'))
          .height($r('app.float.icon_history_height'))
          .draggable(false)
          .fillColor($r('sys.color.icon_primary'))
      }
      .backgroundColor($r('sys.color.comp_background_tertiary'))
      .opacity($r('sys.float.ohos_id_alpha_content_primary'))
      .borderRadius($r('sys.float.ohos_id_corner_radius_button'))
      .width($r('app.float.icon_history_width'))
      .height($r('app.float.icon_history_height'))
      .margin({ left: $r('app.float.display_ic_margin_left') })
      .accessibilityText(ACCESSIBILITY_NAVIGATE_UP)
      .onClick(() => {
        this.pageInfos?.pop();
        AccessibilityPlayUtil.announceForAccessibility(ACCESSIBILITY_NAVIGATE_UP);
        focusControl.requestFocus('id_first_text_pc');
        LogUtil.info(TAG, `onClick: Back from history page.`);
      })
      .id('id_history_record_back')

      Text($r('app.string.history_record'))
        .fontSize(this.adaptiveAging.getSysFontScale('app.float.action_bar_text_size'))
        .fontColor($r('sys.color.font_primary'))
        .opacity($r('sys.float.ohos_id_alpha_content_primary'))
        .fontWeight(TEXT_WEIGHT)
        .margin({ left: $r('app.float.empty_text_top_margin') })

      Row().width('100%').flexShrink(1)

      Button({ type: ButtonType.Normal }) {
        Image($r('app.media.ic_circle_delete'))
          .width($r('app.float.icon_history_delete_width'))
          .height($r('app.float.icon_history_delete_height'))
          .draggable(false)
          .fillColor($r('sys.color.icon_primary'))
      }
      .backgroundColor($r('sys.color.comp_background_tertiary'))
      .opacity($r('sys.float.ohos_id_alpha_content_primary'))
      .borderRadius($r('sys.float.ohos_id_corner_radius_button'))
      .width($r('app.float.icon_history_width'))
      .height($r('app.float.icon_history_height'))
      .margin({ right: $r('app.float.display_ic_margin_left') })
      .enabled(!this.historyRecordCtrl.getIsEmptyView())
      .accessibilityText(AccessibilityInfo.getPlayInfoByResource(ACCESSIBILITY_CLEAR_RECORD))
      .onClick(() => this.delRecordController?.open())
      .id('id_history_record_delete')
    }
    .width('100%')
    .height($r('app.float.action_bar_height'))
    .margin({
      bottom: $r('app.float.action_bar_margin_bottom'),
    })
  }
}