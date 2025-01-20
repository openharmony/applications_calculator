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

import worker from '@ohos.worker';
import window from '@ohos.window';
import common from '@ohos.app.ability.common';
// import systemParameterEnhance from '@ohos.systemParameterEnhance';

import {
  AdaptiveAgingUtil,
  BreakPointType,
  CommonUtil,
  GlobalThisHelper,
  IStandardPanelInfo,
  LogUtil,
  BREAKPOINT_SM_MD,
  BREAKPOINT_MD_SM,
  BREAKPOINT_MD_MD,
  BREAKPOINT_MD_LG,
  BREAKPOINT_LG_MD,
  BREAKPOINT_FULL_SCREEN,
  BREAKPOINT_FLOATING,
  BREAKPOINT_SPLIT_SCREEN_LEFT_RIGHT,
  BREAKPOINT_SPLIT_SCREEN_UP_DOWN,
  AccessibilityPlayUtil,
} from '@hmos/common';

import {
  DigitPanel,
  DigitPanelController,
  MenuItems,
  OperationView,
  IndexTitleBar,
  PhysicsButtonInfo,
  SimplePhysicsButtonInfo,
  AccessibilityInfo,
  ACCESSIBILITY_RECORD_IS_PLAY,
  ACCESSIBILITY_HISTORY_RECORD_PLAY,
} from '@hmos/calculation';
import { getWorker } from '../workers/WorkerUtil';
import { PanelSizeInfo } from '@hmos/calculation/src/main/ets/info/PanelSizeInfo';
import { PageConstants } from '../types';
import display from '@ohos.display';

const TAG: string = 'Main';
const PERSIST_SYS_FONT_SIZE_SCALE: string = 'persist.sys.font_scale_for_user0';
const DEFAULT_FONT_SIZE_SCALE: string = '1';
const DEFAULT_FONT_SCALE: string = '1.45';

PersistentStorage.persistProp('globalExpression', '');
PersistentStorage.persistProp('globalResult', '');
PersistentStorage.persistProp('radOrDegFlag', false);
PersistentStorage.persistProp('scienceFlag', false);

/**
 * Main page
 *
 * @since 2022-11-03
 */
@Entry
@Component
struct Main {
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  @BuilderParam historyRecordBuilder?: ($$: Record<string, string>) => void;
  private mDigitPanelController: DigitPanelController = DigitPanelController.getInstance();
  @State standList: Array<Array<SimplePhysicsButtonInfo>> = this.mDigitPanelController.getStandLists();
  @State scienceList: Array<Array<SimplePhysicsButtonInfo>> = this.mDigitPanelController.getScienceLists();
  @State isMemoryDisplay: boolean = false;
  @StorageLink('globalResult') result: string = '';
  @State worker: worker.ThreadWorker = getWorker();
  @StorageProp('updateUI') @Watch('onUpdateUI') timeStamp: number = 0;
  @StorageProp('updateUI') @Watch('onUpdateUI') sysFontSize: string = '1';
  @State topAreaHeight: number = 0;
  @State bottomAreaHeight: number = 0;
  @State panelSizeInfo: PanelSizeInfo = new PanelSizeInfo();
  @State adaptiveAging: AdaptiveAgingUtil = new AdaptiveAgingUtil();
  private mNavPathInfo: NavPathInfo = new NavPathInfo('history', null);
  private context = getContext(this) as common.UIAbilityContext;
  @Provide('inverseFlag') inverseFlag: boolean = false;
  @StorageLink('radOrDegFlag') radOrDegFlag: boolean = false;
  @Provide('invalidFlag') isInvalid: boolean = false;
  @StorageLink('scienceFlag') isScienceMode: boolean = false;
  @State showSciencePanel: boolean = false;
  @State sciPanelWidth: number = 0;
  @State standPanelWidth: number = 0;
  @State leftSafeWidth: number = 0;
  private isFoldable: boolean = display.isFoldable();
  private foldableStatus: number = display.getFoldStatus();
  private floatingOrSplit: boolean = false;
  private topAreaHeightBreakPoint: BreakPointType = new BreakPointType({
    mdLg: PageConstants.TOP_AREA_HEIGHT_HEIGHT_PERCENT_MD_TABLET,
    base: PageConstants.TOP_AREA_HEIGHT_HEIGHT_PERCENT_BASE,
  });
  private panelPadPadding: Padding = {
    left: PageConstants.PANEL_PADDING_PAD,
    top: PageConstants.PANEL_PADDING_PAD,
    right: PageConstants.PANEL_PADDING_PAD,
    bottom: PageConstants.PANEL_PADDING_PAD,
  };
  private loadHistoryRecordPage = () => {
    this.requireModule().then((res) => {
      if (res) {
        this.pageInfos.pushPath(this.mNavPathInfo);
      } else {
        LogUtil.error(TAG, 'fail to load page');
      }
    });
  };
  /**
   * change calculator mode.
   */
  private changeCalculatorMode = () => {
    this.isScienceMode = !this.isScienceMode;
    if (CommonUtil.getCurBp() === BREAKPOINT_MD_MD) {
      this.onUpdateUI('');
    } else {
      let orientation: window.Orientation = window.Orientation.PORTRAIT;
      if (this.isScienceMode) {
        orientation = CommonUtil.checkIfDeviceIsTablet() ?
          window.Orientation.LANDSCAPE : window.Orientation.LANDSCAPE_INVERTED;
      }
      GlobalThisHelper.get<window.Window>('mainWindow').setPreferredOrientation(orientation);
    }
  };
  private inputValue = (value?: PhysicsButtonInfo, keyValue?: string) => {
    if (value !== null && value !== undefined) {
      this.input(value);
    } else if (keyValue !== null && keyValue !== undefined) {
      this.input(undefined, keyValue);
    }
  };

  private accessibilityPlay = (isEmpty: Boolean) => {
    if (isEmpty) {
      LogUtil.info(TAG, 'RECORD_IS_PLAY');
      AccessibilityInfo.playAccessibilityByStr(ACCESSIBILITY_RECORD_IS_PLAY);
    } else {
      LogUtil.info(TAG, 'HISTORY_RECORD_PLAY');
      AccessibilityInfo.playAccessibilityByStr(ACCESSIBILITY_HISTORY_RECORD_PLAY);
    }
  }

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
        this.loadHistoryRecordPage();
      },
      enabled: true,
    }
  ];
  private standMap = new Map<string, number | Resource | string>()
    .set('PANEL_SM', PageConstants.PANEL_BTN_FONT_SIZE_SM)
    .set('PANEL_LINE_SM', PageConstants.PANEL_BTN_FONT_SIZE_FIRST_LINE_SM)
    .set('PANEL_IMG_WIDTH_SM', PageConstants.PANEL_BTN_IMG_WIDTH_SM)
    .set('PANEL_IMG_HEIGHT_SM', PageConstants.PANEL_BTN_IMG_HEIGHT_SM)
    .set('PANEL_MD', PageConstants.PANEL_BTN_FONT_SIZE_MD)
    .set('PANEL_LINE_MD', PageConstants.PANEL_BTN_FONT_SIZE_FIRST_LINE_MD)
    .set('PANEL_IMG_WIDTH_MD', PageConstants.PANEL_BTN_IMG_WIDTH_MD)
    .set('PANEL_IMG_HEIGHT_MD', PageConstants.PANEL_BTN_IMG_HEIGHT_MD)
    .set('PANEL_MD_TABLET', PageConstants.PANEL_BTN_FONT_SIZE_MD_TABLET)
    .set('PANEL_LINE_MD_TABLET', PageConstants.PANEL_BTN_FONT_SIZE_FIRST_LINE_MD_TABLET)
    .set('PANEL_IMG_WIDTH_MD_TABLET', PageConstants.PANEL_BTN_IMG_WIDTH_MD_TABLET)
    .set('PANEL_IMG_HEIGHT_MD_TABLET', PageConstants.PANEL_BTN_IMG_HEIGHT_MD_TABLET)
    .set('PANEL_LG', PageConstants.PANEL_BTN_FONT_SIZE_LG)
    .set('PANEL_LINE_LG', PageConstants.PANEL_BTN_FONT_SIZE_FIRST_LINE_LG)
    .set('PANEL_IMG_WIDTH_LG', PageConstants.PANEL_BTN_IMG_WIDTH_LG)
    .set('PANEL_IMG_HEIGHT_LG', PageConstants.PANEL_BTN_IMG_HEIGHT_LG)

  /**
   * Initialization operations in the appearance phase.
   */
  async aboutToAppear() {
    LogUtil.info(TAG, 'aboutToAppear： Main');
    this.mDigitPanelController.setWorker(getWorker());
    this.getFloatingOrSplitFlag();
    if (this.timeStamp > 0) {
      this.onUpdateUI('');
    }
    this.mDigitPanelController.getMemoryDisplay().then((flag)=>{
      this.isMemoryDisplay = flag;
    })
  }

  /**
   * Operation in the disappearing phase.
   */
  aboutToDisappear() {
    LogUtil.info(TAG, 'aboutToDisappear： Main');
  }

  onPageShow(): void {
    LogUtil.info(TAG, `onPageShow: Main isScienceMode: ${this.isScienceMode}`);
    this.getFloatingOrSplitFlag();
    if (!this.isScienceMode) {
      this.calcPanelSizeInfo();
    } else {
      this.calcSciencePanelSizeInfo();
    }
    this.context.reportDrawnCompleted((err) => {
      if (err.code) {
        // 处理业务逻辑错误
        LogUtil.error(TAG, `reportDrawnCompleted failed, code is ${err.code}, message is ${err.message}`);
        return;
      }
      // 执行正常业务
      LogUtil.info(TAG, 'Phone main page reportDrawnCompleted succeed');
    });
    CommonUtil.updateCopyResult(this.result);
  }

  private getFloatingOrSplitFlag() {
    let windowStatus: number = CommonUtil.getWindowStatus();
    this.floatingOrSplit = (windowStatus === BREAKPOINT_FLOATING || windowStatus === BREAKPOINT_SPLIT_SCREEN_UP_DOWN);
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
    let historyRecordBuilder = await import('@hmos/calculation/src/main/ets/historyrecord/HistoryRecord');
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
      .margin({ top: $r('app.float.display_M_margin_top') })


      IndexTitleBar({
        menuItems: this.menuItems,
        loadHistoryRecordPage: this.loadHistoryRecordPage,
        changeCalculatorMode: this.changeCalculatorMode,
        adaptiveAging: this.adaptiveAging,
        isScienceMode: this.isScienceMode,
        accessibilityPlay: this.accessibilityPlay,
      })

      OperationView({
        result: $result,
        isMemoryDisplay: $isMemoryDisplay,
        radOrDeg: this.radOrDegFlag,
        worker: $worker,
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
        Row().width(this.leftSafeWidth)
        DigitPanel({
          standList: $scienceList,
          inputValue: this?.inputValue,
          panelSizeInfo: this.panelSizeInfo,
          columnsTemplate: PageConstants.PANEL_SCIENCE_BTN_COLUMNS_TEMPLATE,
          radOrDegFlag: this.radOrDegFlag,
          isScience: this.showSciencePanel
        })
          .height('100%')
          .width('100%')
      }
      .width(this.sciPanelWidth)
      .margin({ left: this.showSciencePanel ? "0%" : "-"+this.sciPanelWidth })
      .height('100%')
      .animation({
        duration: 200,
        curve: Curve.Sharp,
        iterations: 1,
        playMode: PlayMode.Normal
      })
      Blank()
      Column() {
        DigitPanel({
          standList: $standList,
          inputValue: this?.inputValue,
          panelSizeInfo: this.panelSizeInfo,
          radOrDegFlag: this.radOrDegFlag,
          isScience: this.showSciencePanel
        })
      }
      .width(this.showSciencePanel ? "57%" : "100%")
      // .width(this.standPanelWidth)
      .animation({
        duration: 200,
        curve: Curve.Sharp,
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
    .clip(true)
    .align(Alignment.Bottom)
  }

  @Builder
  BottomAreaBuilderIsStandard() {
    Stack({ alignContent: Alignment.Center }) {
      if (this.isScienceMode) {
        this.BottomAreaBuilderScience()
      } else {
        this.BottomAreaBuilderStandard()
      }
    }
  }

  @Builder
  BottomAreaBuilderScience(){
    Row() {
      Column() {
        DigitPanel({
          standList: $scienceList,
          inputValue: this?.inputValue,
          panelSizeInfo: this.panelSizeInfo,
          columnsTemplate: PageConstants.PANEL_SCIENCE_BTN_COLUMNS_TEMPLATE,
          radOrDegFlag: this.radOrDegFlag
        })
      }
      .width(this.sciPanelWidth)
      Column() {
        DigitPanel({
          standList: $standList,
          inputValue: this?.inputValue,
          panelSizeInfo: this.panelSizeInfo,
          radOrDegFlag: this.radOrDegFlag,
          isScience: this.showSciencePanel
        })
      }
      .width(this.standPanelWidth)
    }.width('100%')
    .height(this.bottomAreaHeight)
    .border({
      radius: {
        topLeft: $r('app.float.digit_panel_border_radius'),
        topRight: $r('app.float.digit_panel_border_radius'),
      }
    })
    .backgroundColor($r('sys.color.ohos_id_color_panel_bg'))
    .clip(true)
    .align(Alignment.Bottom)
    .transition(TransitionEffect.OPACITY.animation({ duration: 2000, curve: Curve.Ease }).combine(
      TransitionEffect.IDENTITY
    ))
  }
  @Builder
  BottomAreaBuilderStandard(){
    Row() {
      Column() {
        DigitPanel({
          standList: $standList,
          inputValue: this?.inputValue,
          panelSizeInfo: this.panelSizeInfo,
          radOrDegFlag: this.radOrDegFlag,
          isScience: this.showSciencePanel
        })
      }
      .width(this.standPanelWidth)
    }.width('100%')
    .height(this.bottomAreaHeight)
    .border({
      radius: {
        topLeft: $r('app.float.digit_panel_border_radius'),
        topRight: $r('app.float.digit_panel_border_radius'),
      }
    })
    .backgroundColor($r('sys.color.ohos_id_color_panel_bg'))
    .clip(true)
    .align(Alignment.Bottom)
    .transition(TransitionEffect.OPACITY.animation({ duration: 2000, curve: Curve.Ease }).combine(
      TransitionEffect.IDENTITY
    ))
  }

  build() {
    Navigation(this.pageInfos) {
      Column() {
        Row()
          .width('100%')
          .height(this.floatingOrSplit ? 0 : CommonUtil.getTopSafeHeight())

        this.TopAreaBuilder()

        if(this.isFoldable && this.foldableStatus === FoldStatus.FOLD_STATUS_EXPANDED){
          this.BottomAreaBuilder()
        } else {
          this.BottomAreaBuilderIsStandard()
        }

        Row()
          .width('100%')
          .height(this.floatingOrSplit ? 0 : CommonUtil.getBottomSafeHeight())
          .backgroundColor($r('app.color.color_bottom'))
      }
      .width('100%')
      .height('100%')
      .alignItems(HorizontalAlign.Center)
      .align(Alignment.Center)
      .backgroundColor($r('app.color.color_main_bg'))
    }
    .navDestination(this.PageMap)
    .hideTitleBar(true)
    .hideToolBar(true)
    .mode(NavigationMode.Stack)
  }

  private onUpdateUI(propName: string): void {
    if (this.isScienceMode && CommonUtil.getCurBp() === BREAKPOINT_SM_MD) {
      this.isScienceMode = false;
      this.changeCalculatorMode();
      return;
    }
    if (CommonUtil.getCurBp() === BREAKPOINT_MD_MD) {
      GlobalThisHelper.get<window.Window>('mainWindow').setPreferredOrientation(window.Orientation.AUTO_ROTATION);
    }
    this.showSciencePanel = this.isScienceMode;
    let contentHeight: number = CommonUtil.getContentHeight();
    let topAreaHeightPercent: number = this.topAreaHeightBreakPoint.getValue(CommonUtil.getCurBp()) as number;
    this.topAreaHeight = contentHeight * topAreaHeightPercent;
    this.bottomAreaHeight = contentHeight - this.topAreaHeight;
    if (this.isScienceMode) {
      this.calcSciencePanelSizeInfo();
    } else {
      this.calcPanelSizeInfo();
    }
  }

  private calcPanelSizeInfo(): void {
    let baseWidth: number = CommonUtil.getContentWidth();
    let baseHeight: number = CommonUtil.getContentHeight();
    let panelGap: number = PageConstants.PANEL_SCIENCE_GAP_BASE;
    let panelPaddingLeftRight: number = PageConstants.PANEL_SCIENCE_PADDING_LEFT_RIGHT_BASE;
    this.standPanelWidth = baseWidth;
    let btnWidth: number = baseWidth * PageConstants.PANEL_BTN_WIDTH_PERCENT_BASE;
    let btnHeight: number = baseHeight * PageConstants.PANEL_BTN_HEIGHT_PERCENT_BASE;
    let isFontMax: boolean = false;
    isFontMax = this.getFontMaxFlag(isFontMax);
    this.setPanelSizeInfo(isFontMax)
    switch (CommonUtil.getCurBp()) {
      case BREAKPOINT_SM_MD:
        btnHeight = btnWidth;
        break;
      case BREAKPOINT_MD_SM:
        panelGap = PageConstants.PANEL_SCIENCE_GAP_MD_SM;
        break;
      case BREAKPOINT_LG_MD:
      default:
        panelPaddingLeftRight = PageConstants.PANEL_SCIENCE_PADDING_LEFT_RIGHT_LG_MD;
        break;
    }
    let panelWith = baseWidth - panelGap - panelPaddingLeftRight;
    this.sciPanelWidth = panelWith * PageConstants.SCIENCE_PANEL_WIDTH_PERCENT + panelPaddingLeftRight;
    this.panelSizeInfo.btnWidth = btnWidth;
    this.panelSizeInfo.btnHeight = btnHeight;
    this.panelSizeInfo.btnRadius = (btnWidth > btnHeight ? btnHeight : btnWidth) / PageConstants.TWO_SIZE;
    this.panelSizeInfo.leftGap = this.calcPanelColumnsGap(baseWidth);
    this.panelSizeInfo.topGap = this.calcPanelRowsGap(this.bottomAreaHeight);
    this.panelSizeInfo.isScienceMode = false;
  }

  private setPanelSizeInfo(isFontMax: boolean): void {
    switch (CommonUtil.getCurBp()) {
      case BREAKPOINT_SM_MD: {
        let standInfo: IStandardPanelInfo = {
          isFont: isFontMax,
          suffix: 'sm',
        }
        this.generatePanelSizeInfo(standInfo);
        break;
      }
      case BREAKPOINT_MD_MD: {
        let standInfo: IStandardPanelInfo = {
          isFont: isFontMax,
          suffix: 'md',
        }
        this.generatePanelSizeInfo(standInfo);
        break;
      }
      case BREAKPOINT_MD_LG: {
        let standInfo: IStandardPanelInfo = {
          isFont: isFontMax,
          suffix: 'md_tablet',
        }
        this.generatePanelSizeInfo(standInfo);
        break;
      }
      case BREAKPOINT_LG_MD:
      default: {
        let standInfo: IStandardPanelInfo = {
          isFont: isFontMax,
          suffix: 'lg',
        }
        this.generatePanelSizeInfo(standInfo);
        break;
      }
    }
  }

  private getFontMaxFlag(isFontMax: boolean): boolean {
    try {
      this.sysFontSize = AdaptiveAgingUtil.getDigitFontScale();
    } catch (error) {
      LogUtil.error(TAG, 'failed to load system font-size: ', error.message);
      return false;
    }
    if (Number(this.sysFontSize) > Number(DEFAULT_FONT_SCALE)) {
      isFontMax = true;
    }
    return isFontMax;
  }

  private generatePanelSizeInfo(standInfo: IStandardPanelInfo): void {
    let fontSizeMax: Resource = $r(`app.float.panel_btn_font_size_${standInfo.suffix}`);
    let fontSizeFirstLineMax: Resource = $r(`app.float.panel_btn_font_size_first_line_${standInfo.suffix}`);
    let fontString: string = `PANEL_${standInfo.suffix.toUpperCase()}`
    let fontSize: Resource = this.standMap.get(fontString) as Resource;
    let fontLineString: string = `PANEL_LINE_${standInfo.suffix.toUpperCase()}`
    let fontSizeFirstLine: Resource = this.standMap.get(fontLineString) as Resource;
    let imageWidthString: string = `PANEL_IMG_WIDTH_${standInfo.suffix.toUpperCase()}`
    let imageWidth: number = this.standMap.get(imageWidthString) as number;
    let imageHeightString: string = `PANEL_IMG_HEIGHT_${standInfo.suffix.toUpperCase()}`
    let imageHeight: number = this.standMap.get(imageHeightString) as number;
    console.log('sthu fontString:' + fontString + ' fontLineString:' + fontLineString +
      ' imageWidthString:' + imageWidthString + ' imageHeightString:' + imageHeightString)
    if (standInfo.isFont) {
      this.panelSizeInfo.btnFontSize = fontSizeMax;
      this.panelSizeInfo.btnFontSizeFirstLine = fontSizeFirstLineMax;
    } else {
      this.panelSizeInfo.btnFontSize = fontSize;
      this.panelSizeInfo.btnFontSizeFirstLine = fontSizeFirstLine;
    }
    this.panelSizeInfo.btnImageWidth = imageWidth;
    this.panelSizeInfo.btnImageHeight = imageHeight;
  }

  private calcPanelColumnsGap(width: number): number {
    let padding: number = 0;
    if (CommonUtil.checkIfDeviceIsTablet()) {
      padding = PageConstants.PANEL_PADDING_PAD;
    } else {
      padding = PageConstants.PANEL_PADDING_BASE;
    }
    let panelWidth: number = width - padding * PageConstants.TWO_SIZE;
    let gap: number = (panelWidth - this.panelSizeInfo.btnWidth * PageConstants.PANEL_COLUMN_CNT) /
    PageConstants.PANEL_COLUMN_GAP_CNT;
    return gap;
  }

  private calcPanelRowsGap(height: number): number {
    let padding: number = 0;
    if (CommonUtil.checkIfDeviceIsTablet()) {
      padding = PageConstants.PANEL_PADDING_PAD;
    } else {
      padding = PageConstants.PANEL_PADDING_BASE;
    }
    let panelHeight: number = height - padding * PageConstants.TWO_SIZE;
    let gap: number = (panelHeight - this.panelSizeInfo.btnHeight * PageConstants.PANEL_ROW_CNT) /
    PageConstants.PANEL_ROW_GAP_CNT;
    return gap;
  }

  private calcSciencePanelSizeInfo(): void {
    this.leftSafeWidth = CommonUtil.getCurBp() === BREAKPOINT_MD_SM ? CommonUtil.getTopSafeHeight() : 0;
    let baseWidth: number = CommonUtil.getContentWidth() - this.leftSafeWidth;
    let panelGap: number = PageConstants.PANEL_SCIENCE_GAP_BASE;
    let panelPaddingLeftRight: number = PageConstants.PANEL_SCIENCE_PADDING_LEFT_RIGHT_BASE;
    let baseHeight: number = CommonUtil.getContentHeight();
    let btnWidth: number = baseWidth * PageConstants.PANEL_BTN_WIDTH_PERCENT_SCIENCE_BASE;
    let btnHeight: number = baseHeight * PageConstants.PANEL_BTN_HEIGHT_PERCENT_SCIENCE_BASE;
    switch (CommonUtil.getCurBp()) {
      case BREAKPOINT_MD_MD:
        // 折叠屏 展开横屏 + 展开竖屏
        btnHeight = baseHeight * PageConstants.PANEL_BTN_HEIGHT_PERCENT_SCIENCE_FOLD;
        btnWidth = btnHeight;
        this.panelSizeInfo.btnFontSize = $r('app.float.panel_btn_font_size_science_fold');
        this.panelSizeInfo.btnFontSizeFirstLine = $r('app.float.panel_btn_font_size_first_line_science_fold');
        this.panelSizeInfo.btnImageWidth = PageConstants.PANEL_BTN_IMG_WIDTH_SCIENCE_FOLD;
        this.panelSizeInfo.btnImageHeight = PageConstants.PANEL_BTN_IMG_HEIGHT_SCIENCE_FOLD;
        this.panelSizeInfo.gridPadding = null;
        break;
      case BREAKPOINT_LG_MD:
        // 平板
        panelPaddingLeftRight = PageConstants.PANEL_SCIENCE_PADDING_LEFT_RIGHT_LG_MD;
        this.panelSizeInfo.btnFontSize = $r('app.float.panel_btn_font_size_science_pad');
        this.panelSizeInfo.btnFontSizeFirstLine = $r('app.float.panel_btn_font_size_first_line_science_pad');
        this.panelSizeInfo.btnImageWidth = PageConstants.PANEL_BTN_IMG_WIDTH_SCIENCE_PAD;
        this.panelSizeInfo.btnImageHeight = PageConstants.PANEL_BTN_IMG_HEIGHT_SCIENCE_PAD;
        this.panelSizeInfo.gridPadding = this.panelPadPadding;
        break;
      case BREAKPOINT_MD_SM:
      default:
        // 手机
        panelGap = PageConstants.PANEL_SCIENCE_GAP_MD_SM;
        this.panelSizeInfo.btnFontSize = $r('app.float.panel_btn_font_size_science_phone');
        this.panelSizeInfo.btnFontSizeFirstLine = $r('app.float.panel_btn_font_size_first_line_science_phone');
        this.panelSizeInfo.btnImageWidth = PageConstants.PANEL_BTN_IMG_WIDTH_SCIENCE_PHONE;
        this.panelSizeInfo.btnImageHeight = PageConstants.PANEL_BTN_IMG_HEIGHT_SCIENCE_PHONE;
        this.panelSizeInfo.gridPadding = null;
        break;
    }
    this.panelSizeInfo.btnWidth = btnWidth;
    this.panelSizeInfo.btnHeight = btnHeight;
    this.panelSizeInfo.btnRadius = (btnWidth > btnHeight ? btnHeight : btnWidth) / PageConstants.TWO_SIZE;
    let panelWith = baseWidth - panelGap - panelPaddingLeftRight;
    this.sciPanelWidth = panelWith * PageConstants.SCIENCE_PANEL_WIDTH_PERCENT + panelPaddingLeftRight;
    this.standPanelWidth = panelWith * PageConstants.STAND_PANEL_WIDTH_PERCENT + panelPaddingLeftRight;
    this.panelSizeInfo.leftGap = this.calcPanelColumnsGap(this.standPanelWidth);
    this.panelSizeInfo.topGap = this.calcPanelRowsGap(this.bottomAreaHeight);
    this.panelSizeInfo.isScienceMode = true;
  }
}