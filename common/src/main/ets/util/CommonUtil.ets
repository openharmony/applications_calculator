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

import window from '@ohos.window';
import deviceInfo from '@ohos.deviceInfo';
import display from '@ohos.display';
import systemDateTime from '@ohos.systemDateTime';
import { DisplayUtil, GlobalThisHelper } from '.';
import {
  KEY_CONTENT_WIDTH,
  KEY_CONTENT_HEIGHT,
  KEY_WINDOW_WIDTH,
  BREAKPOINT_LG,
  BREAKPOINT_MD,
  BREAKPOINT_SM,
  BREAKPOINT_XS,
  RANGE_LG,
  RANGE_MD,
  RANGE_SM,
  KEY_WINDOW_HEIGHT,
  BREAKPOINT_FULL_SCREEN,
  BREAKPOINT_FLOATING,
  BREAKPOINT_SPLIT_SCREEN_LEFT_RIGHT,
  BREAKPOINT_SPLIT_SCREEN_UP_DOWN,
  SPLIT_SCREEN_MULTIPLE_HALF,
  SPLIT_SCREEN_MULTIPLE_ONE_THIRD,
  SPLIT_SCREEN_MULTIPLE_TWO_THIRD,
  PANEL_FONT_SIZE_MIN,
} from '../types';
import { BusinessError } from '@ohos.base';

const TAG: string = 'Common_Util';
const DEFAULT_FONT_SIZE: number = 16;
const DEVICE_TYPE_PHONE: string = 'phone';
const DEVICE_TYPE_PC: string = '2in1';
const DEVICE_TYPE_TABLET: string = 'tablet';
const FOLD_STATUS_EXPANDED: number = 1;
const FOLD_STATUS_FOLDED: number = 2;
const FOLD_STATUS_HALF_FOLDED: number = 3;

/**
 * Common Util
 *
 * @since 2022-11-07
 */
export class CommonUtil {
  /**
   * Check whether the current device is a mobile phone.
   *
   * @return {boolean} Whether the current device is a mobile phone.
   */
  static checkIfDeviceIsPhone(): boolean {
    return deviceInfo.deviceType === DEVICE_TYPE_PHONE;
  }

  /**
   * Check whether the phone is foldable.
   *
   * @return {boolean} Whether the phone is foldable.
   */
  static checkIfDeviceIsFold(): boolean {
    return display.isFoldable();
  }

  /**
   * Check whether the foldable phone is expanded.
   *
   * @return {boolean} Whether the foldable phone is expanded.
   */
  static checkFoldIsExpanded(): boolean {
    return display.getFoldStatus() === FOLD_STATUS_EXPANDED;
  }

  /**
   * Check whether the foldable phone is folded.
   *
   * @return {boolean} Whether the foldable phone is folded.
   */
  static checkFoldIsFolded(): boolean {
    return display.getFoldStatus() === FOLD_STATUS_FOLDED;
  }

  /**
   * Check whether the foldable phone is half-folded.
   *
   * @return {boolean} Whether the foldable phone is half-folded.
   */
  static checkFoldIsHalfFolded(): boolean {
    return display.getFoldStatus() === FOLD_STATUS_HALF_FOLDED;
  }

  /**
   * Check whether the current device is a pc.
   *
   * @return {boolean} Whether the current device is a pc.
   */
  static checkIfDeviceIsPC(): boolean {
    return deviceInfo.deviceType === DEVICE_TYPE_PC;
  }

  /**
   * Check whether the current device is a tablet.
   *
   * @return {boolean} Whether the current device is a tablet.
   */
  static checkIfDeviceIsTablet(): boolean {
    return deviceInfo.deviceType === DEVICE_TYPE_TABLET;
  }

  public static isLandSpace(): boolean {
    let curOrientation: display.Orientation = display.getDefaultDisplaySync().orientation;
    return curOrientation === display.Orientation.LANDSCAPE ||
      curOrientation === display.Orientation.LANDSCAPE_INVERTED;
  }

  public static setContentWidth(num: number): void {
    GlobalThisHelper.set(KEY_CONTENT_WIDTH, num);
  }

  public static getContentWidth(): number {
    return GlobalThisHelper.get<number>(KEY_CONTENT_WIDTH, 0);
  }

  public static setContentHeight(num: number): void {
    GlobalThisHelper.set(KEY_CONTENT_HEIGHT, num);
  }

  public static getContentHeight(): number {
    return GlobalThisHelper.get<number>(KEY_CONTENT_HEIGHT, 0);
  }

  public static getDisPlayWidth(): number {
    return DisplayUtil.px2vpInTs(display.getDefaultDisplaySync().width);
  }

  public static getDisPlayHeight(): number {
    return DisplayUtil.px2vpInTs(display.getDefaultDisplaySync().height);
  }

  public static getWindowWidth(): number {
    return GlobalThisHelper.get<number>(KEY_WINDOW_WIDTH, CommonUtil.getDisPlayWidth());
  }

  public static getWindowHeight(): number {
    return GlobalThisHelper.get<number>(KEY_WINDOW_HEIGHT, CommonUtil.getDisPlayHeight());
  }

  public static getTopSafeHeight(): number {
    return CommonUtil.getNumberFromAppStorage('topSafeHeight');
  }

  public static updateTopSafeHeight(safeHeight: number): void {
    AppStorage.setOrCreate('topSafeHeight', DisplayUtil.px2vpInTs(safeHeight));
  }

  public static getBottomSafeHeight(): number {
    return CommonUtil.getNumberFromAppStorage('bottomSafeHeight');
  }

  public static updateBottomSafeHeight(safeHeight: number): void {
    AppStorage.setOrCreate('bottomSafeHeight', DisplayUtil.px2vpInTs(safeHeight));
  }

  public static updateWindowSize(windowSize: window.Size): void {
    CommonUtil.setWindowWidth(DisplayUtil.px2vpInTs(windowSize.width));
    CommonUtil.setWindowHeight(DisplayUtil.px2vpInTs(windowSize.height));
    let widthBp: string = CommonUtil.getCurrentBreakpoint(CommonUtil.getWindowWidth());
    let heightBp: string = CommonUtil.getCurrentBreakpoint(CommonUtil.getWindowHeight());
    CommonUtil.setCurBp(`${widthBp}_${heightBp}`);
    let windowStatus: number = CommonUtil.updateWidowStatus();
    CommonUtil.setWindowStatus(windowStatus);
    CommonUtil.notifyUpdateUI();
  }

  public static updateWidowStatus(){
    let disPlayWidth: number = CommonUtil.getDisPlayWidth();
    let disPlayHeight: number = CommonUtil.getDisPlayHeight();
    let windowWidth: number = CommonUtil.getWindowWidth();
    let windowHeight: number = CommonUtil.getWindowHeight();

    let windowStatus: number = BREAKPOINT_FULL_SCREEN;
    if (windowWidth < disPlayWidth && windowHeight < disPlayHeight) {
      windowStatus = BREAKPOINT_FLOATING;
    } else if (windowWidth < disPlayWidth && windowHeight === disPlayHeight) {
      windowStatus = BREAKPOINT_SPLIT_SCREEN_LEFT_RIGHT;
    } else if (windowWidth === disPlayWidth && windowHeight < disPlayHeight) {
      windowStatus = BREAKPOINT_SPLIT_SCREEN_UP_DOWN;
      CommonUtil.updateSplitScreenMultiple(windowHeight, disPlayHeight);
    } else if (windowWidth === disPlayWidth && windowHeight === disPlayHeight){
      windowStatus = BREAKPOINT_FULL_SCREEN;
    }
    return windowStatus
  }

  public static setWindowStatus(status: number){
    AppStorage.setOrCreate('currentWindowStatus', status);
  }
  public static getWindowStatus(): number {
    let status: number | undefined = AppStorage.get<number>('currentWindowStatus');
    return status ? status : 0;
  }

  static updateSplitScreenMultiple(windowHeight: number,disPlayHeight: number){
    if(windowHeight < disPlayHeight * 0.4){
      CommonUtil.setSplitScreenMultiple(SPLIT_SCREEN_MULTIPLE_ONE_THIRD)
    }else if(windowHeight > disPlayHeight * 0.6){
      CommonUtil.setSplitScreenMultiple(SPLIT_SCREEN_MULTIPLE_TWO_THIRD)
    }else{
      CommonUtil.setSplitScreenMultiple(SPLIT_SCREEN_MULTIPLE_HALF)
    }
  }
  public static setSplitScreenMultiple(multiple: number){
    AppStorage.setOrCreate('splitScreenMultiple', multiple);
  }
  public static getSplitScreenMultiple(): number {
    let status: number | undefined = AppStorage.get<number>('splitScreenMultiple');
    return status ? status : 0;
  }
  public static setSplitFontSize(value: number | string | Resource | undefined): string{
    let string: string | number = '';
    if (typeof value === 'number') {
      string = value;
    } else if (typeof value === 'string') {
      string = value;
    } else if (value === undefined) {
      string = DEFAULT_FONT_SIZE;
    } else {
      try {
        string = getContext().resourceManager.getStringSync((value as Resource).id);
      } catch (err) {
        string = DEFAULT_FONT_SIZE;
      }
    }
    let regex: RegExp = new RegExp("(-?\\d+(?:\\.\\d+)?)_?(fp|vp|px|lpx|%)?$", "i");
    let matches: RegExpMatchArray | null = string.toString().match(regex);
    if (!matches) {
      return '0';
    }
    let length: number = Number(matches?.[1] ?? 0);
    let unit: string = matches?.[2] ?? ''
    let multiple = CommonUtil.getSplitScreenMultiple();
    switch (multiple){
      case SPLIT_SCREEN_MULTIPLE_HALF:
        length = (length * 0.5);
        break;
      case SPLIT_SCREEN_MULTIPLE_ONE_THIRD:
        length = (length * 0.333);
        break;
      case SPLIT_SCREEN_MULTIPLE_TWO_THIRD:
        length = (length * 0.666);
        break;
      default :
        break;
    }
    length = length < PANEL_FONT_SIZE_MIN ? PANEL_FONT_SIZE_MIN : length;
    return length + unit;
  }

  public static notifyUpdateUI() {
    let contentWidth: number = CommonUtil.getWindowWidth();
    let contentHeight: number = CommonUtil.getWindowHeight() - CommonUtil.getTopSafeHeight() -
    CommonUtil.getBottomSafeHeight();
    if (contentHeight != CommonUtil.getContentHeight() || contentWidth != CommonUtil.getContentWidth()) {
      CommonUtil.setContentWidth(contentWidth);
      CommonUtil.setContentHeight(contentHeight);
      AppStorage.setOrCreate('updateUI', systemDateTime.getTime());
    }
  }

  private static setCurBp(bp: string): void {
    AppStorage.setOrCreate('currentBreakPoint', bp);
  }

  public static setWindowWidth(width: number): void {
    GlobalThisHelper.set<number>(KEY_WINDOW_WIDTH, width);
  }

  public static setWindowHeight(height: number): void {
    GlobalThisHelper.set<number>(KEY_WINDOW_HEIGHT, height);
  }

  public static getCurBp(): string {
    let bp: string | undefined = AppStorage.get<string>('currentBreakPoint');
    return bp ? bp : '';
  }

  public static getCurrentBreakpoint(size: number): string {
    if (size >= RANGE_LG) {
      return BREAKPOINT_LG;
    } else if (size >= RANGE_MD) {
      return BREAKPOINT_MD;
    } else if (size >= RANGE_SM) {
      return BREAKPOINT_SM;
    } else {
      return BREAKPOINT_XS;
    }
  }

  public static getNumberFromAppStorage(key: string): number {
    let num: number | undefined = AppStorage.get<number>(key);
    if (num === undefined) {
      num = 0;
    }
    return num!;
  }

  public static getTextInputOffset(): number {
    return CommonUtil.getNumberFromAppStorage('textInputIndex');
  }

  public static updateTextInputOffset(textInputOffset: number): void {
    AppStorage.setOrCreate('textInputIndex', textInputOffset);
  }

  public static getBooleanFromAppStorage(key: string): boolean {
    let num: boolean | undefined = AppStorage.get<boolean>(key);
    if (num === undefined) {
      num = false;
    }
    return num!;
  }

  public static getScienceFlag(): boolean {
    return CommonUtil.getBooleanFromAppStorage('scienceFlag');
  }

  public static updateScienceFlag(scienceFlag: boolean): void {
    AppStorage.setOrCreate('scienceFlag', scienceFlag);
  }

  public static checkIfDeviceIsStandPhone(): boolean {
    if (CommonUtil.checkIfDeviceIsPhone() &&
      (CommonUtil.checkFoldIsExpanded() || CommonUtil.checkFoldIsHalfFolded())) {
      return true;
    } else {
      return false;
    }
  }

  public static getCopyResult(): string {
    // 添加result全局变量
    return CommonUtil.getStringFromAppStorage('copyResult');
  }

  public static updateCopyResult(globalResult: string): void {
    AppStorage.setOrCreate('copyResult', globalResult);
  }

  public static getStringFromAppStorage(key: string): string {
    // 获取AppStorage里的string值
    let string: string | undefined = AppStorage.get<string>(key);
    if (string === undefined) {
      string = '';
    }
    return string;
  }

  /**
   * 将页面显示的光标位置转换为表达式的光标位置.
   *
   * @param displayExp 页面展示的表达式.
   * @param displayIndex 页面显示的光标位置
   * @returns 实际表达式的光标位置.
   */
  public static displayIndexToExpIndex(displayExp: string, displayIndex: number): number {
    let expIndex: number = displayIndex;
    for (let i = 0; i < displayIndex; i++) {
      if (displayExp.charAt(i) === ',') {
        expIndex--;
      }
    }
    return expIndex;
  }

  /**
   * 将实际表达式的光标位置转换为页面显示的光标位置.
   *
   * @param displayExp 实际的表达式.
   * @param displayIndex 实际表达式的光标位置
   * @returns 页面显示的光标位置.
   */
  public static expIndexToDisplayIndex(exp: string, expIndex: number): number {
    let displayExp: string = CommonUtil.getDisplayExp(exp);
    let cursorIndex: number = 0;
    let displayIndex: number = expIndex;
    for (let i = 0; i < displayExp.length; i++) {
      if (displayExp.charAt(i) === ',') {
        displayIndex++;
      } else {
        cursorIndex++;
      }
      if (cursorIndex >= expIndex) {
        break;
      }
    }
    if (displayExp.charAt(displayIndex) === ',') {
      displayIndex++;
    }
    return displayIndex;
  }

  /**
   * 如果在特殊字符串里粘贴数字，将光标位置重新计算
   *
   * @param 光标位置
   * @param 展示的字符串
   * @returns 重新计算后的光标位置
   */
  public static getSpecialIndex(index: number, value: string): number {
    let startIndex: number = index;
    for (let i = startIndex; i < value.length; i++) {
      if (['a', 'c', 'o', 'n', 'l', 's', 'g', 't', 'i', '\u207B', '\u00B9', '('].includes(value[i])) {
        index = i + 1;
        if (value[i] === '(') {
          break;
        }
      }
    }
    return index;
  }

  /**
   * 将表达式转换为用户界面展示的表达式.
   *
   * @param value 计算表达式.
   * @returns 用于页面展示的表达式.
   */
  public static getDisplayExp(value: string): string {
    const result: string = DisplayUtil.formatAddSeparator(value);
    return result;
  }

  /**
   * 粘贴插入位置及附近数字小数点判断及转换
   *
   * @param numberArr: 操作的字符数组
   * @param setIndex: 位置索引
   * @returns 插入后获取的字符串
   */
  public static splitNumber(numberArr: string[], setIndex: number): string {
    numberArr = CommonUtil.formatPasteNumber(numberArr, setIndex);
    // 将粘贴内容与前面的数字拼接并去除逗号和0
    let frontNum: string = '';
    if ((numberArr[setIndex].length > 1 && numberArr[setIndex][0] === '.') ||
      (numberArr[setIndex].length > 2 && numberArr[setIndex][0] === '-' && numberArr[setIndex][1] === '.')) {
      // 如果去小数操作后的字符串为'.xx'或者'-.xx'的形式
      if (setIndex === 0) {
        frontNum += numberArr[setIndex]
      } else {
        for (let i = 0; i <= setIndex; i++) {
          frontNum += numberArr[i].toString();
        }
      }
    } else if (numberArr[setIndex].includes('-')) {
      frontNum = CommonUtil.splitNumberWithMinus(numberArr, setIndex);
    } else {
      frontNum = CommonUtil.splitNumberWithoutMinus(numberArr, setIndex);
    }
    // 将粘贴内容后面的数字拼接并去除逗号
    let afterNum: string = '';
    for (let i = setIndex + 1; i < numberArr.length; i++) {
      afterNum += numberArr[i].toString();
    }
    afterNum = afterNum.replace(new RegExp(',', 'g'), '');
    return frontNum + afterNum;
  }

  /**
   * 将粘贴的数字去除小数点
   *
   * @param numberArr 操作的字符串数组
   * @param setIndex 位置索引
   * @returns 去除小数点后的字符串数组
   */
  private static formatPasteNumber(numberArr: string[], setIndex: number): string[] {
    if (numberArr[setIndex].indexOf('.') >= 0 && numberArr.indexOf('.') >= 0) {
      if (numberArr[setIndex].includes('-') && setIndex > numberArr.indexOf('.')) {
        // 如果粘贴内容包含负号，切在所在内容数字数组里的小数点后面，则不进行任何操作
      } else {
        numberArr[setIndex] = numberArr[setIndex].replace('.', '');
      }
    }
    return numberArr;
  }

  /**
   * 如果粘贴的内容包含符号-
   *
   * @param numberArr 操作的字符串数组
   * @param setIndex 字符索引位置
   * @returns 处理后的字符串
   */
  private static splitNumberWithMinus(numberArr: string[], setIndex: number): string {
    let frontNum: string = '';
    if (setIndex < numberArr.length - 1 && numberArr[setIndex + 1] === '.') {
      while (DisplayUtil.checkFrontZero(numberArr[setIndex])) {
        numberArr[setIndex] = numberArr[setIndex].replace('0', '');
      }
    } else {
      while (numberArr[setIndex][1] === '0') {
        numberArr[setIndex] = numberArr[setIndex].replace('0', '');
      }
    }
    for (let i = 0; i <= setIndex; i++) {
      frontNum += numberArr[i].toString();
    }
    return frontNum;
  }

  /**
   * 如果粘贴的内容为不带符号的纯数字
   *
   * @param numberArr 操作的字符串数组
   * @param setIndex 字符索引位置
   * @returns 处理后的字符串
   */
  private static splitNumberWithoutMinus(numberArr: string[], setIndex: number): string {
    let frontNum: string = '';
    if (setIndex === 0) {
      if (numberArr.length === 1 || (numberArr.length > 1 && numberArr[setIndex + 1] === '.')) {
        while (DisplayUtil.checkFrontZero(numberArr[setIndex])) {
          numberArr[setIndex] = numberArr[setIndex].replace('0', '');
        }
      } else {
        while (numberArr[setIndex][0] === '0') {
          numberArr[setIndex] = numberArr[setIndex].replace('0', '');
        }
      }
    }
    for (let i = 0; i <= setIndex; i++) {
      frontNum += numberArr[i].toString();
    }
    while (DisplayUtil.checkFrontZero(frontNum)) {
      frontNum = frontNum.replace('0', '');
    }
    return frontNum;
  }

  /**
   * isPastePressed
   *
   * type类型是否剪切
   */
  public  static  isPastePressed(value: string, type: string) :boolean {
    if (type === 'cut' && value.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  /**
   * isPastePressed
   *
   * globalExpression是否是空
   */
  public  static  checkPastePressed( isPastePressed: boolean) :boolean {
    if (AppStorage.get<string>('globalExpression') === '') {
      CommonUtil.updateCopyResult('');
      AppStorage.set<string>('globalResult','');
      return false;
    }
    return isPastePressed;
  }

  /**
   * finalTextInputIndex
   *
   * 返回复制粘贴后最新的坐标
   */
  public static setFinalTextInputIndex(value :string,index:number,displayExpression:string) : number{
    let trueIndex: number = CommonUtil.getTrueIndex(index,displayExpression);
    let globalExp = AppStorage.get<string>('globalExpression') ?? '';
    trueIndex = CommonUtil.displayIndexToExpIndex(displayExpression, trueIndex);
    let finalIndex = globalExp.length - trueIndex;
    // 定义粘贴位置附近的数字元素列表，记录粘贴内容在提取数字数组中的坐标位置，记录提取数字在原表达式中的头尾坐标
    let numberArr: string[] = [value];
    let valIndex: number = 0;
    let startIndex: number = 0;
    let endIndex: number = 0;
    for (let i = trueIndex - 1; i >= 0; i--) {
      if (DisplayUtil.isNumberOrPoint(globalExp[i])) {
        numberArr.unshift(globalExp[i]);
        valIndex++;
      } else {
        // 前面提取的元素不是数字之后，保存数字的前端坐标
        startIndex = i + 1;
        break;
      }
    }
    // 如果光标后是数字，则加入到list里
    for (let j = trueIndex; j < globalExp.length + 1; j++) {
      if (DisplayUtil.isNumberOrPoint(globalExp[j])) {
        numberArr.push(globalExp[j]);
      } else {
        // 后面提取的元素不是数字之后，保存数字的后端坐标
        endIndex = j;
        break;
      }
    }
    // 粘贴插入位置及附近数字小数点判断及转换
    let splitNumber: string = CommonUtil.splitNumber(numberArr, valIndex);
    // 将表达式拼接起来，数字前的表达式+粘贴内容与前面的数字+粘贴内容后面的数字+数字后面的表达式
    let newEXPString = globalExp.slice(0, startIndex) + splitNumber + globalExp.slice(endIndex);
    newEXPString = newEXPString.replace('--', '-').replace('+-', '-');
    // 设置光标位置：表达式总长-插入位置后面的表达式的长度
    let finalTextInputIndex = CommonUtil.expIndexToDisplayIndex(newEXPString, newEXPString.length - finalIndex);
    // 更新表达式和光标位置
    AppStorage.set<string>('globalExpression',newEXPString);
    CommonUtil.updateTextInputOffset(finalTextInputIndex);
    return finalTextInputIndex;
  }

  /**
   * getTrueIndex
   *
   * 如果是在特殊表达式中间需要插入到（后面
   */
  public static getTrueIndex(index:number,displayExpression:string): number {
    let trueIndex: number = index;
    if (displayExpression!== '' && displayExpression !== null && trueIndex > 0) {
      if (['a', 'c', 'o', 'n', 'l', 's', 'g', 't', 'i', '\u207B',
        '\u00B9'].includes(displayExpression[trueIndex - 1])) {
        trueIndex = CommonUtil.getSpecialIndex(trueIndex, displayExpression);
      }
    }
    return trueIndex;
  }

}