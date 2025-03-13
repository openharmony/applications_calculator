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

import { CommonUtil, LogUtil, AdaptiveAgingUtil } from '@hmos/common';
import { DateUtil } from '@hmos/common';

const TAG: string = 'DelRecordsDialog';

/**
 * delete records dialog
 *
 * @since 2023-02-24
 */
@CustomDialog
export struct DelRecordsDialog {
  controller?: CustomDialogController;
  // Cancel Event
  cancel: () => void = () => {};
  // Acknowledge Event
  confirm: () => void = () => {};
  // Message content
  msg?: string | Resource;
  adaptiveAging?: AdaptiveAgingUtil;

  @Builder
  CancelButton() {
    Button() {
      Text($r('app.string.cancel'))
        .textAlign(TextAlign.Center)
        .fontSize((this.adaptiveAging?.getSysFontScale('app.float.cancel_button_font_size')))
        .fontColor($r('sys.color.font_emphasize'))
        .fontWeight(FontWeight.Medium)
        .fontFamily('HarmonyHeiTi')
        .lineHeight($r('app.float.dialog_line_height'))
        .margin({
          top: $r('app.float.dialog_text_margin_top'),
          bottom: $r('app.float.dialog_text_margin_bottom'),
          left: $r('app.float.dialog_text_margin_left'),
          right: $r('app.float.dialog_text_margin_left'),
        })
    }
    .margin({ right: $r('app.float.dialog_text_margin_left') })
    .backgroundColor($r('sys.color.ohos_id_color_background_transparent'))
    .layoutWeight(1)
    .onClick(() => {
      this.controller?.close();
      this.cancel();
      LogUtil.info(TAG, 'Cancel the deletion operation.');
    })
    .align(Alignment.Center)
  }

  @Builder
  ClearButton() {
    Button() {
      Text($r('app.string.delete'))
        .textAlign(TextAlign.Center)
        .fontSize((this.adaptiveAging?.getSysFontScale('app.float.delete_button_font_size')))
        .fontColor($r('sys.color.warning'))
        .fontWeight(FontWeight.Medium)
        .fontFamily('HarmonyHeiTi')
        .lineHeight($r('app.float.dialog_line_height'))
        .margin({
          top: $r('app.float.dialog_text_margin_top'),
          bottom: $r('app.float.dialog_text_margin_bottom'),
          left: $r('app.float.dialog_text_margin_left'),
          right: $r('app.float.dialog_text_margin_left'),
        })
    }
    .margin({ left: $r('app.float.dialog_text_margin_left') })
    .backgroundColor($r('sys.color.ohos_id_color_background_transparent'))
    .layoutWeight(1)
    .onClick(() => {
      this.controller?.close();
      this.confirm();
      LogUtil.info(TAG, 'Delete the history record.');
    })
    .align(Alignment.Center)
  }

  @Builder
  CustomDialog() {
    Text(this.msg)
      .width('100%')
      .margin({ bottom: $r('app.float.dialog_msg_bottom_margin') })
      .textAlign(TextAlign.Center)
      .fontSize((this.adaptiveAging?.getSysFontScale('app.float.dialog_font_size')))
      .fontColor($r('sys.color.font_primary'))
      .fontWeight(FontWeight.Regular)
      .fontFamily('HarmonyHeiTi')

    Flex({
      direction: FlexDirection.Row,
      justifyContent: FlexAlign.SpaceEvenly,
      alignItems: ItemAlign.Center,
    }) {
      this.CancelButton()

      Divider()
        .vertical(true)
        .height($r('app.float.dialog_divider_height'))
        .color($r('sys.color.comp_divider'))
        .align(Alignment.Center)

      this.ClearButton()
    }
    .width('100%')
    .height($r('app.float.dialog_confirm_height'))
  }

  build() {
    if (CommonUtil.checkIfDeviceIsPC()) {
      Column() {
        this.CustomDialog()
      }
      .width($r('app.float.delete_dialog_width'))
      .borderRadius({
        topLeft: $r('app.float.dialog_radius'),
        topRight: $r('app.float.dialog_radius'),
        bottomLeft: $r('app.float.dialog_radius'),
        bottomRight: $r('app.float.dialog_radius'),
      })
      .backgroundColor($r('sys.color.ohos_id_color_dialog_bg'))
      .padding({
        top: $r('app.float.dialog_edge_padding'),
        bottom: $r('app.float.display_ic_margin_left'),
        left: $r('app.float.display_ic_margin_left'),
        right: $r('app.float.display_ic_margin_right'),
      })
    } else {
      Column() {
        this.CustomDialog()
      }
      .backgroundColor($r('sys.color.ohos_id_color_dialog_bg'))
      .width('100%')
      .padding({
        top: $r('app.float.dialog_edge_padding'),
        bottom: $r('app.float.display_ic_margin_left'),
        left: $r('app.float.display_ic_margin_left'),
        right: $r('app.float.display_ic_margin_right'),
      })
    }
  }
}