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
import resmgr from '@ohos.resourceManager';
import { GlobalContext, LogUtil, AccessibilityPlayUtil } from '@hmos/common';
import { KeyCode as CalcKeyCode } from '../calculator/KeyCode';

/**
 * 无障碍控件配置
 *
 * @since 2024-4-20
 */
const TAG: string = 'AccessibilityInfo';
export const ACCESSIBILITY_HISTORY_RECORD_PLAY: string = 'history_record';
export const ACCESSIBILITY_RECORD_IS_PLAY: string = 'record_empty';
export const ACCESSIBILITY_ERROR: string = 'error';
export const ACCESSIBILITY_DESC_INV_OFF: string = 'desc_inv_off'; //显示反函数
export const ACCESSIBILITY_DESC_INV_ON: string = 'desc_inv_on'; //隐藏反函数
export const ACCESSIBILITY_CLEAR_RECORD: string = 'clear_record';
export const ACCESSIBILITY_CLEARED: string = 'clear_record';
export const ACCESSIBILITY_DELETED: string = 'exactcalculator_accessibility_deleted';
export const ACCESSIBILITY_MORE_SELECT: string = '更多选项';
export const ACCESSIBILITY_NAVIGATE_UP: string = '向上导航';

export class AccessibilityInfo {
  private static accessibilityResourceMap = new Map([
    [ACCESSIBILITY_ERROR, $r('app.string.error')],
    [ACCESSIBILITY_HISTORY_RECORD_PLAY, $r('app.string.history_record')],
    [ACCESSIBILITY_RECORD_IS_PLAY, $r('app.string.record_empty')],
    [ACCESSIBILITY_CLEAR_RECORD, $r('app.string.clear_record')],
    [ACCESSIBILITY_DESC_INV_OFF, $r('app.string.desc_inv_off')],
    [ACCESSIBILITY_DESC_INV_ON, $r('app.string.desc_inv_on')],
    [ACCESSIBILITY_CLEARED, $r('app.string.cleared')],
    [ACCESSIBILITY_DELETED, $r('app.string.exactcalculator_accessibility_deleted')],
  ]);

  //按键的keycode值与按键点击时无障碍播报内容的MAP
  private static clickTextMap = new Map([
    [CalcKeyCode.KEYCODE_CLEAR, $r('app.string.cleared')], //C
  ])

  //按键的keycode值与按键聚焦时无障碍播报内容的MAP
  private static buttonTextMap = new Map([
    [CalcKeyCode.KEYCODE_DIVIDE, $r('app.string.desc_op_div')], //÷
    [CalcKeyCode.KEYCODE_MULTIPLY, $r('app.string.desc_op_mul')], //×
    [CalcKeyCode.KEYCODE_SUBTRACT, $r('app.string.desc_op_sub')], //-
    [CalcKeyCode.KEYCODE_ADD, $r('app.string.desc_op_add')], //+
    [CalcKeyCode.KEYCODE_DOT, $r('app.string.desc_dec_point')], //.
    [CalcKeyCode.KEYCODE_PERCENT, $r('app.string.desc_op_pct')], //%
    [CalcKeyCode.KEYCODE_EQUALS, $r('app.string.desc_eq')], //=
    [CalcKeyCode.KEYCODE_MEM_CLEAR, $r('app.string.memoryClearDesc')], //MC
    [CalcKeyCode.KEYCODE_MEM_ADD, $r('app.string.memoryPlusDesc')], //M+
    [CalcKeyCode.KEYCODE_MEM_SUBTRACT, $r('app.string.memoryMinusDesc')], //M-
    [CalcKeyCode.KEYCODE_MEM_RECOVERY, $r('app.string.memoryRecallDesc')], //MR
    [CalcKeyCode.KEYCODE_BACK, $r('app.string.delete')],
    [CalcKeyCode.KEYCODE_CLEAR, $r('app.string.desc_clr')], //C
    [CalcKeyCode.KEYCODE_LEFT_PARENTHESES, $r('app.string.desc_lparen')], //(
    [CalcKeyCode.KEYCODE_RIGHT_PARENTHESES, $r('app.string.desc_rparen')], //)
    [CalcKeyCode.KEYCODE_SQUARED, $r('app.string.desc_op_sqr')], //^2
    [CalcKeyCode.KEYCODE_CUBE, $r('app.string.desc_op_cube')], //^3
    [CalcKeyCode.KEYCODE_INVERSE_PROPORTIONAL, $r('app.string.desc_op_reciprocal')], //1/x
    [CalcKeyCode.KEYCODE_POWER, $r('app.string.desc_op_pow')], // x^y
    [CalcKeyCode.KEYCODE_FACTORIAL, $r('app.string.desc_op_fact')], //x!
    [CalcKeyCode.KEYCODE_NATURAL_CONSTANT, $r('app.string.desc_const_e')], //e
    [CalcKeyCode.KEYCODE_LOGARITHM, $r('app.string.desc_fun_log')], //log
    [CalcKeyCode.KEYCODE_SIN, $r('app.string.desc_fun_sin')], //sin
    [CalcKeyCode.KEYCODE_COS, $r('app.string.desc_fun_cos')], //cos
    [CalcKeyCode.KEYCODE_TAN, $r('app.string.desc_fun_tan')], //tan
    [CalcKeyCode.KEYCODE_ASIN, $r('app.string.desc_fun_arcsin')], //sin-1
    [CalcKeyCode.KEYCODE_ACOS, $r('app.string.desc_fun_arccos')], //cos-1
    [CalcKeyCode.KEYCODE_ATAN, $r('app.string.desc_fun_arctan')], //tan-1
    [CalcKeyCode.KEYCODE_EXPONENTIAL_OF_E, $r('app.string.desc_fun_exp')], //e^x
    [CalcKeyCode.KEYCODE_EXPONENTIAL_OF_TEN, $r('app.string.desc_fun_10pow')], //10^x
    [CalcKeyCode.KEYCODE_RAD, $r('app.string.desc_switch_rad')], //rad切换成弧度
    [CalcKeyCode.KEYCODE_DEGREE, $r('app.string.desc_switch_deg')], //deg切换成角度
    [CalcKeyCode.KEYCODE_PIE, $r('app.string.desc_const_pi')], //π
    [CalcKeyCode.KEYCODE_INVERSE_MATRIX, $r('app.string.delete')], //Inv
    [CalcKeyCode.KEYCODE_NATURAL_LOGARITHM, $r('app.string.desc_fun_ln')], //ln
    [CalcKeyCode.KEYCODE_SQUARE_ROOTING, $r('app.string.desc_op_sqrt')], //根号
    [CalcKeyCode.KEYCODE_CUBE_ROOTING, $r('app.string.desc_x_root_y')], //y根号
  ])

  public keyCode?:CalcKeyCode = -1;

  constructor(keyCode?:CalcKeyCode) {
    if (keyCode !== null && keyCode !== undefined) {
      this.keyCode = keyCode;
    }
  }

  /**
   * 将Resource转换为字符串
   *
   * @param { Resource } 资源.
   * @return { string } 转换后的字符串.
   */
 public static getStrByResource(resource: Resource): string {
   let playStr: string = '';
   let context = GlobalContext.getContext().getObject('resourceManager') as resmgr.ResourceManager;
   if (context !== undefined) {
     try {
       playStr = context.getStringSync(resource.id);
       return playStr;
     } catch (error) {
       LogUtil.error(TAG, 'getButtonInfo getString error');
     }
   }
   return '';
 }

  /**
   * 获取点击是的无障碍播报内容，优先通过clickTextMap获取，如果没有则通过getButtonInfo 获取
   *
   * @param { string } 默认需要播报的字符.
   * @return { string } 转换后的无障碍字符串.
   */
  public getClickInfo(info?: string): string {
    let playStr: string = '';
    let playText: Resource | undefined = AccessibilityInfo.clickTextMap.get(this.keyCode as CalcKeyCode);
    if (playText !== null && playText !== undefined) {
      playStr = AccessibilityInfo.getStrByResource(playText);
    } else {
      playStr = this.getButtonInfo(info);
    }
    return playStr;
  }

  /**
   * 获取获取聚焦内容，优先通过先通过keyCode获取，如果没有则通过info 获取
   *
   * @param { string } 默认需要播报的字符.
   * @param { Boolean } 是否是反函数模式.
   * @return { string } 转换后的无障碍字符串.
   */
  public getButtonInfo(info?: string, isInv?: Boolean): string {
    let playStr: string = '';
    if (this.keyCode !== null && this.keyCode !== undefined) {
      switch (this.keyCode) {
        case CalcKeyCode.KEYCODE_INVERSE_MATRIX:
          let playInfo = isInv ? ACCESSIBILITY_DESC_INV_ON : ACCESSIBILITY_DESC_INV_OFF;
          return AccessibilityInfo.getPlayInfoByResource(playInfo);
        case CalcKeyCode.KEYCODE_1:
        case CalcKeyCode.KEYCODE_2:
        case CalcKeyCode.KEYCODE_3:
        case CalcKeyCode.KEYCODE_4:
        case CalcKeyCode.KEYCODE_5:
        case CalcKeyCode.KEYCODE_6:
        case CalcKeyCode.KEYCODE_7:
        case CalcKeyCode.KEYCODE_8:
        case CalcKeyCode.KEYCODE_9:
        case CalcKeyCode.KEYCODE_0:
          return String(this.keyCode);
        default:
          let playText: Resource | undefined = AccessibilityInfo.buttonTextMap.get(this.keyCode);
          if (playText !== null && playText !== undefined) {
            playStr = AccessibilityInfo.getStrByResource(playText);
            // LogUtil.debug(TAG, 'getButtonInfo getStrByResource:', String(this.keyCode), playStr);
          } else {
            playStr = (info !== null && info !== undefined) ? info : playStr;
            // LogUtil.debug(TAG, 'getButtonInfo playStr:', playStr);
          }
          break;
      }
    }
    return playStr;
  }

  /**
   * 通过accessibilityResourceMap的字符串key值获取资源
   *
   * @param { string } accessibilityResourceMap的字符串key值.
   */
   public static getPlayInfoByResource(info: string | undefined): string {
    let playStr: string = '';
    if (info !== null && info !== undefined) {
      let playText: Resource | undefined = AccessibilityInfo.accessibilityResourceMap.get(info);
      if (playText !== null && playText !== undefined) {
        playStr = AccessibilityInfo.getStrByResource(playText);
      }
    }
    return playStr;
  }

  /**
   * 通过accessibilityResourceMap主动播报
   *
   * @param { string } accessibilityResourceMap的字符串key值.
   */
  public static playAccessibilityByStr(info: string): void {
    let playStr = AccessibilityInfo.getPlayInfoByResource(info);
    LogUtil.info(TAG, 'playAccessibilityByStr', playStr)
    AccessibilityPlayUtil.announceForAccessibility(playStr);
  }

  /**
   * 主动播报通过keycode
   *
   * @param { string } 默认需要播报的字符.
   */
  public playAccessibilityInfo(info?: string): void {
    LogUtil.info(TAG, 'playAccessibilityInfo', String(this.keyCode))
    switch (this.keyCode) {
      case CalcKeyCode.KEYCODE_EQUALS:
      case CalcKeyCode.KEYCODE_BACK:
      case CalcKeyCode.KEYCODE_INVERSE_MATRIX:
        break;
      default:
        LogUtil.info(TAG, 'accessibility play', this.getClickInfo(info));
        AccessibilityPlayUtil.announceForAccessibility(this.getClickInfo(info));
        break;
    }
  }
}