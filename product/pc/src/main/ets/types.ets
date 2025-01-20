/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

export class PageConstants {
  public static readonly KEY_HAS_NAVIGATION: string = 'key_has_navigation';
  public static readonly KEY_DISPLAY_WIDTH: string = 'key_display_width';
  public static readonly PANEL_HEIGHT_NORMAL: number = 509;
  public static readonly PANEL_HEIGHT_PHONE: number = 520;
  public static readonly PANEL_PHONE_TOP_PADDING: number = 20;
  public static readonly PANEL_PHONE_BOTTOM_PADDING: number = 20;
  public static readonly PANEL_PHONE_LEFT_PADDING: number = 20;
  public static readonly PANEL_PHONE_RIGHT_PADDING: number = 20;
  public static readonly PANEL_PHONE_BTN_WIDTH: number = 70;
  public static readonly PANEL_PHONE_BTN_HEIGHT: number = 70;
  public static readonly PANEL_ROWS_GAP: number = 12;
  public static readonly DEFAULT_SIZE: number = 0;
  public static readonly PANEL_PHONE_COLUMN_CNT: number = 4;
  public static readonly PANEL_PHONE_COLUMN_GAP_CNT: number = 3;
  public static readonly PHONE_DEFAULT_WIDTH: number = 360;
  public static readonly PANEL_GRADIENT_START_COLOR: number = 0xF5F7F9;
  public static readonly PANEL_GRADIENT_END_COLOR: number = 0xF1F3F5;
  public static readonly FONT_FAMILY_DEFAULT: string = 'HarmonyHeiTi';
  public static readonly PANEL_GRADIENT_END_COLOR_STRING: string = '#F1F3F5';
  public static readonly TWO_SIZE: number = 2;
  public static readonly FOLD_BUTTON_WIDTH_RATE: number = 2;
  public static readonly PANEL_TABLET_BTN_HEIGHT: number = 70;
  public static readonly PANEL_TABLET_PORTRAIT_HEIGHT: number = 848;
  public static readonly PANEL_TABLET_PORTRAIT_BTN_HEIGHT: number = 118;
  public static readonly PANEL_TABLET_PORTRAIT_BTN_WIDTH: number = 154;
  public static readonly PANEL_TABLET_PORTRAIT_TOP_PADDING: number = 20;
  public static readonly PANEL_TABLET_PORTRAIT_LEFT_PADDING: number = 48;
  public static readonly PANEL_TABLET_PORTRAIT_BOTTOM_PADDING: number = 20;
  public static readonly PANEL_TABLET_PORTRAIT_RIGHT_PADDING: number = 48;
  public static readonly PANEL_TABLET_PORTRAIT_ROW_GAP: number = 20;
  public static readonly PANEL_TABLET_PORTRAIT_BTN_FONT_SIZE: number = 50;
  public static readonly PANEL_TABLET_PORTRAIT_BTN_FONT_SIZE_FIRST_LINE: number = 38;
  public static readonly OPERATION_VIEW_TABLET_PORTRAIT_FORMULA_FONT_SIZE: number = 70;
  public static readonly OPERATION_VIEW_TABLET_PORTRAIT_RESULT_FONT_SIZE: number = 44;
  public static readonly OPERATION_VIEW_TABLET_PORTRAIT_FORMULA_VIEW_HEIGHT: number = 93;
  public static readonly OPERATION_VIEW_TABLET_PORTRAIT_RESULT_VIEW_HEIGHT: number = 47;
  public static readonly OPERATION_VIEW_TABLET_PORTRAIT_VIEW_HEIGHT: number = 140;
  public static readonly OPERATION_VIEW_PHONE_VIEW_HEIGHT: number = 128;
  public static readonly MEDIA_QUERY_ORIENTATION_LANDSCAPES: string = '(orientation: landscape)';
  public static readonly MEDIA_QUERY_ORIENTATION_PORTRAIT: string = '(orientation: portrait)';
  public static readonly PHONE_PANEL_PADDING = 16;
  public static readonly PHONE_BUTTON_ROW = 6;
  public static readonly PHONE_GAP_ROW = 5;
  public static readonly PHONE_BUTTON_HEIGHT_RATE = 0.8;
  public static readonly TABLET_BUTTON_WIDTH_RATE = 3.5;
  public static readonly PANEL_PHONE_EXPAND_BTN_FONT_SIZE: number = 38;
  public static readonly PANEL_PHONE_EXPAND_BTN_FONT_SIZE_FIRST_LINE: number = 30;
  public static readonly PANEL_TABLET_PORTRAIT_BTN_IMAGE_WIDTH: number = 80;
  public static readonly PANEL_TABLET_PORTRAIT_BTN_IMAGE_HEIGHT: number = 80;
  public static readonly PANEL_BTN_WIDTH_PERCENT_BASE: number = 0.2;
  public static readonly PANEL_BTN_HEIGHT_PERCENT_BASE: number = 0.1;
  public static readonly PANEL_BTN_HEIGHT_PERCENT_LG: number = 0.09;
  public static readonly PANEL_BTN_FONT_SIZE_SM: number = 32;
  public static readonly PANEL_BTN_FONT_SIZE_FIRST_LINE_SM: number = 22;
  public static readonly PANEL_BTN_IMG_WIDTH_SM: number = 50;
  public static readonly PANEL_BTN_IMG_HEIGHT_SM: number = 50;
  public static readonly PANEL_BTN_FONT_SIZE_MD: number = 38;
  public static readonly PANEL_BTN_FONT_SIZE_FIRST_LINE_MD: number = 32;
  public static readonly PANEL_BTN_IMG_WIDTH_MD: number = 50;
  public static readonly PANEL_BTN_IMG_HEIGHT_MD: number = 50;
  public static readonly PANEL_BTN_FONT_SIZE_MD_TABLET: number = 60;
  public static readonly PANEL_BTN_FONT_SIZE_FIRST_LINE_MD_TABLET: number = 44;
  public static readonly PANEL_BTN_IMG_WIDTH_MD_TABLET: number = 70;
  public static readonly PANEL_BTN_IMG_HEIGHT_MD_TABLET: number = 70;
  public static readonly PANEL_BTN_FONT_SIZE_LG: number = 38;
  public static readonly PANEL_BTN_FONT_SIZE_FIRST_LINE_LG: number = 30;
  public static readonly PANEL_BTN_IMG_WIDTH_LG: number = 50;
  public static readonly PANEL_BTN_IMG_HEIGHT_LG: number = 50;
  public static readonly PANEL_PADDING_PAD: number = 32;
  public static readonly PANEL_PADDING_BASE: number = 16;
  public static readonly TOP_AREA_HEIGHT_HEIGHT_PERCENT_MD_TABLET: number = 0.25;
  public static readonly TOP_AREA_HEIGHT_HEIGHT_PERCENT_BASE: number = 0.28;
  public static readonly PANEL_COLUMN_CNT: number = 4;
  public static readonly PANEL_COLUMN_GAP_CNT: number = 3;
  public static readonly PANEL_ROW_CNT: number = 6;
  public static readonly PANEL_ROW_GAP_CNT: number = 5;
  public static readonly PANEL_BTN_WHOLE_AREA_STANDARD: Length = '100%';
  public static readonly PANEL_BTN_AREA_STANDARD: Length = '57%';
  public static readonly PANEL_BTN_AREA_SCIENCE: Length = '43%';
  public static readonly PANEL_SCIENCE_BTN_COLUMNS_TEMPLATE: string = '1fr 1fr 1fr';
  public static readonly PANEL_BTN_WIDTH_PERCENT_SCIENCE_BASE: number = 0.11;
  public static readonly PANEL_BTN_HEIGHT_PERCENT_SCIENCE_BASE: number = 0.09;
  public static readonly PANEL_BTN_HEIGHT_PERCENT_SCIENCE_FOLD: number = 0.1;
  public static readonly PANEL_SCIENCE_GAP_MD_SM: number = 48;
  public static readonly PANEL_SCIENCE_GAP_BASE: number = 80;
  public static readonly PANEL_SCIENCE_PADDING_LEFT_RIGHT_BASE: number = 32;
  public static readonly PANEL_SCIENCE_PADDING_LEFT_RIGHT_LG_MD: number = 64;
  public static readonly PANEL_BTN_FONT_SIZE_SCIENCE_PAD: number = 41;
  public static readonly PANEL_BTN_FONT_SIZE_FIRST_LINE_SCIENCE_PAD: number = 30;
  public static readonly PANEL_BTN_IMG_WIDTH_SCIENCE_PAD: number = 50;
  public static readonly PANEL_BTN_IMG_HEIGHT_SCIENCE_PAD: number = 50;
  public static readonly PANEL_BTN_FONT_SIZE_SCIENCE_PHONE: number = 20;
  public static readonly PANEL_BTN_FONT_SIZE_FIRST_LINE_SCIENCE_PHONE: number = 16;
  public static readonly PANEL_BTN_IMG_WIDTH_SCIENCE_PHONE: number = 27;
  public static readonly PANEL_BTN_IMG_HEIGHT_SCIENCE_PHONE: number = 27;
  public static readonly PANEL_BTN_FONT_SIZE_SCIENCE_FOLD: number = 30;
  public static readonly PANEL_BTN_FONT_SIZE_FIRST_LINE_SCIENCE_FOLD: number = 20;
  public static readonly PANEL_BTN_IMG_WIDTH_SCIENCE_FOLD: number = 40;
  public static readonly PANEL_BTN_IMG_HEIGHT_SCIENCE_FOLD: number = 40;
  public static readonly STAND_PANEL_WIDTH_PERCENT: number = 0.57;
  public static readonly SCIENCE_PANEL_WIDTH_PERCENT: number = 0.43;
}