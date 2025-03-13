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

export const PANEL_BTN_SHADOW_RADIUS: number = 8;

export const PANEL_COLUMN_CNT: number = 4;

export const PANEL_ROW_CNT: number = 6;

export const BTN_EQUAL_GRADIENT_ANGLE: number = 180;

export const BTN_EQUAL_GRADIENT_START_COLOR: number = 0x45ffffff;

export const BTN_EQUAL_GRADIENT_END_COLOR: number = 0x14ffffff;

export const RADIUS_PADDING: number = 1;

export const FONT_FAMILY_DEFAULT: string = 'HarmonyHeiTi';

export const BTN_GRADIENT_START_COLOR: number = 0xF7F7F8;

export const BTN_GRADIENT_END_COLOR: number = 0xFDFDFD;

export const BTN_IMAGE_WIDTH: number = 50;

export const BTN_IMAGE_HEIGHT: number = 50;


const BUTTON_WIDTH: number = 70; // button width default value
const BUTTON_HEIGHT: number = 70; // button height default value
const BUTTON_TOP_GAP: number = 10; // default value of white space between row buttons
const BUTTON_RADIUS: number = 35; // default rounded corners for buttons
const BUTTON_SHADOW_RADIUS: number = 14; // button's shadow rounded default value
const BUTTON_ASPECT_RATIO: number = 1; // button aspect ratio default value

export class PanelSizeInfo {
  public btnWidth: number;
  public btnHeight: number;
  public topGap: number; // value of white space between row buttons
  public btnRadius: number;
  public btnShadowRadius: number;
  public aspectRatio: number;
  public leftGap?: number; // value of white space between column buttons
  public gridPadding?: Padding | null;
  public btnFontSize?: number | Resource | string;
  public btnFontSizeFirstLine?: number | Resource | string;
  public btnImageWidth?: number;
  public btnImageHeight?: number;
  public isScienceMode: boolean = false;

  constructor() {
    this.btnWidth = BUTTON_WIDTH;
    this.btnHeight = BUTTON_HEIGHT;
    this.topGap = BUTTON_TOP_GAP;
    this.btnRadius = BUTTON_RADIUS;
    this.btnShadowRadius = BUTTON_SHADOW_RADIUS;
    this.aspectRatio = BUTTON_ASPECT_RATIO;
  }
}