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

import { KeyCode } from '@ohos.multimodalInput.keyCode';
import { LogUtil, InputUtil, CommonUtil } from '@hmos/common';
import { PhysicsButtonInfo } from '../info/PhysicsButtonInfo';
import {
  AccessibilityInfo,
  ACCESSIBILITY_DESC_INV_ON,
  ACCESSIBILITY_DESC_INV_OFF
} from '../info/AccessibilityInfo';
import { KeyCode as CalcKeyCode } from '../calculator/KeyCode';
import {
  PanelSizeInfo,
  BTN_EQUAL_GRADIENT_ANGLE,
  BTN_EQUAL_GRADIENT_END_COLOR,
  BTN_EQUAL_GRADIENT_START_COLOR,
  FONT_FAMILY_DEFAULT,
} from '../info/PanelSizeInfo';

const TAG: string = 'DigitPanel';

/**
 * Physics Button
 *
 * @since 2023-03-20
 */
@Component
export struct PhysicsButton {
  @State isPressed: boolean = false;
  @State isClicked: boolean = false;
  @State isHovered: boolean = false;
  @Link panelSizeInfo: PanelSizeInfo;
  private physicsButtonInfo: PhysicsButtonInfo = new PhysicsButtonInfo();
  private inputValue?: (value?: PhysicsButtonInfo, keyValue?: string) => void;
  private index: number = 0;
  private isShiftPressed: boolean = false;
  @Consume('inverseFlag') inverseFlag: boolean;
  @Link radOrDegFlag: boolean;
  @Consume('invalidFlag') isInvalid: boolean;
  private imageColor: Resource = $r('app.color.btn_equal_txt_fill_color');
  private isEqualKey: boolean = false;
  @Prop isScience: boolean;
  @Prop isFoldable: boolean;

  @Styles
  normalButtonStyle() {
    .border({
      width: this.physicsButtonInfo.normalBorderWidth,
      color: this.physicsButtonInfo.normalBorderColor,
      style: BorderStyle.Solid,
      radius: this.panelSizeInfo.btnRadius,
    })
    .shadow({
      radius: this.panelSizeInfo.btnShadowRadius,
      color: this.physicsButtonInfo.normalShadowBgColor,
      offsetX: this.physicsButtonInfo.normalShadowOffsetX,
      offsetY: this.physicsButtonInfo.normalShadowOffsetY,
    })
  }

  @Styles
  pressedButtonStyle() {
    .border({
      width: this.physicsButtonInfo.pressedBorderWidth,
      color: this.physicsButtonInfo.pressedBorderColor,
      style: BorderStyle.Solid,
      radius: this.panelSizeInfo.btnRadius,
    })
    .shadow({
      radius: this.panelSizeInfo.btnShadowRadius,
      color: this.physicsButtonInfo.pressedShadowBgColor,
      offsetX: this.physicsButtonInfo.pressedShadowOffsetX,
      offsetY: this.physicsButtonInfo.pressedShadowOffsetY,
    })
  }

  aboutToAppear(): void {
    if (this.physicsButtonInfo.keyCode === CalcKeyCode.KEYCODE_EQUALS) {
      this.isEqualKey = true;
      this.imageColor = $r('app.color.btn_equal_txt_fill_color');
    } else if (this.physicsButtonInfo.keyCode > CalcKeyCode.KEYCODE_MEM_RECOVERY) {
      this.imageColor = $r('sys.color.icon_secondary');
    } else {
      this.imageColor = $r('sys.color.icon_emphasize');
    }
  }

  /**
   * Handle keyboard event.
   * When the focus is not in the text box, the key input is displayed in the text box.
   *
   * @param event data of KeyEvent
   */
  private handleKeyEvent(event?: KeyEvent): void {
    if (event === null || event === undefined) {
      return;
    }
    if (event.keyCode === KeyCode.KEYCODE_SHIFT_LEFT || event.keyCode === KeyCode.KEYCODE_SHIFT_RIGHT) {
      this.isShiftPressed = event.type === KeyType.Down;
    }
    if (event.type === KeyType.Down) {
      let character: string = InputUtil.keyForString(event.keyCode, this.isShiftPressed);
      if (character !== null && this.inputValue !== undefined && this.inputValue !== null) {
        this.inputValue(undefined, character);
        LogUtil.info(TAG, `handleKeyEvent: inputValue's character is ${character}.`);
      }
    }
  }

  /**
   * check Science Button, check status of inverse, deg and rad
   *
   * @param number keycode
   */
  private checkScienceButton(keyCode: number): void {
    switch (keyCode) {
      case CalcKeyCode.KEYCODE_INVERSE_MATRIX:
        if (this.inverseFlag) {
          AccessibilityInfo.playAccessibilityByStr(ACCESSIBILITY_DESC_INV_ON);
        } else {
          AccessibilityInfo.playAccessibilityByStr(ACCESSIBILITY_DESC_INV_OFF);
        }
        this.inverseFlag = !this.inverseFlag;
        break;
      case CalcKeyCode.KEYCODE_DEGREE:
      case CalcKeyCode.KEYCODE_RAD:
        this.radOrDegFlag = !this.radOrDegFlag;
        break;
      default:
        break;
    }
  }

  @Builder
  NormalEqualKeyBuilder() {
    Column() {
      this.ItemBuilder()
    }
    .width(this.panelSizeInfo.btnWidth)
    .height('100%')
    .padding(1)
    .borderRadius(this.panelSizeInfo.btnRadius)
    .stateStyles({ normal: this.normalButtonStyle })
    .backgroundColor($r('sys.color.interactive_focus'))
    .linearGradient({
      angle: BTN_EQUAL_GRADIENT_ANGLE,
      colors: [[BTN_EQUAL_GRADIENT_START_COLOR, 0.0], [BTN_EQUAL_GRADIENT_END_COLOR, 1.0]],
    })
  }

  @Builder
  NormalKeyBuilder() {
    Column() {
      this.ItemBuilder()
    }
    .width(this.panelSizeInfo.btnWidth)
    .height('100%')
    .linearGradient({
      colors: [[$r('app.color.panel_btn_background_start'), 0.0], [$r('app.color.panel_btn_background_end'), 1.0]],
    })
    .stateStyles({
      normal: this.normalButtonStyle
    })
  }

  @Builder
  ImageComponentBuilder() {
    Image(this.physicsButtonInfo?.keyText || '')
      .width(CommonUtil.setSplitFontSize(this.panelSizeInfo.btnImageWidth))
      .height(CommonUtil.setSplitFontSize(this.panelSizeInfo.btnImageHeight))
      .objectFit(ImageFit.Contain)
      .fillColor(this.imageColor)
      .draggable(false)
      .focusable(true)
      .tabIndex(1)
  }

  @Builder
  TextComponentBuilder() {
    Text(this.physicsButtonInfo?.keyText || '')
      .textAlign(TextAlign.Center)
      .fontSize(CommonUtil.setSplitFontSize(
        this.physicsButtonInfo.keyCode > CalcKeyCode.KEYCODE_PERCENT ?
        this.panelSizeInfo.btnFontSizeFirstLine : this.panelSizeInfo.btnFontSize))
      .fontWeight(
        (this.panelSizeInfo.isScienceMode || this.index === 0) ? FontWeight.Regular : FontWeight.Medium)
      .fontColor(
        this.physicsButtonInfo.keyCode <= CalcKeyCode.KEYCODE_DOT ?
        $r('sys.color.font_primary') : $r('sys.color.font_secondary'))
      .fontFamily(FONT_FAMILY_DEFAULT)
      .focusable(true)
      .tabIndex(1)
  }

  @Builder
  ItemBuilder() {
    Button({ type: this.physicsButtonInfo.buttonType, stateEffect: true }) {
      if (this.physicsButtonInfo.hasImageResource) {
        this.ImageComponentBuilder()
      } else {
        this.TextComponentBuilder()
      }
    }
    .id('keyCode_' + this.physicsButtonInfo.keyCode)
    .width('100%')
    .height('100%')
    .align(Alignment.Center)
    .borderRadius(this.panelSizeInfo.btnRadius)
    .backgroundColor(
      this.isEqualKey ? $r('sys.color.interactive_focus') : $r('app.color.transparent'))
    .gesture(
      LongPressGesture()
        .onAction((event: GestureEvent) => {
          if (this.inputValue) {
            if (this.physicsButtonInfo.keyCode === CalcKeyCode.KEYCODE_BACK) {
              let clearPhysicsButtonInfo: PhysicsButtonInfo = new PhysicsButtonInfo();
              clearPhysicsButtonInfo.keyCode = CalcKeyCode.KEYCODE_CLEAR;
              clearPhysicsButtonInfo.keyText = $r('app.media.ic_clear_pc');
              this.inputValue(clearPhysicsButtonInfo);
            } else {
              this.inputValue(this.physicsButtonInfo);
            }
          }
        })
    )
    .accessibilityText(
      this.physicsButtonInfo.accessibilityInfo?.getButtonInfo(
        this.physicsButtonInfo.keyText as string, this.inverseFlag
      ))
    .onClick(() => {
      this.isInvalid = false;
      if (this.inputValue !== undefined && this.inputValue !== null) {
        LogUtil.info(TAG, 'onClick');
        this.physicsButtonInfo.accessibilityInfo?.playAccessibilityInfo(this.physicsButtonInfo.keyText as string);
        this.inputValue(this.physicsButtonInfo);
        LogUtil.info(TAG, `onClick: inputValue's keyCode is ${this.physicsButtonInfo.keyCode}.`);
      }
      this.checkScienceButton(this.physicsButtonInfo.keyCode)
    })
    .onKeyEvent((event?: KeyEvent) => {
      this.handleKeyEvent(event);
    })
  }

  build() {
    Column() {
      if (this.isEqualKey) {
        this.NormalEqualKeyBuilder()
      } else {
        this.NormalKeyBuilder()
      }
    }
  }
}