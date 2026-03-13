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
 * Key Text
 *
 * @since 2024-04-22
 */
export enum KeyText {
  KEYTEXT_NATURAL_LOGARITHM = 'ln(', //ln
  KEYTEXT_LOGARITHM = 'log(', //log
  KEYTEXT_SIN = 'sin(', //sin
  KEYTEXT_COS = 'cos(', //cos
  KEYTEXT_TAN = 'tan(', //tan
  KEYTEXT_ASIN = 'sin\u207B\u00B9(', //sin-1
  KEYTEXT_ACOS = 'cos\u207B\u00B9(', //cos-1
  KEYTEXT_ATAN = 'tan\u207B\u00B9(', //tan-1
  KEYTEXT_SQUARED = '^(2)', //^2
  KEYTEXT_CUBE = '^(3)', //^3
  KEYTEXT_INVERSE_PROPORTIONAL = '^(-1)', //1/x
  KEYTEXT_POWER = '^(', // x^y
  KEYTEXT_FACTORIAL = '!', //x!
  KEYTEXT_CUBE_ROOTING = '^(1÷', //y√x
  KEYTEXT_EXPONENTIAL_OF_E = 'e^(', //e^x
  KEYTEXT_EXPONENTIAL_OF_TEN = '10^(', //10^x
  KEYTEXT_SQUARE_ROOTING = '√(',
  KEYTEXT_NATURAL_CONSTANT = 'e',
  KEYTEXT_PIE = 'π',
  KEYTEXT_INVERSE_MATRIX = 'Inv',
  KEYTEXT_DEGREE = 'Deg',
  KEYTEXT_RAD = 'Rad',
}