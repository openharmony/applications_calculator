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

import { LooseObject, AdaptiveAgingUtil } from '@hmos/common';
import { HistoryRecordController } from './HistoryRecordController';
import { DelRecordsDialog } from '../views/DelRecordsDialog';
import { TitleBar } from './TitleBar';
import { EmptyView } from './EmptyView';

const TAG: string = 'HistoryRecordPC';
const GRID_COUNT: number = 4;
const DEFAULT_PADDING: number = 16;

@Builder
export function HistoryRecordBuilder($$: Record<string, string>) {
  HistoryRecordPC({ value: ($$.param) })
}

/**
 * History record page of PC
 *
 * @since 2024-04-08
 */
@Component
export struct HistoryRecordPC {
  @State adaptiveAging: AdaptiveAgingUtil = new AdaptiveAgingUtil();
  @State value: string = '';
  @State mHistoryRecordCtrl: HistoryRecordController = HistoryRecordController.getInstance();
  private isEnabled: EdgeEffectOptions = { alwaysEnabled : true };

  private mPCDelRecordController: CustomDialogController = new CustomDialogController({
    builder: DelRecordsDialog({
      cancel: () => {},
      confirm: () => {
        this.mHistoryRecordCtrl.deleteAllRecords();
      },
      msg: $r('app.string.delete_all_history_date'),
      adaptiveAging: this.adaptiveAging,
    }),
    autoCancel: true,
    customStyle: true,
    alignment: DialogAlignment.Center,
    offset: { dx: 0, dy: $r('app.float.dialog_offset_y') },
    gridCount: GRID_COUNT,
  });

  aboutToAppear() {
    this.mHistoryRecordCtrl.queryAllRecords();
  }

  @Styles historyPageStyle() {
    .width('100%')
    .layoutWeight(1)
    .backgroundColor($r('app.color.color_main_bg'))
  }

  @Builder
  historyListItem(item: LooseObject) {
    Flex({ direction: FlexDirection.Column }) {
      Text(item.expression)
        .padding({ top: $r('app.float.space_2') })
        .fontSize($r('sys.float.ohos_id_text_size_body1'))
        .fontColor($r('sys.color.font_tertiary'))
        .fontWeight(FontWeight.Regular)
        .fontFamily('HarmonyHeiTi')

      Row().height($r('app.float.space_2'))

      Text('=' + item.result)
        .fontSize($r('sys.float.ohos_id_text_size_headline8'))
        .fontColor($r('sys.color.font_primary'))
        .fontWeight(FontWeight.Medium)
        .padding({ top: $r('app.float.space_2'), bottom: $r('app.float.space_2') })
        .copyOption(CopyOptions.LocalDevice)
    }
    .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
    .width('100%')
    .padding({
      top: $r('app.float.history_record_item_top_padding'),
      bottom: $r('app.float.history_record_item_top_padding'),
      left: $r('app.float.history_record_item_left_padding'),
      right: $r('app.float.history_record_item_left_padding'),
    })
    .borderRadius($r('app.float.history_record_item_radius'))
  }

  @Builder
  records() {
    if (this.mHistoryRecordCtrl.getIsEmptyView()) {
      EmptyView({adaptiveAging: $adaptiveAging})
    } else {
      List() {
        LazyForEach(this.mHistoryRecordCtrl.getExpDataSource(), (item: LooseObject) => {
          ListItem() {
            this.historyListItem(item)
          }
          .width('100%')
          .margin({ bottom: $r('app.float.history_record_item_space') })
        }, (item: LooseObject) => {
          return item.id;
        })
      }
      .width('100%')
      .height('100%')
      .flexShrink(1)
      .sticky(StickyStyle.Header)
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring, this.isEnabled)
      .padding({
        left: DEFAULT_PADDING,
        right: DEFAULT_PADDING,
      })
    }
  }

  build() {
    NavDestination() {
      Column() {
        TitleBar({
          historyRecordCtrl: $mHistoryRecordCtrl,
          adaptiveAging: $adaptiveAging,
          delRecordController: this.mPCDelRecordController
        })

        this.records()
      }
      .stateStyles({ normal: this.historyPageStyle })
    }
    .width('100%')
    .height('100%')
    .hideTitleBar(true)
  }
}