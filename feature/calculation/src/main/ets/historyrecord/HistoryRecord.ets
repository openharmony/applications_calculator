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

import display from '@ohos.display';
import { Callback } from '@ohos.base';
import common from '@ohos.app.ability.common';
import {
  AdaptiveAgingUtil,
  BreakPointType,
  CommonUtil,
  HistoryObject,
  LooseObject,
  LogUtil,
} from '@hmos/common';
import { HistoryRecordController } from './HistoryRecordController';
import { DelRecordsDialog } from '../views/DelRecordsDialog';
import { EmptyView } from './EmptyView';

const TAG: string = 'HistoryRecord';
const GRID_COUNT: number = 4;
const DEFAULT_PADDING: number = 16;
const TABLET_PADDING: number = 120;
const FOLD_STATUS_EXPANDED: number = 1;
const FOLD_STATUS_HALF_FOLDED: number = 3;
const DELETE_SWIPE_HEAD_WIDTH: number = 56;
const DELETE_SWIPE_BODY_WIDTH: number = 123;
const ANGLE_RADIO: number = 10;
const MAX_HEAD_ANGLE: number = 17;
const BODY_HEAD_CRITICAL_ANGLE: number = 12;
const MAX_BODY_ANGLE: number = 10;
const BODY_ANGLE_ZERO: number = 0;
const HEAD_ANGLE_ZERO: number = 0;
const SWIPE_SCALE_ONE: number = 1;
const SWIPE_SCALE_ONE_PLUS: number = 1.05;
const CONSTANTS_NEGATIVE_NUMBER = -1;
const SWIPE_ACTION_DURATION: number = 350;
const SWIPE_WAIT_DURATION: number = 150;

@Builder
export function HistoryRecordBuilder($$: Record<string, string>) {
  HistoryRecord({ value: ($$.param) })
}

/**
 * History record
 *
 * @since 2023-02-13
 */
@Component
export struct HistoryRecord {
  @State value: string = '';
  @State mHistoryRecordCtrl: HistoryRecordController = HistoryRecordController.getInstance();
  @State historyRecordList: Array<LooseObject> = [];
  @State adaptiveAging: AdaptiveAgingUtil = new AdaptiveAgingUtil();
  @State isRecordEmpty: boolean = this.mHistoryRecordCtrl.getIsEmptyView();
  @State foldStatus: number = display.getFoldStatus();
  @State recordId: string = '';
  @State chooseIndex: number = 0;
  @State headAngle: number = 0;
  @State bodyAngle: number = 0;
  @State swipeScale: number = 1;
  @Provide isChangeFoldStatus: boolean = false;
  @StorageProp('currentBreakPoint') curBp: string = '';
  @StorageLink('isRtlLocale') @Watch('mirrorLanguageChange') isRtlLocale: boolean = false;
  private isFoldable: boolean = display.isFoldable();
  private isEnabled: EdgeEffectOptions = { alwaysEnabled: true };
  private itemLeftOrRightPadding: BreakPointType = new BreakPointType({
    mdMd: TABLET_PADDING,
    mdLg: TABLET_PADDING,
    mdSm: TABLET_PADDING,
    lgMd: TABLET_PADDING,
    base: DEFAULT_PADDING,
  });

  mirrorLanguageChange(value: string): void {
    LogUtil.error(TAG, 'mirrorLanguageChange: ' + value);
    this.mHistoryRecordCtrl.update(this.historyRecordList);
  }

  private deleteMenuItem: Array<NavigationMenuItem> = [
    {
      value: '',
      icon: '/resources/base/media/ic_circle_delete.svg',
      isEnabled: true,
      action: () => {
        if (this.isFoldable && this.isChangeFoldStatus) {
          this.expandedDelRecordController.open();
        } else {
          this.mDelRecordController.open();
        }
      },
    }
  ];
  private emptyMenuItem: Array<NavigationMenuItem> = [
    {
      value: '',
      icon: '/resources/base/media/ic_circle_delete.svg',
      isEnabled: false,
    }
  ];
  @State menus: Array<NavigationMenuItem> = this.emptyMenuItem;

  private mDelRecordController: CustomDialogController = new CustomDialogController({
    builder: DelRecordsDialog({
      cancel: () => {},
      confirm: () => {
        this.mHistoryRecordCtrl.deleteAllRecords();
        this.menus = this.emptyMenuItem;
      },
      msg: $r('app.string.delete_all_history_date'),
      adaptiveAging: this.adaptiveAging,
    }),
    autoCancel: true,
    alignment: CommonUtil.checkIfDeviceIsTablet() ? DialogAlignment.Center : DialogAlignment.Bottom,
    offset: { dx: 0, dy: $r('app.float.dialog_offset_y') },
    gridCount: GRID_COUNT,
    cornerRadius: {
      topLeft: $r('app.float.dialog_radius'),
      topRight: $r('app.float.dialog_radius'),
      bottomLeft: $r('app.float.dialog_radius'),
      bottomRight: $r('app.float.dialog_radius'),
    },
  });
  private expandedDelRecordController: CustomDialogController = new CustomDialogController({
    builder: DelRecordsDialog({
      cancel: () => {},
      confirm: () => {
        this.mHistoryRecordCtrl.deleteAllRecords();
        this.menus = this.emptyMenuItem;
      },
      msg: $r('app.string.delete_all_history_date'),
      adaptiveAging: this.adaptiveAging,
    }),
    autoCancel: true,
    alignment: DialogAlignment.TopEnd,
    offset: { dx: $r('app.float.dialog_fold_offset_x'), dy: $r('app.float.action_bar_height') },
    gridCount: GRID_COUNT,
    cornerRadius: {
      topLeft: $r('app.float.dialog_radius'),
      topRight: $r('app.float.dialog_radius'),
      bottomLeft: $r('app.float.dialog_radius'),
      bottomRight: $r('app.float.dialog_radius'),
    },
  });

  async aboutToAppear() {
    this.mHistoryRecordCtrl.queryPhoneRecords((expList: Array<LooseObject>) => {
      this.historyRecordList = expList;
      if (this.historyRecordList.length === 0) {
        this.menus = this.emptyMenuItem;
      } else {
        this.menus = this.deleteMenuItem;
      }
    });
    if (this.isFoldable) {
      if (this.foldStatus === FOLD_STATUS_EXPANDED || this.foldStatus === FOLD_STATUS_HALF_FOLDED) {
        this.isChangeFoldStatus = true;
      }

      let callback: Callback<display.FoldStatus> = (data: display.FoldStatus) => {
        LogUtil.info(TAG, 'Listening enabled. Data: ' + JSON.stringify(data));
        this.foldStatus = data;
        if (this.foldStatus === FOLD_STATUS_EXPANDED || this.foldStatus === FOLD_STATUS_HALF_FOLDED) {
          this.isChangeFoldStatus = true;
          this.mDelRecordController.close();
        } else {
          this.isChangeFoldStatus = false;
          this.expandedDelRecordController.close();
        }
      };
      display.on('foldStatusChange', callback);
    }
  }

  private async dealRecordDelete(recordInfo: LooseObject): Promise<void> {
    LogUtil.info(TAG, `dealRecordDelete dbId: ${recordInfo.dbId}`);
    let delIndex: number = -1;
    this.historyRecordList.forEach((item: LooseObject, index: number) => {
      if (item.dbId === recordInfo.dbId) {
        delIndex = index;
      }
    })
    LogUtil.info(TAG, `dealRecordDelete index: ${delIndex}`);
    if (delIndex !== -1) {
      this.historyRecordList.splice(delIndex, 1);
      if (this.historyRecordList.length === 0) {
        this.menus = this.emptyMenuItem;
      }
    }

    this.mHistoryRecordCtrl.deleteRecordById(recordInfo.dbId);

    if (this.mHistoryRecordCtrl.getIsEmptyView()) {
      this.isRecordEmpty = true;
    }
  }

  private swipeAction(item: LooseObject): void {
    setTimeout(() => {
      animateTo({
        duration: SWIPE_ACTION_DURATION,
        curve: Curve.Friction,
      }, () => {
        this.dealRecordDelete(item);
      })
    }, SWIPE_ACTION_DURATION);
  }

  @Styles
  historyPageStyle() {
    .width('100%')
    .layoutWeight(1)
    .backgroundColor($r('app.color.color_main_bg'))
  }

  @Styles
  buttonStyle() {
    .borderRadius($r('sys.float.ohos_id_corner_radius_menu'))
    .height($r('app.float.swipe_button_height_and_width'))
    .width($r('app.float.swipe_button_height_and_width'))
    .margin($r('app.float.swipe_button_margin_size'))
  }

  @Builder
  showDeleteIc() {
    Flex({ direction: FlexDirection.Column, justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
      Image($r('app.media.ic_delete_head'))
        .width($r('app.float.swipe_delete_head_width'))
        .draggable(false)
        .rotate({
          x: 0,
          y: 0,
          z: 1,
          centerX: '100%',
          centerY: '100%',
          angle: this.headAngle,
        })
      Image($r('app.media.ic_delete_body'))
        .width($r('app.float.swipe_delete_body_width'))
        .draggable(false)
        .rotate({
          x: 0,
          y: 0,
          z: 1,
          centerX: '100%',
          centerY: 0,
          angle: this.bodyAngle,
        })
    }
    .width($r('app.float.swipe_button_height_and_width'))
    .height($r('app.float.swipe_button_height_and_width'))
  }

  @Builder
  renderSwipeAction(recordInfo: LooseObject): void {
    Row() {
      Stack() {
        this.showDeleteIc()
      }
      .buttonStyle()
      .scale({ x: this.swipeScale, y: this.swipeScale })
      .backgroundColor($r('sys.color.warning'))
      .onClick(() => {
        setTimeout(() => {
          animateTo({
            duration: SWIPE_ACTION_DURATION,
            curve: Curve.Friction,
          }, () => {
            this.dealRecordDelete(recordInfo);
          })
        }, SWIPE_WAIT_DURATION)
      })
    }
    .padding($r('app.float.swipe_button_padding_size'))
    .borderRadius($r('sys.float.ohos_id_corner_radius_menu'))
    .backgroundColor($r('app.color.color_main_bg'))
    .onAreaChange((_: Area, newValue: Area) => {
      let wid: Length = newValue.width;
      this.headAngle = (Number(wid) - DELETE_SWIPE_HEAD_WIDTH) / DELETE_SWIPE_HEAD_WIDTH * ANGLE_RADIO;
      if (this.headAngle <= HEAD_ANGLE_ZERO) {
        this.headAngle = HEAD_ANGLE_ZERO;
      }
      if (this.headAngle >= MAX_HEAD_ANGLE) {
        this.headAngle = MAX_HEAD_ANGLE;
      }
      if (this.headAngle > BODY_HEAD_CRITICAL_ANGLE) {
        this.swipeScale = SWIPE_SCALE_ONE_PLUS;
        this.bodyAngle = (Number(wid) - DELETE_SWIPE_BODY_WIDTH) / DELETE_SWIPE_BODY_WIDTH * ANGLE_RADIO;
      } else {
        this.bodyAngle = BODY_ANGLE_ZERO;
        this.swipeScale = SWIPE_SCALE_ONE;
      }
      if (this.bodyAngle > MAX_BODY_ANGLE) {
        this.bodyAngle = MAX_BODY_ANGLE;
        this.swipeScale = SWIPE_SCALE_ONE_PLUS;
      }
      this.bodyAngle = (CONSTANTS_NEGATIVE_NUMBER) * this.bodyAngle;
    })
    .justifyContent(FlexAlign.SpaceEvenly)
  }

  @Builder
  historyListItem(item: HistoryObject) {
    Flex({ direction: FlexDirection.Column }) {
      Text(item.expression)
        .padding({ top: $r('app.float.space_2') })
        .fontSize((this.adaptiveAging.getSysFontScale('app.float.history_expression_area_font_size')))
        .fontColor($r('sys.color.font_tertiary'))
        .fontWeight(FontWeight.Regular)
        .fontFamily('HarmonyHeiTi')
        .copyOption(CopyOptions.LocalDevice)

      Row().height($r('app.float.space_2'))

      Text('=' + item.result)
        .fontSize((this.adaptiveAging.getSysFontScale('app.float.history_result_area_font_size')))
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
  itemHead(item: LooseObject) {
    if (item.isDateVisible) {
      Column() {
        Text(item.date)
          .fontFamily('HarmonyHeiTi')
          .fontSize($r('app.float.title_date_font_size'))
          .fontColor($r('sys.color.font_tertiary'))
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .direction(Direction.Ltr)
      .padding({
        bottom: $r('app.float.data_digit_panel_padding'),
        left: $r('app.float.data_digit_panel_padding'),
        right: $r('app.float.data_digit_panel_padding'),
        top: $r('app.float.data_digit_panel_padding'),
      })
    }
  }

  @Builder
  records() {
    if (this.mHistoryRecordCtrl.getIsEmptyView()) {
      EmptyView({adaptiveAging: $adaptiveAging})
    } else {
      List() {
        LazyForEach(this.mHistoryRecordCtrl.getExpDataSource(), (item: LooseObject) => {
          ListItemGroup({header: this.itemHead(item)}) {
            ForEach(item.history, (itemA: HistoryObject) => {
              ListItem() {
                this.historyListItem(itemA)
              }
              .clip(true)
              .width('100%')
              .margin({bottom: $r('app.float.history_record_item_space')})
              .transition(
                TransitionEffect.asymmetric(
                  TransitionEffect.IDENTITY,
                  TransitionEffect.scale({x:1, y:1})
                    .animation({curve: Curve.Friction, duration: 0})
                    .combine(
                      TransitionEffect.OPACITY.animation({curve:Curve.Sharp, duration : 0})
                    )
                )
              )
              .borderRadius($r('app.float.popMenu_border_radius'))
              .swipeAction({
                edgeEffect: SwipeEdgeEffect.Spring,
                end: {
                  builder: (): void => this.renderSwipeAction(item),
                  onAction: () => {
                    this.swipeAction(item);
                  },
                }
              })
            }, (itemA: HistoryObject) => {
              return itemA.id;
            })
          }
        }, (item: LooseObject) => {
          return `${item.id}_${item.isDateVisible}_${item.date}`;
        })
      }
      .width('100%')
      .height('100%')
      .flexShrink(1)
      .scrollBar(BarState.Auto)
      .edgeEffect(EdgeEffect.Spring, this.isEnabled)
      .contentEndOffset(CommonUtil.getBottomSafeHeight())
      .padding({
        left: this.itemLeftOrRightPadding.getValue(this.curBp),
        right: this.itemLeftOrRightPadding.getValue(this.curBp),
      })
    }
  }

  build() {
    NavDestination() {
      this.records()
    }
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.color_main_bg'))
    .title((
      getContext(this) as common.UIAbilityContext).resourceManager.getStringSync($r('app.string.history_record')
    ))
    .menus(this.menus)
    .padding({ top: CommonUtil.getTopSafeHeight() })
  }
}