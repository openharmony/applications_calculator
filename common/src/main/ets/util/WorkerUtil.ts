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

import { BigNumber } from 'mathjs';

const RESULT_LOWER_EXP: number = -15;
const RESULT_UPPER_EXP: number = 17;
const CALCULATOR_PRECISION: number = 20;
const STANDARD_MAX_LENGTH: number = 17;
const NUMBER_360: number= 360;
const NUMBER_330: number= 330;
const NUMBER_300: number= 300;
const NUMBER_270: number= 270;
const NUMBER_240: number= 240;
const NUMBER_180: number= 180;
const NUMBER_150: number= 150;
const NUMBER_135: number= 135;
const NUMBER_120: number= 120;
const NUMBER_90: number= 90;
const NUMBER_60: number= 60;
const NUMBER_45: number= 45;
const NUMBER_30: number= 30;
const N_NUMBER_30: number= -30;
const NUMBER_2: number= 2;
const NUMBER_05: number= 0.5;
const SIN: string= 'sin';
const COS: string= 'cos';
const TAN: string= 'tan';
const A_SIN: string= 'asin';
const A_COS: string= 'acos';
const A_TAN: string= 'atan';
const N_NUMBER_05: number= -0.5;
const ERROR_CODE: string = 'error';

export class WorkerUtil {
  public static setSinValue(x: BigNumber, result: BigNumber, MATH: math.MathJsStatic): BigNumber {
    if (MATH.equal(MATH.mod(x, NUMBER_360), NUMBER_30)) {
      return MATH.bignumber(NUMBER_05);
    }
    if (MATH.equal(MATH.mod(x, NUMBER_360), NUMBER_150)) {
      return MATH.bignumber(NUMBER_05);
    }
    if (MATH.equal(MATH.mod(x, NUMBER_360), NUMBER_330)) {
      return MATH.bignumber(N_NUMBER_05);
    }
    if (MATH.equal(MATH.mod(x, NUMBER_180), 0)) {
      return MATH.bignumber(0);
    }
    return result;
  }

  public static setCosValue(x: BigNumber, result: BigNumber, MATH: math.MathJsStatic): BigNumber {
    if (MATH.equal(MATH.mod(x, NUMBER_360), NUMBER_60)) {
      return MATH.bignumber(NUMBER_05);
    }
    if (MATH.equal(MATH.mod(x, NUMBER_360), NUMBER_300)) {
      return MATH.bignumber(NUMBER_05);
    }
    if (MATH.equal(MATH.mod(x, NUMBER_360), NUMBER_120)) {
      return MATH.bignumber(N_NUMBER_05);
    }
    if (MATH.equal(MATH.mod(x, NUMBER_360), NUMBER_240)) {
      return MATH.bignumber(N_NUMBER_05);
    }
    if (MATH.equal(MATH.mod(x, NUMBER_360), NUMBER_90)) {
      return MATH.bignumber(0);
    }
    if (MATH.equal(MATH.mod(x, NUMBER_360), NUMBER_270)) {
      return MATH.bignumber(0);
    }
    return result;
  }

  public static setTanValue(x: BigNumber, result: BigNumber, MATH: math.MathJsStatic): BigNumber {
    if (MATH.equal(MATH.mod(x, NUMBER_180), NUMBER_45)) {
      return MATH.bignumber(1);
    }
    if (MATH.equal(MATH.mod(x, NUMBER_180), NUMBER_135)) {
      return MATH.bignumber(-1);
    }
    if (MATH.equal(MATH.mod(x, NUMBER_180), 0)) {
      return MATH.bignumber(0);
    }
    if (MATH.equal(MATH.mod(x, NUMBER_180), NUMBER_90)) {
      return MATH.bignumber(Infinity);
    }
    return result;
  }

  public static setSpecialValue(x: BigNumber, result: BigNumber, name: string, MATH: math.MathJsStatic): BigNumber {
    if (name === SIN) {
      result = this.setSinValue(x, result, MATH);
    }
    if (name === COS) {
      result = this.setCosValue(x, result, MATH);
    }
    if (name === TAN) {
      result = this.setTanValue(x, result, MATH);
    }
    return result;
  }

  public static setSpecialValueRad(x: BigNumber, result: BigNumber, name: string, MATH: math.MathJsStatic): BigNumber {
    if (name === COS) {
      result = this.setCosValueRad(x, result, MATH);
    }
    return result;
  }

  public static setCosValueRad(x: BigNumber, result: BigNumber, MATH: math.MathJsStatic): BigNumber {
    if (MATH.equal(x, MATH.bignumber(MATH.pi / NUMBER_2))) {
      return MATH.bignumber(0);
    }
    return result;
  }

  public static getSpecialValue2(x: BigNumber, name: string, result: number, MATH: math.MathJsStatic): BigNumber {
    if (name === A_SIN) {
      if (MATH.equal(x, NUMBER_05)) {
        return MATH.bignumber(NUMBER_30);
      }
      if (MATH.equal(x, N_NUMBER_05)) {
        return MATH.bignumber(N_NUMBER_30);
      }
    }
    if (name === A_COS) {
      if (MATH.equal(x, NUMBER_05)) {
        return MATH.bignumber(NUMBER_60);
      }
      if (MATH.equal(x, N_NUMBER_05)) {
        return MATH.bignumber(NUMBER_120);
      }
    }
    return MATH.bignumber(result / NUMBER_2 / Math.PI * NUMBER_360);
  }

  public static calculate(exp: string, MATH: math.MathJsStatic): string {
    let result: string = '';
    // 如果进入了计算过程，去掉最后面的运算符
    let operator: string = exp.substring(exp.length - 1, exp.length);
    if (operator === '-' || operator === '+' || operator === '×' || operator === '÷') {
      exp = exp.substring(0, exp.length - 1);
    }
    exp = this.resultEXP(exp);
    if (this.isAddAfterAllOperator(exp)) {
      return ERROR_CODE;
    }

    try {
      exp = this.getPercent(exp).replace(/×/g, '*')
        .replace(/÷/g, '/')
        .replace(/√/g, 'sqrt')
        .replace(/π/g, 'PI')
        .replace(/log/g, 'log10')
        .replace(/ln/g, 'log')
        .replace(/sin⁻¹/g, 'asin')
        .replace(/cos⁻¹/g, 'acos')
        .replace(/tan⁻¹/g, 'atan');
      const res: string = MATH.format(MATH.evaluate(exp), {
        lowerExp: RESULT_LOWER_EXP,
        upperExp: RESULT_UPPER_EXP,
        precision: CALCULATOR_PRECISION,
      });
      if (res === 'null' || res.search('i') !== -1 || res === 'NaN') {
        result = ERROR_CODE;
      } else {
        result = this.limitResult(res);
      }
    } catch (error) {
      result = ERROR_CODE;
    }
    result = ((result[result.length - 1] === '.') ? result.replace('.', '') : result);
    return result;
  }
  public static limitResult(result: string): string {
    if (result.includes('.')) {
      result = result.replace(/e\+/g, 'E').replace(/e\-/g, 'E-');
    } else {
      result = result.replace(/e\+/g, '\.E').replace(/e\-/g, '\.E-');
    }
    let str: string = result;
    if (str?.length <= STANDARD_MAX_LENGTH) {
      return str;
    }
    const index: number = str.search('E');
    if (index === -1) {
      str = str.substr(0, STANDARD_MAX_LENGTH);
    } else {
      const len: number = STANDARD_MAX_LENGTH + index - str.length;
      str = len < 0 ? ERROR_CODE : str.substr(0, len) + str.substr(index, str.length);
    }
    return str;
  }

  public static resultEXP(exp: string): string {
    //如果右括号不够，补充括号
    let leftParenthesisNum: number = 0;
    let rightParenthesisNum: number = 0;

    for (let i = 0; i < exp.length; i++) {
      if (exp[i] === '(') {
        leftParenthesisNum ++;
      }
      if (exp[i] === ')') {
        rightParenthesisNum ++;
      }
    }
    let parenthesisAdd: number = leftParenthesisNum - rightParenthesisNum;
    if (parenthesisAdd > 0) {
      for (let i = 0; i < parenthesisAdd; i++) {
        exp += ')';
      }
    }
    // 处理多个特殊符号（e,π）连在一起导致mathjs无法处理报错的情况
    exp = exp.replace(/\)(\d)/g, ')×$1').replace(/e/g, '(e)').replace(/π/g, '(π)');
    return exp;
  }

  public static isAddAfterAllOperator(exp: string): boolean {
    for (let i = 0; i < exp.length; i++) {
      if (i > 0 && (exp[i] === '+') &&
        (exp[i - 1] === '+' || exp[i - 1] === '-' || exp[i - 1] === '×' || exp[i - 1] === '÷')) {
        return true;
      }
    }
    return false;
  }

  public static getPercent(exp: string): string {
    let expression: string = exp;
    let percent: string = '%';
    let i: number = 0;
    let regex: RegExp = /^[0-9]+$/;
    while (exp.indexOf(percent, i) !== -1) {
      let startNum: number = exp.indexOf(percent, i);
      let endNum: number = exp.indexOf(percent, i) + percent.length - 1;
      let getstr: string = exp.substring(startNum + 1, endNum + NUMBER_2);
      if (regex.test(getstr) && getstr.length > 0) {
        expression = expression.replace('%', '/100*');
      } else {
        expression = expression.replace('%', 'casual');
      }
      i = exp.indexOf(percent, i) + percent.length;
    }
    return expression.replace(/casual/g, '%');
  }
}