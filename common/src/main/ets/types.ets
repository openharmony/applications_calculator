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

/**
 * Breakpoints that represent xs_small device types.
 */
export const BREAKPOINT_XS: string = 'xs';

/**
 * Breakpoints that represent small device types.
 */
export const BREAKPOINT_SM: string = 'sm';

/**
 * Breakpoints that represent middle device types.
 */
export const BREAKPOINT_MD: string = 'md';

/**
 * Breakpoints that represent middle device types.
 */
export const BREAKPOINT_MD_TABLET: string = 'mdTablet';

/**
 * Breakpoints that represent large device types.
 */
export const BREAKPOINT_LG: string = 'lg';

/**
 * Range of the small device width.
 */
export const RANGE_SM: number = 320;

/**
 * Range of the middle device width.
 */
export const RANGE_MD: number = 520;

/**
 * Range of the large device width.
 */
export const RANGE_LG: number = 840;

/**
 * according to UX,preview area height is 22% in window.
 */
export const TOP_AREA_PERCENT: number = 0.22;

/**
 * according to UX,title area height is 48vp.
 */
export const TITLE_AREA_HEIGHT: number = 48;

/**
 * according to UX,panel area height is 78% in window.
 */
export const PANEL_HEIGHT_PERCENT: number = 0.78;

/**
 * according to UX,panel button width is 85% in parent view.
 */
export const PANEL_BTN_WIDTH_PERCENT: number = 0.85;

/**
 * according to UX,panel button height is 85% in parent view.
 */
export const PANEL_BTN_HEIGHT_PERCENT: number = 0.85;

/**
 * according to UX,panel row count is 6.
 */
export const PANEL_ROW_NUM: number = 6;

/**
 * according to UX,panel colum count is 4.
 */
export const PANEL_COLUM_NUM: number = 4;

/**
 * according to UX,panel font size min is 10.
 */
export const PANEL_FONT_SIZE_MIN: number = 10;

/**
 * according to UX,panel padding is 12vp.
 */
export const PANEL_PADDING: Padding = {
  top: 12,
  left: 12,
  right: 12,
  bottom: 12,
};

/**
 * the model of window size
 */
export class WindowSize {
  public topSafe?: number;
  public bottomSafe?: number;
  public width?: number;
  public height?: number;
}

export const KEY_WINDOW_WIDTH: string = 'windowWidth';

export const KEY_WINDOW_HEIGHT: string = 'windowHeight';

export const KEY_CONTENT_WIDTH: string = 'contentWidth';

export const KEY_CONTENT_HEIGHT: string = 'contentHeight';

export const BREAKPOINT_SM_MD: string = 'sm_md'; // 直板机竖屏
export const BREAKPOINT_MD_SM: string = 'md_sm'; // 直板机横屏
export const BREAKPOINT_MD_MD: string = 'md_md'; // 折叠屏展开态
export const BREAKPOINT_MD_LG: string = 'md_lg'; // pad竖屏
export const BREAKPOINT_LG_MD: string = 'lg_md'; // pad横屏

export const BREAKPOINT_FULL_SCREEN: number = 1; // APP全屏模式
export const BREAKPOINT_FLOATING: number = 4; // APP自由悬浮形式窗口模式
export const BREAKPOINT_SPLIT_SCREEN_LEFT_RIGHT: number = 5; // APP左右分屏模式
export const BREAKPOINT_SPLIT_SCREEN_UP_DOWN: number = 6; // APP上下分屏模式

export const SPLIT_SCREEN_MULTIPLE_HALF: number = 1; // APP上下分屏模式1/2
export const SPLIT_SCREEN_MULTIPLE_ONE_THIRD: number = 2; // APP上下分屏模式1/3
export const SPLIT_SCREEN_MULTIPLE_TWO_THIRD: number = 3; // APP上下分屏模式2/3