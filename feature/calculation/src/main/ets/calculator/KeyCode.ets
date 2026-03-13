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

import { KeyText } from './KeyText';

/**
 * KeyCode
 *
 * @since 2023-03-10
 */
export enum KeyCode {
  KEYCODE_0 = 0,
  KEYCODE_1 = 1,
  KEYCODE_2 = 2,
  KEYCODE_3 = 3,
  KEYCODE_4 = 4,
  KEYCODE_5 = 5,
  KEYCODE_6 = 6,
  KEYCODE_7 = 7,
  KEYCODE_8 = 8,
  KEYCODE_9 = 9,
  KEYCODE_PERCENT = 10, // %
  KEYCODE_DOT = 11, // .
  KEYCODE_ADD = 12, // +
  KEYCODE_DIVIDE = 13,
  KEYCODE_MULTIPLY = 14,
  KEYCODE_SUBTRACT = 15, // -
  KEYCODE_CLEAR = 16, // C
  KEYCODE_BACK = 17,
  KEYCODE_EQUALS = 18, // =
  KEYCODE_MEM_CLEAR = 19, // MC
  KEYCODE_MEM_ADD = 20, // M+
  KEYCODE_MEM_SUBTRACT = 21, // M-
  KEYCODE_MEM_RECOVERY = 22, // MR
  KEYCODE_LEFT_PARENTHESES = 23, // (
  KEYCODE_RIGHT_PARENTHESES = 24, // )
  KEYCODE_SQUARED = 25, // ^2
  KEYCODE_EXCIPIENT = 26,
  KEYCODE_CUBE = 27, // ^3
  KEYCODE_INVERSE_PROPORTIONAL = 28, // 1/x
  KEYCODE_POWER = 29, // x^y
  KEYCODE_FACTORIAL = 30, // x!
  KEYCODE_SQUARE_ROOTING = 31,
  KEYCODE_CUBE_ROOTING = 32,
  KEYCODE_NATURAL_CONSTANT = 33, // e
  KEYCODE_NATURAL_LOGARITHM = 34,
  KEYCODE_LOGARITHM = 35, // log
  KEYCODE_SIN = 36, // sin
  KEYCODE_COS = 37, // cos
  KEYCODE_TAN = 38, // tan
  KEYCODE_ASIN = 39, // sin-1
  KEYCODE_ACOS = 40, // cos-1
  KEYCODE_ATAN = 41, // tan-1
  KEYCODE_EXPONENTIAL_OF_E = 42, // e^x
  KEYCODE_EXPONENTIAL_OF_TEN = 43, // 10^x
  KEYCODE_PIE = 44,
  KEYCODE_INVERSE_MATRIX = 45,
  KEYCODE_DEGREE = 46,
  KEYCODE_RAD = 47,
}

export const KEYCODE_MAP: Map<number, string> = new Map([
  [KeyCode.KEYCODE_LEFT_PARENTHESES, '('],
  [KeyCode.KEYCODE_RIGHT_PARENTHESES, ')'],
  [KeyCode.KEYCODE_SQUARED, KeyText.KEYTEXT_SQUARED],
  [KeyCode.KEYCODE_CUBE, KeyText.KEYTEXT_CUBE],
  [KeyCode.KEYCODE_INVERSE_PROPORTIONAL, KeyText.KEYTEXT_INVERSE_PROPORTIONAL],
  [KeyCode.KEYCODE_POWER, KeyText.KEYTEXT_POWER],
  [KeyCode.KEYCODE_FACTORIAL, KeyText.KEYTEXT_FACTORIAL],
  [KeyCode.KEYCODE_SQUARE_ROOTING, KeyText.KEYTEXT_SQUARE_ROOTING],
  [KeyCode.KEYCODE_CUBE_ROOTING, KeyText.KEYTEXT_CUBE_ROOTING],
  [KeyCode.KEYCODE_NATURAL_CONSTANT, KeyText.KEYTEXT_NATURAL_CONSTANT],
  [KeyCode.KEYCODE_NATURAL_LOGARITHM, KeyText.KEYTEXT_NATURAL_LOGARITHM],
  [KeyCode.KEYCODE_LOGARITHM, KeyText.KEYTEXT_LOGARITHM],
  [KeyCode.KEYCODE_SIN, KeyText.KEYTEXT_SIN],
  [KeyCode.KEYCODE_COS, KeyText.KEYTEXT_COS],
  [KeyCode.KEYCODE_TAN, KeyText.KEYTEXT_TAN],
  [KeyCode.KEYCODE_ASIN, KeyText.KEYTEXT_ASIN],
  [KeyCode.KEYCODE_ACOS, KeyText.KEYTEXT_ACOS],
  [KeyCode.KEYCODE_ATAN, KeyText.KEYTEXT_ATAN],
  [KeyCode.KEYCODE_EXPONENTIAL_OF_E, KeyText.KEYTEXT_EXPONENTIAL_OF_E],
  [KeyCode.KEYCODE_EXPONENTIAL_OF_TEN, KeyText.KEYTEXT_EXPONENTIAL_OF_TEN],
  [KeyCode.KEYCODE_PIE, KeyText.KEYTEXT_PIE],
  [KeyCode.KEYCODE_INVERSE_MATRIX, KeyText.KEYTEXT_INVERSE_MATRIX],
  [KeyCode.KEYCODE_DEGREE, KeyText.KEYTEXT_DEGREE],
  [KeyCode.KEYCODE_RAD, KeyText.KEYTEXT_RAD],
]);