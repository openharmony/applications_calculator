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
import { AccessibilityInfo } from '..';
import { KeyCode } from '../calculator/KeyCode';

/**
 * Physics button info
 *
 * @since 2023-03-20
 */

@Observed
export class SimplePhysicsButtonInfo {
  public keyCode: number = 0;
  public keyText: string | Resource = '';
  public isInverse?: boolean | undefined;
  public radOrDeg?: boolean | undefined;
  public accessibilityInfo?: AccessibilityInfo = new AccessibilityInfo();
}

@Observed
export class PhysicsButtonInfo extends SimplePhysicsButtonInfo {
  // buttonType
  public buttonType: ButtonType;

  // background
  public normalBackgroundColor: number | Resource;
  public pressedBackgroundColor: number | Resource;
  public pressedColorBlend: number | Resource;
  public onHoveredColorBlend: number | Resource;

  // shadow
  public normalShadowBgColor: number | Resource;
  public normalShadowRadius: number;
  public normalShadowOffsetX: number | Resource;
  public normalShadowOffsetY: number | Resource;
  public pressedShadowBgColor: number | Resource;
  public pressedShadowRadius: number;
  public pressedShadowOffsetX: number | Resource;
  public pressedShadowOffsetY: number | Resource;

  // border
  public normalBorderWidth: number;
  public pressedBorderWidth: number;
  public normalBorderColor: number | Resource;
  public pressedBorderColor: number | Resource;
  public normalBorderRadius: number;
  public pressedBorderRadius: number;
  public width: number | Resource;
  public height: number | Resource;
  public fontSize: number | Resource;
  public fontColor: number | Resource;
  public hasImageResource: boolean;

  constructor() {
    super();

    // buttonType
    this.buttonType = ButtonType.Capsule;

    // background
    this.normalBackgroundColor = $r('app.color.color_button_bg');
    this.pressedBackgroundColor = $r('sys.color.ohos_fa_click_effect');
    this.pressedColorBlend = $r('app.color.btn_pressed_color_blend');
    this.onHoveredColorBlend = $r('app.color.btn_hovered_color_blend');

    // shadow
    this.normalShadowBgColor = $r('app.color.color_shadow_bg');
    this.normalShadowRadius = 0;
    this.normalShadowOffsetX = 0;
    this.normalShadowOffsetY = $r('app.float.btn_normal_shadow_offset_y');

    this.pressedShadowBgColor = $r('app.color.btn_pressed_shadow_background_color');
    this.pressedShadowRadius = 0;
    this.pressedShadowOffsetX = 0;
    this.pressedShadowOffsetY = $r('app.float.btn_normal_shadow_offset_y');

    // border
    this.normalBorderWidth = 1;
    this.pressedBorderWidth = 1;
    this.normalBorderColor = $r('app.color.color_border');
    this.pressedBorderColor = $r('app.color.btn_pressed_border_color');
    this.normalBorderRadius = 0;
    this.pressedBorderRadius = 0;

    this.width = $r('app.float.btn_default_size');
    this.height = $r('app.float.btn_default_size');
    this.fontSize = $r('app.float.digit_btn_txt_font_size');
    this.fontColor = Color.Black;
    this.hasImageResource = false;
  }
}