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

import { PhysicsButton } from '../views/PhysicsButton';
import { PhysicsButtonInfo } from '../info/PhysicsButtonInfo';
import { KeyCode } from './KeyCode';
import { PanelSizeInfo } from '../info/PanelSizeInfo';
import curves from '@ohos.curves';

import {
  CommonUtil
} from '@hmos/common';

/**
 * Digit Panel
 *
 * @since 2023-03-25
 */
@Component
export struct DigitPanel {
  private inputValue?: (result?: PhysicsButtonInfo) => void;
  @Link standList: Array<Array<PhysicsButtonInfo>>;
  @Link panelSizeInfo: PanelSizeInfo;
  @Consume('inverseFlag') inverseFlag: boolean;
  @Link radOrDegFlag: boolean;
  private columnsTemplate: string = '1fr 1fr 1fr 1fr';
  @Prop isScience: boolean = false;
  @Prop isFoldable: boolean = false;
  private positionOffsetZero: number | string = '0';
  private positionOffsetFull: number | string = '-100%';
  @State positionOffset_1: number | string = '-100%';
  @State positionOffset_2: number | string = '-100%';
  @State positionOffset_3: number | string = '-100%';


  private setOffset(index: number, subItem: PhysicsButtonInfo): number {
    if (this.columnsTemplate === '1fr 1fr 1fr') {
      switch (subItem.keyCode) {
        case KeyCode.KEYCODE_SIN:
        case KeyCode.KEYCODE_ASIN:
          return this.isScience ? 1000 : 0;
        case KeyCode.KEYCODE_NATURAL_LOGARITHM:
        case KeyCode.KEYCODE_EXPONENTIAL_OF_E:
        case KeyCode.KEYCODE_COS:
        case KeyCode.KEYCODE_ACOS:
        case KeyCode.KEYCODE_RAD:
        case KeyCode.KEYCODE_DEGREE:
          return 500;
        case KeyCode.KEYCODE_LOGARITHM:
        case KeyCode.KEYCODE_EXPONENTIAL_OF_TEN:
        case KeyCode.KEYCODE_TAN:
        case KeyCode.KEYCODE_ATAN:
        case KeyCode.KEYCODE_PIE:
          return this.isScience ? 0 : 1000;
      }
      switch (index) {
        case 0:
          return this.isScience ? 1000 : 0;
        case 1:
          return 500;
        case 2:
          return this.isScience ? 0 : 1000;
      }
    } else {
      return 0;
    }
    return 0;
  }

  private setTranslate(index: number, subItem: PhysicsButtonInfo): string | number | null {
    switch (subItem.keyCode) {
      case KeyCode.KEYCODE_SIN:
      case KeyCode.KEYCODE_ASIN:
        return this.positionOffset_1;
      case KeyCode.KEYCODE_NATURAL_LOGARITHM:
      case KeyCode.KEYCODE_EXPONENTIAL_OF_E:
      case KeyCode.KEYCODE_COS:
      case KeyCode.KEYCODE_ACOS:
      case KeyCode.KEYCODE_RAD:
      case KeyCode.KEYCODE_DEGREE:
        return this.positionOffset_2;
      case KeyCode.KEYCODE_LOGARITHM:
      case KeyCode.KEYCODE_EXPONENTIAL_OF_TEN:
      case KeyCode.KEYCODE_TAN:
      case KeyCode.KEYCODE_ATAN:
      case KeyCode.KEYCODE_PIE:
        return this.positionOffset_3;
    }
    if (this.columnsTemplate === '1fr 1fr 1fr') {
      switch (index) {
        case 0:
          return this.positionOffset_1;
        case 1:
          return this.positionOffset_2;
        case 2:
          return this.positionOffset_3;
      }
    }
    return 0;
  }

  private handleButtonShow(panelSizeInfo: PhysicsButtonInfo): boolean {
    let isInverse: boolean | undefined = panelSizeInfo.isInverse;
    let radOrDeg: boolean | undefined = panelSizeInfo.radOrDeg;
    if (isInverse === undefined && radOrDeg === undefined) {
      return true;
    }
    if (isInverse !== undefined && this.inverseFlag === isInverse) {
      return true;
    }
    if (radOrDeg !== undefined && this.radOrDegFlag === !radOrDeg) {
      return true;
    }
    return false;
  }

  build() {
    Grid() {
      ForEach(this.standList, (item: Array<PhysicsButtonInfo>, colIndex) => {
        ForEach(item, (subItem: PhysicsButtonInfo, index: number) => {
          if (this.handleButtonShow(subItem)) {
            GridItem() {
              PhysicsButton({
                physicsButtonInfo: subItem,
                inputValue: this.inputValue,
                index: colIndex,
                panelSizeInfo: this.panelSizeInfo,
                isScience: this.isScience,
                isFoldable: this.isFoldable,
                radOrDegFlag: this.radOrDegFlag,
              })
            }
            // .translate({ x: this.isScience ? 0 : this.setTranslate(index, subItem) })
            .animation(
              {
                duration: 1000,
                curve: curves.interpolatingSpring(0, 1, 280, 33),
                iterations: 1,
                delay: this.setOffset(index, subItem),
                playMode: PlayMode.Normal,
                onFinish: () => {
                }
              }
            )
            .rowStart(index)
            .rowEnd((subItem.keyCode === KeyCode.KEYCODE_EQUALS ? index + 1 : index))
            .width(this.panelSizeInfo.btnWidth)
            .height('100%')
          }
        })
      })
    }
    .backgroundColor($r('sys.color.ohos_id_color_panel_bg'))
    .columnsTemplate(this.columnsTemplate)
    .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr')
    .rowsGap(this.panelSizeInfo.topGap)
    .columnsGap(this.panelSizeInfo.leftGap)
    .padding(this.panelSizeInfo.gridPadding || $r('app.float.digit_panel_padding'))
    .width('100%')
    .height('100%')
    .id('id_digit_panel' + (this.isScience ? '_science' : ''))
  }
}