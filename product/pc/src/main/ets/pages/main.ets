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

import window from '@ohos.window';
import common from '@ohos.app.ability.common';
import worker from '@ohos.worker';
import { BusinessError } from '@ohos.base';
import { GlobalThisHelper, LogUtil } from '@hmos/common';
import curves from '@ohos.curves';

import {
  DigitPanelController,
  DigitPanel,
  OperationViewPC,
  PhysicsButtonInfo,
  IndexTitleBar,
  MenuItems,
  SimplePhysicsButtonInfo,
} from '@hmos/calculation';
import { getWorker } from '../workers/WorkerUtil';
import { PanelSizeInfo } from '@hmos/calculation/src/main/ets/info/PanelSizeInfo';
import { PageConstants } from '../types';

const TAG: string = 'Main';
const STANDARD_WIDTH: number = vp2px(362);
const STANDARD_HEIGHT: number = vp2px(772);
const SCIENCE_WIDTH: number = vp2px(708);
const PC_HEIGHT_PERCENT: number = 0.28;

PersistentStorage.persistProp('globalExpression', '');
PersistentStorage.persistProp('globalResult', '');
PersistentStorage.persistProp('radOrDegFlag', false);
PersistentStorage.persistProp('scienceFlag', false);
PersistentStorage.persistProp('isSelectAll', false);

/**
 * Main page
 *
 * @since 2023-11-03
 */
@Entry
@Component
struct Main {
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  @Provide('inverseFlag') inverseFlag: boolean = false;
  @BuilderParam historyRecordBuilder?: ($$: Record<string, string>) => void;
  private mDigitPanelController: DigitPanelController = DigitPanelController.getInstance();
  @State standList: Array<Array<SimplePhysicsButtonInfo>> = this.mDigitPanelController.getStandLists();
  @State scienceList: Array<Array<SimplePhysicsButtonInfo>> = this.mDigitPanelController.getScienceLists();
  @State isMemoryDisplay: boolean = false;
  @StorageLink('scienceFlag') isScienceMode: boolean = false;
  @State showSciencePanel: boolean = false;
  @State worker: worker.ThreadWorker = getWorker();
  @StorageLink('globalResult') result: string = '';
  @State panelSizeInfo: PanelSizeInfo = new PanelSizeInfo();
  @StorageProp('updateUI') @Watch('onUpdateUI') timeStamp: number = 0;
  @State topAreaHeight: number = 0;
  @State bottomAreaHeight: number = 0;
  @State sciPanelWidth: number = 0;
  @State standPanelWidth: number = 0;
  private mNavPathInfo: NavPathInfo = new NavPathInfo('history', null);
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  private calculatorWindow: window.Window | undefined = undefined;
  @Provide('invalidFlag') isInvalid: boolean = false;
  @StorageLink('radOrDegFlag') radOrDegFlag: boolean = false;
  private curveMode: curves.ICurve = curves.interpolatingSpring(0, 1, 280, 33);
  private windowRect: window.Rect | undefined = undefined;

  private loadHistoryRecordPage = () => {
    this.requireModule().then((res) => {
      if (res) {
        this.pageInfos.pushPath(this.mNavPathInfo);
      } else {
        LogUtil.error(TAG, 'fail to load page');
      }
    });
  };

  private inputValue = (value?: PhysicsButtonInfo, keyValue?: string) => {
    if (value !== null && value !== undefined) {
      this.input(value);
    } else if (keyValue !== null && keyValue !== undefined) {
      this.input(undefined, keyValue);
    }
  };

  private input = (value?: PhysicsButtonInfo, keyValue?: string) => {
    this.mDigitPanelController.handleInput((res: Record<string, string>) => {
      this.result = res.result;
    }, value, keyValue);
    if (value !== null && value !== undefined) {
      this.mDigitPanelController.updateMemoryDisplay(value, (res: Record<string, boolean>) => {
        this.isMemoryDisplay = res.change ? res.isDisplay : this.isMemoryDisplay;
      })
    }
  }

  private menuItems: Array<MenuItems> = [
    {
      value: $r('app.string.history_record'),
      action: () => {
        this.changeCalculatorMode();
      },
      enabled: true,
    }
  ];

  /**
   * Change calculator mode and resize the window.
   */
  private changeCalculatorMode = () => {
    this.isScienceMode = !this.isScienceMode;
    this.calculatorWindow?.setWindowLimits(
      {
        maxWidth: this.isScienceMode ? SCIENCE_WIDTH : STANDARD_WIDTH,
        maxHeight: STANDARD_HEIGHT,
        minWidth: this.isScienceMode ? SCIENCE_WIDTH : STANDARD_WIDTH,
        minHeight: STANDARD_HEIGHT
      }
    );
  };

  /**
   * Initialization operations in the appearance phase.
   */
  aboutToAppear() {
    LogUtil.info(TAG, 'aboutToAppear： Main');
    this.mDigitPanelController.setWorker(getWorker());
    this.mDigitPanelController.getMemoryDisplay().then((flag)=>{
      this.isMemoryDisplay = flag;
    })
    window.getLastWindow(this.context, (err: BusinessError, data: window.Window) => {
      const errCode: number = err.code;
      if (errCode) {
        LogUtil.error(TAG, 'Failed to obtain the top window,', `err.code: ${errCode}, err.message:${err.message}`);
        return;
      }
      this.calculatorWindow = data;
      let properties: window.WindowProperties = this.calculatorWindow.getWindowProperties();
      this.windowRect = properties.windowRect;
      LogUtil.info(TAG, 'Succeeded in obtaining the top window.');
    });
  }

  onPageShow(): void {
    LogUtil.info(TAG, 'onPageShow： Main');
    this.context.reportDrawnCompleted((err) => {
      if (err.code) {
        // 处理业务逻辑错误
        LogUtil.error(TAG, `reportDrawnCompleted failed, code is ${err.code}, message is ${err.message}`);
        return;
      }
      // 执行正常业务
      LogUtil.info(TAG, 'PC main page reportDrawnCompleted succeed');
    });
  }

  /**
   * Check whether the historyRecordBuilder is existed.
   *
   * @returns { boolean } Whether the historyRecordBuilder is existed.
   */
  async requireModule(): Promise<boolean> {
    if (this.historyRecordBuilder) {
      return true;
    }
    let historyRecordBuilder = await import('@hmos/calculation/src/main/ets/historyrecord/HistoryRecordPC');
    this.historyRecordBuilder = historyRecordBuilder.HistoryRecordBuilder;
    if (!this.historyRecordBuilder) {
      return false;
    }
    return true;
  }

  @Builder
  PageMap(name: string) {
    if (name === 'history' && this.historyRecordBuilder) {
      this.historyRecordBuilder({ 'param': name } as Record<string, string>);
    }
  }

  @Builder
  TopAreaBuilder() {
    Stack({ alignContent: Alignment.TopStart }) {
      IndexTitleBar({
        menuItems: this.menuItems,
        loadHistoryRecordPage: this.loadHistoryRecordPage,
        changeCalculatorMode: this.changeCalculatorMode,
        isScienceMode: this.isScienceMode,
      })

      Row() {
        if (this.isMemoryDisplay) {
          Row()
            .width($r('app.float.display_M_margin_left'))
          Text('M')
            .width($r('app.float.display_M_width'))
            .fontSize($r('app.float.display_M_font_size'))
            .fontColor($r('sys.color.ohos_id_color_text_secondary'))
            .opacity($r('sys.float.ohos_id_alpha_content_secondary'))
            .textAlign(TextAlign.Center)
            .id('id_memory')
        }
        if (this.showSciencePanel) {
          Text(this.radOrDegFlag ? 'Rad' : 'Deg')
            .width($r('app.float.icon_history_width'))
            .fontSize($r('app.float.display_M_font_size'))
            .fontColor($r('sys.color.ohos_id_color_text_secondary'))
            .opacity($r('sys.float.ohos_id_alpha_content_secondary'))
            .textAlign(TextAlign.Center)
            .id('id_degree_mode')
        }
      }
      .margin({
        top: $r('app.float.display_M_margin_top'),
      })

      OperationViewPC({
        result: $result,
        isMemoryDisplay: $isMemoryDisplay,
        inputValue: this?.inputValue,
        worker: $worker,
        radOrDeg: this.radOrDegFlag,
      })
    }
    .width('100%')
    .alignContent(Alignment.TopStart)
    .height(this.topAreaHeight)
    .padding({
      top: $r('app.float.display_ic_margin_top'),
      left: $r('app.float.display_ic_margin_left'),
      right: $r('app.float.display_ic_margin_right'),
    })
  }

  @Builder
  BottomAreaBuilder() {
    Row() {
      Column() {
        DigitPanel({
          standList: $scienceList,
          inputValue: this?.inputValue,
          panelSizeInfo: this.panelSizeInfo,
          columnsTemplate: PageConstants.PANEL_SCIENCE_BTN_COLUMNS_TEMPLATE,
          radOrDegFlag: this.radOrDegFlag,
          isScience: this.showSciencePanel
        })
      }
      .zIndex(1)
      .width(this.sciPanelWidth)
      .height('100%')
      .visibility(this.showSciencePanel ? Visibility.Visible : Visibility.None)
      .animation({
        duration: 2000,
        curve: this.curveMode,
        iterations: 1,
        playMode: PlayMode.Normal
      })

      Column() {
        DigitPanel({
          standList: $standList,
          inputValue: this?.inputValue,
          panelSizeInfo: this.panelSizeInfo,
          radOrDegFlag: this.radOrDegFlag,
          isScience: this.showSciencePanel
        })
      }
      .zIndex(2)
      .width(this.standPanelWidth)
      .height('100%')
      .animation({
        duration: 2000,
        curve: this.curveMode,
        iterations: 1,
        playMode: PlayMode.Normal
      })
    }
    .width('100%')
    .height(this.bottomAreaHeight)
    .border({
      radius: {
        topLeft: $r('app.float.digit_panel_border_radius'),
        topRight: $r('app.float.digit_panel_border_radius'),
      }
    })
    .backgroundColor($r('sys.color.ohos_id_color_panel_bg'))
    .justifyContent(FlexAlign.SpaceBetween)
    .clip(true)
    .align(Alignment.Bottom)
    // .animation({
    //   duration: 2000,
    //   curve: this.curveMode,
    //   iterations: 1,
    //   playMode: PlayMode.Normal
    // })
  }

  build() {
    Navigation(this.pageInfos) {
      Column() {
        this.TopAreaBuilder()

        this.BottomAreaBuilder()
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .align(Alignment.Center)
      .backgroundColor($r('app.color.color_main_bg'))
      .onAreaChange((_, newValue: Area) => {
        this.onUpdateUI(newValue);
        if (this.isScienceMode) {
          this.calcSciencePanelSizeInfo(newValue);
        } else {
          this.calcPanelSizeInfo(newValue);
        }
      })
      .animation({
        duration: 1000,
        curve: this.curveMode,
        iterations: 1,
        playMode: PlayMode.Normal
      })
    }
    .navDestination(this.PageMap)
    .hideTitleBar(true)
    .hideToolBar(true)
    .mode(NavigationMode.Stack)
  }

  /**
   * update digit panel info.
   *
   * @param {area} area of digit panel
   */
  private onUpdateUI(area: Area): void {
    this.showSciencePanel = this.isScienceMode;
    let contentHeight: number = area.height as number;
    this.topAreaHeight = contentHeight * PC_HEIGHT_PERCENT;
    this.bottomAreaHeight = contentHeight - this.topAreaHeight;
  }

  /**
   * calculate size of standard panel.
   *
   * @param {area} area of digit panel
   */
  private calcPanelSizeInfo(area: Area): void {
    let baseWidth: number = area.width as number;
    let baseHeight: number = area.height as number;
    this.standPanelWidth = baseWidth;
    this.initSciPanelSize();
    let btnWidth: number = baseWidth * PageConstants.PANEL_BTN_WIDTH_PERCENT_BASE;
    let btnHeight: number = baseHeight * PageConstants.PANEL_BTN_HEIGHT_PERCENT_BASE;
    btnWidth = btnHeight;
    this.panelSizeInfo.btnFontSize = PageConstants.PANEL_BTN_FONT_SIZE_SM;
    this.panelSizeInfo.btnFontSizeFirstLine = PageConstants.PANEL_BTN_FONT_SIZE_FIRST_LINE_SM;
    this.panelSizeInfo.btnImageWidth = PageConstants.PANEL_BTN_IMG_WIDTH_SM;
    this.panelSizeInfo.btnImageHeight = PageConstants.PANEL_BTN_IMG_HEIGHT_SM;
    this.panelSizeInfo.btnWidth = btnWidth;
    this.panelSizeInfo.btnHeight = btnHeight;
    this.panelSizeInfo.btnRadius = (btnWidth > btnHeight ? btnHeight : btnWidth) / PageConstants.TWO_SIZE;
    this.panelSizeInfo.leftGap = this.calcPanelColumnsGap(baseWidth);
    this.panelSizeInfo.topGap = this.calcPanelRowsGap(this.bottomAreaHeight);
  }

  private initSciPanelSize(){
    let panelGap: number = PageConstants.PANEL_SCIENCE_GAP_BASE;
    let panelPaddingLeftRight: number = PageConstants.PANEL_SCIENCE_PADDING_LEFT_RIGHT_BASE;
    let panelWith = SCIENCE_WIDTH - panelGap - panelPaddingLeftRight;
    this.sciPanelWidth = panelWith * PageConstants.SCIENCE_PANEL_WIDTH_PERCENT + panelPaddingLeftRight;
  }

  /**
   * calculate column gap of digit panel.
   *
   * @param {number} panel width
   * @returns {number} column gap
   */
  private calcPanelColumnsGap(width: number): number {
    let padding: number = 0;
    padding = PageConstants.PANEL_PADDING_BASE;
    let panelWidth: number = width - padding * PageConstants.TWO_SIZE;
    let gap: number = (panelWidth - this.panelSizeInfo.btnWidth * PageConstants.PANEL_COLUMN_CNT) /
    PageConstants.PANEL_COLUMN_GAP_CNT;
    return gap;
  }

  /**
   * calculate row gap of digit panel.
   *
   * @param {number} panel height
   * @returns {number} row gap
   */
  private calcPanelRowsGap(height: number): number {
    let padding: number = 0;
    padding = PageConstants.PANEL_PADDING_BASE;
    let panelHeight: number = height - padding * PageConstants.TWO_SIZE;
    let gap: number = (panelHeight - this.panelSizeInfo.btnHeight * PageConstants.PANEL_ROW_CNT) /
    PageConstants.PANEL_ROW_GAP_CNT;
    return gap;
  }

  /**
   * calculate size of science panel.
   *
   * @param {area} area of digit panel
   */
  private calcSciencePanelSizeInfo(area: Area): void {
    let baseWidth: number = area.width as number;
    let panelGap: number = PageConstants.PANEL_SCIENCE_GAP_BASE;
    let panelPaddingLeftRight: number = PageConstants.PANEL_SCIENCE_PADDING_LEFT_RIGHT_BASE;
    let baseHeight: number = area.height as number;
    let btnWidth: number = baseWidth * PageConstants.PANEL_BTN_WIDTH_PERCENT_SCIENCE_BASE;
    let btnHeight: number = baseHeight * PageConstants.PANEL_BTN_HEIGHT_PERCENT_SCIENCE_BASE;
    btnHeight = baseHeight * PageConstants.PANEL_BTN_HEIGHT_PERCENT_SCIENCE_FOLD;
    btnWidth = btnHeight;
    this.panelSizeInfo.btnFontSize = PageConstants.PANEL_BTN_FONT_SIZE_SCIENCE_FOLD;
    this.panelSizeInfo.btnFontSizeFirstLine = PageConstants.PANEL_BTN_FONT_SIZE_FIRST_LINE_SCIENCE_FOLD;
    this.panelSizeInfo.btnImageWidth = PageConstants.PANEL_BTN_IMG_WIDTH_SCIENCE_FOLD;
    this.panelSizeInfo.btnImageHeight = PageConstants.PANEL_BTN_IMG_HEIGHT_SCIENCE_FOLD;
    this.panelSizeInfo.gridPadding = null;
    this.panelSizeInfo.btnWidth = btnWidth;
    this.panelSizeInfo.btnHeight = btnHeight;
    this.panelSizeInfo.btnRadius = (btnWidth > btnHeight ? btnHeight : btnWidth) / PageConstants.TWO_SIZE;
    let panelWith = baseWidth - panelGap - panelPaddingLeftRight;
    this.sciPanelWidth = panelWith * PageConstants.SCIENCE_PANEL_WIDTH_PERCENT + panelPaddingLeftRight;
    this.standPanelWidth = panelWith * PageConstants.STAND_PANEL_WIDTH_PERCENT + panelPaddingLeftRight;
    this.panelSizeInfo.leftGap = this.calcPanelColumnsGap(this.standPanelWidth);
    this.panelSizeInfo.topGap = this.calcPanelRowsGap(this.bottomAreaHeight);
  }
}