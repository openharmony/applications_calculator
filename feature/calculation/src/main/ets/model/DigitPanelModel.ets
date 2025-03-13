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

import { SimplePhysicsButtonInfo } from '../info/PhysicsButtonInfo';
import { AccessibilityInfo } from '../info/AccessibilityInfo';
import { PhysicsButtonInfo } from '../info/PhysicsButtonInfo';
import { KeyCode } from '../calculator/KeyCode';

/**
 * Digit panel data resources
 *
 * @since 2023-03-20
 */
export default class DigitPanelModel {
  private static instance: DigitPanelModel;
  private standList: Array<Array<PhysicsButtonInfo>> = [];
  private scienceList: Array<Array<PhysicsButtonInfo>> = [];

  /**
   * constructor
   */
  private constructor() {
    this.init();
  }

  /**
   * getInstance
   *
   * @return DigitPanelModel
   */
  public static getInstance(): DigitPanelModel {
    if (DigitPanelModel.instance == null) {
      DigitPanelModel.instance = new DigitPanelModel();
    }
    return DigitPanelModel.instance;
  }


  private init(): void {
    this.initStandDigitPanelListInfo();
    this.initScienceDigitPanelListInfo();
  }

  /**
   * initStandDigitPanelListInfo
   */
  private initStandDigitPanelListInfo(): void {
    let pList: SimplePhysicsButtonInfo[][] = this.getStandardPanelList();
    this.standList = pList.map(rowItem => {
      return rowItem.map(colItem => {
        let pButton: PhysicsButtonInfo = new PhysicsButtonInfo();
        pButton.keyCode = colItem.keyCode;
        pButton.keyText = colItem.keyText;
        pButton.hasImageResource = ((typeof colItem.keyText) === 'object')
        pButton.accessibilityInfo = colItem.accessibilityInfo;
        if (colItem.keyCode === KeyCode.KEYCODE_EQUALS) {
          pButton.buttonType = ButtonType.Normal;
          pButton.normalBackgroundColor = $r('sys.color.icon_emphasize');
          pButton.pressedBackgroundColor = $r('sys.color.ohos_fa_click_effect');
          pButton.normalShadowBgColor = $r('app.color.btn_eq_normal_shadow_background_color');
          pButton.pressedBorderColor = $r('app.color.btn_eq_pressed_border_color');
          pButton.pressedColorBlend = $r('app.color.btn_eq_pressed_color_blend');
          pButton.normalBorderWidth = 0;
          pButton.pressedBorderWidth = 0;
        }
        return pButton;
      });
    });
  }


  /**
   * getStandLists
   *
   * @return Array<Array<PhysicsButtonInfo>>
   */
  getStandLists(): Array<Array<PhysicsButtonInfo>> {
    return this.standList;
  }

  /**
   * getStandardPanelList
   *
   * @return Array<Array<SimplePhysicsButtonInfo>>
   */
  getStandardPanelList(): Array<Array<SimplePhysicsButtonInfo>> {
    let arr: SimplePhysicsButtonInfo[][] =
      [
        [
          { keyCode: KeyCode.KEYCODE_MEM_CLEAR, keyText: 'MC', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_MEM_CLEAR) },
          { keyCode: KeyCode.KEYCODE_MEM_ADD, keyText: 'M+', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_MEM_ADD) },
          { keyCode: KeyCode.KEYCODE_MEM_SUBTRACT, keyText: 'M-', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_MEM_SUBTRACT) },
          { keyCode: KeyCode.KEYCODE_MEM_RECOVERY, keyText: 'MR', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_MEM_RECOVERY) },
        ],
        [
          { keyCode: KeyCode.KEYCODE_CLEAR, keyText: $r('app.media.ic_clear_pc'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_CLEAR) },
          { keyCode: KeyCode.KEYCODE_DIVIDE, keyText: $r('app.media.ic_devide_pc'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_DIVIDE) },
          { keyCode: KeyCode.KEYCODE_MULTIPLY, keyText: $r('app.media.ic_multiply_pc'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_MULTIPLY) },
          { keyCode: KeyCode.KEYCODE_BACK, keyText: $r('app.media.ic_delete_pc'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_BACK) },
        ],
        [
          { keyCode: KeyCode.KEYCODE_7, keyText: '7', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_7) },
          { keyCode: KeyCode.KEYCODE_8, keyText: '8', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_8) },
          { keyCode: KeyCode.KEYCODE_9, keyText: '9', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_9)},
          { keyCode: KeyCode.KEYCODE_SUBTRACT, keyText: $r('app.media.ic_minus_pc'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_SUBTRACT) },
        ],
        [
          { keyCode: KeyCode.KEYCODE_4, keyText: '4', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_4) },
          { keyCode: KeyCode.KEYCODE_5, keyText: '5', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_5) },
          { keyCode: KeyCode.KEYCODE_6, keyText: '6', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_6) },
          { keyCode: KeyCode.KEYCODE_ADD, keyText: $r('app.media.ic_plus_pc'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_ADD) },
        ],
        [
          { keyCode: KeyCode.KEYCODE_1, keyText: '1', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_1) },
          { keyCode: KeyCode.KEYCODE_2, keyText: '2', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_2) },
          { keyCode: KeyCode.KEYCODE_3, keyText: '3', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_3) },
          { keyCode: KeyCode.KEYCODE_EQUALS, keyText: $r('app.media.ic_equal_pc'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_EQUALS) },
        ],
        [
          { keyCode: KeyCode.KEYCODE_PERCENT, keyText: '%', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_PERCENT) },
          { keyCode: KeyCode.KEYCODE_0, keyText: '0', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_0) },
          { keyCode: KeyCode.KEYCODE_DOT, keyText: '.', accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_DOT) },
        ],
      ];
    return arr;
  }

  /**
   * init science calculator's digit panel info
   */
  private initScienceDigitPanelListInfo(): void {
    let pList: SimplePhysicsButtonInfo[][] = this.getSciencePanelList();
    this.scienceList = pList.map(rowItem => {
      return rowItem.map(colItem => {
        let pButton: PhysicsButtonInfo = new PhysicsButtonInfo();
        pButton.keyCode = colItem.keyCode;
        pButton.keyText = colItem.keyText;
        pButton.isInverse = colItem.isInverse;
        pButton.radOrDeg = colItem.radOrDeg;
        pButton.hasImageResource = ((typeof colItem.keyText) === 'object');
        pButton.accessibilityInfo = colItem.accessibilityInfo;
        return pButton;
      });
    });
  }

  /**
   * get science calculator button lists
   *
   * @return Array<Array<PhysicsButtonInfo>> ScienceLists
   */
  public getScienceLists(): Array<Array<PhysicsButtonInfo>> {
    return this.scienceList;
  }

  /**
   * get science calculator panel
   *
   * @return Array<Array<SimplePhysicsButtonInfo>> ScienceLists
   */
  public getSciencePanelList(): Array<Array<SimplePhysicsButtonInfo>> {
    let arr: SimplePhysicsButtonInfo[][] =
      [
        [
          { keyCode: KeyCode.KEYCODE_LEFT_PARENTHESES, keyText: $r('app.media.ic_left_parentheses'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_LEFT_PARENTHESES) },
          { keyCode: KeyCode.KEYCODE_RIGHT_PARENTHESES, keyText: $r('app.media.ic_right_parentheses'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_RIGHT_PARENTHESES) },
          { keyCode: KeyCode.KEYCODE_INVERSE_PROPORTIONAL, keyText: $r('app.media.ic_inverse_proportional'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_INVERSE_PROPORTIONAL) },
        ],
        [
          { keyCode: KeyCode.KEYCODE_SQUARED, keyText: $r('app.media.ic_squared'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_SQUARED) },
          { keyCode: KeyCode.KEYCODE_CUBE, keyText: $r('app.media.ic_cube'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_CUBE) },
          { keyCode: KeyCode.KEYCODE_POWER, keyText: $r('app.media.ic_power'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_POWER) },
        ],
        [
          { keyCode: KeyCode.KEYCODE_FACTORIAL, keyText: $r('app.media.ic_factorial'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_FACTORIAL) },
          { keyCode: KeyCode.KEYCODE_SQUARE_ROOTING, keyText: $r('app.media.ic_sqrt'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_SQUARE_ROOTING) },
          { keyCode: KeyCode.KEYCODE_CUBE_ROOTING, keyText: $r('app.media.ic_x_root_y'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_CUBE_ROOTING) },
        ],
        [
          { keyCode: KeyCode.KEYCODE_NATURAL_CONSTANT, keyText: $r('app.media.ic_natural_constant'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_NATURAL_CONSTANT) },
          { keyCode: KeyCode.KEYCODE_NATURAL_LOGARITHM, keyText: $r('app.media.ic_ln'), isInverse: false, accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_NATURAL_LOGARITHM) },
          { keyCode: KeyCode.KEYCODE_EXPONENTIAL_OF_E, keyText: $r('app.media.ic_exponential_of_e'), isInverse: true, accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_EXPONENTIAL_OF_E) },
          { keyCode: KeyCode.KEYCODE_LOGARITHM, keyText: $r('app.media.ic_log'), isInverse: false, accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_LOGARITHM) },
          { keyCode: KeyCode.KEYCODE_EXPONENTIAL_OF_TEN, keyText: $r('app.media.ic_exponential_of_ten'), isInverse: true, accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_EXPONENTIAL_OF_TEN) },
        ],
        [
          { keyCode: KeyCode.KEYCODE_SIN, keyText: $r('app.media.ic_sin'), isInverse: false, accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_SIN) },
          { keyCode: KeyCode.KEYCODE_ASIN, keyText: $r('app.media.ic_asin'), isInverse: true, accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_ASIN) },
          { keyCode: KeyCode.KEYCODE_COS, keyText: $r('app.media.ic_cos'), isInverse: false, accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_COS) },
          { keyCode: KeyCode.KEYCODE_ACOS, keyText: $r('app.media.ic_acos'), isInverse: true, accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_ACOS) },
          { keyCode: KeyCode.KEYCODE_TAN, keyText: $r('app.media.ic_tan'), isInverse: false, accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_TAN) },
          { keyCode: KeyCode.KEYCODE_ATAN, keyText: $r('app.media.ic_atan'), isInverse: true, accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_ATAN) },
        ],
        [
          { keyCode: KeyCode.KEYCODE_INVERSE_MATRIX, keyText: $r('app.media.ic_inverse_matrix'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_INVERSE_MATRIX) },
          { keyCode: KeyCode.KEYCODE_RAD, keyText:$r('app.media.ic_rad'), radOrDeg: true, accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_RAD) },
          { keyCode: KeyCode.KEYCODE_DEGREE, keyText:$r('app.media.ic_degree'), radOrDeg: false, accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_DEGREE) },
          { keyCode: KeyCode.KEYCODE_PIE, keyText: $r('app.media.ic_pie'), accessibilityInfo: new AccessibilityInfo(KeyCode.KEYCODE_PIE) },
        ],
      ];
    return arr;
  }
}