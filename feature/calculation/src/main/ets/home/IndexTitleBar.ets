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

import { AdaptiveAgingUtil } from '@hmos/common';
import { MenuItems } from '../calculator/MenuItems';
import {
  AccessibilityInfo,
  ACCESSIBILITY_HISTORY_RECORD_PLAY,
  ACCESSIBILITY_MORE_SELECT,
} from '../info/AccessibilityInfo';
import { HistoryRecordController } from '../historyrecord/HistoryRecordController';
const TAG: string = 'IndexTitleBar';

/**
 * Index title bar
 *
 * @since 2023-11-02
 */
@Component
export struct IndexTitleBar {
  private menuItems: Array<MenuItems> = [];
  private loadHistoryRecordPage: () => void = () => {};
  private changeCalculatorMode: () => void = () => {};
  private adaptiveAging?: AdaptiveAgingUtil;
  @Link isScienceMode: boolean;
  private accessibilityPlay: (isEmpty: Boolean) => void = () => {};
  private mHistoryRecordCtrl: HistoryRecordController = HistoryRecordController.getInstance();
  @Builder
  PopupBuilder() {
    Column() {
      List() {
        ForEach(this.menuItems, (item: MenuItems) => {
          ListItem() {
            Button({ type: ButtonType.Normal, stateEffect: item.enabled }) {
              Text(item.value)
                .fontSize($r('app.float.popMenu_text_font_size'))
                .lineHeight($r('app.float.popMenu_text_line_height'))
                .width('100%')
                .height($r('app.float.popMenu_text_height'))
                .padding({ left: $r('app.float.popMenu_edge_size'), right: $r('app.float.popMenu_edge_size') })
                .fontWeight(FontWeight.Regular)
                .fontColor($r('sys.color.font_primary'))
            }
            .width('100%')
            .height($r('app.float.popMenu_text_height'))
            .backgroundColor($r('sys.color.comp_background_emphasize'))
            .onClick(() => {
              if (item.enabled) {
                item.action();
              }
            })
          }
        }, (item: MenuItems) => JSON.stringify(item))
      }
      .listDirection(Axis.Vertical)
      .divider({
        strokeWidth: 1,
        color: $r('sys.color.comp_divider'),
        startMargin: $r('app.float.popMenu_edge_size'),
        endMargin: $r('app.float.popMenu_edge_size'),
      })
      .edgeEffect(EdgeEffect.Spring)
      .chainAnimation(false)
    }
    .backgroundColor($r('sys.color.ohos_id_color_dialog_bg'))
    .width($r('app.float.popMenu_phone_width_size'))
    .borderRadius($r('app.float.popMenu_border_radius'))
    .padding($r('app.float.page_inner_padding'))
    .margin({ top: $r('app.float.digit_btn_border_width') })
  }

  @Builder
  HistoryRecordButton() {
    Button({ type: ButtonType.Normal }) {
      Image($r('app.media.ic_history_record'))
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
    .accessibilityText(AccessibilityInfo.getPlayInfoByResource(ACCESSIBILITY_HISTORY_RECORD_PLAY))
    .onClick(() => {
      this.mHistoryRecordCtrl.recordsIsEmpty(this.accessibilityPlay);
      this.loadHistoryRecordPage();
    })
    .id('id_history_record_go')
  }

  @Builder
  MoreMenuButton() {
    Button({ type: ButtonType.Normal }) {
      Image($r('app.media.ic_circle_more'))
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
    .bindMenu(this.MoreMenu, { showInSubWindow: false})
    .accessibilityText(ACCESSIBILITY_MORE_SELECT)
    .id('id_more_menu')
  }

  @Builder
  MoreMenu() {
    Menu() {
      MenuItem({
        content: this.isScienceMode ? $r('app.string.std_calculator') : $r('app.string.sci_calculator')
      })
        .onClick(() => {
          this.changeCalculatorMode();
        })
        .id(this.isScienceMode ? 'id_index_title_bar_std' : 'id_index_title_bar_sci')
    }
    .font({ size: this.adaptiveAging?.getSysFontScale('app.float.model_change_bar_text_size') })
  }

  build() {
    Row() {
      this.HistoryRecordButton()
      this.MoreMenuButton()
    }
    .align(Alignment.Top)
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .id('id_index_title_bar')

  }
}