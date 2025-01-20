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

import worker, { MessageEvents } from '@ohos.worker';
import relationalStore from '@ohos.data.relationalStore';
import common from '@ohos.app.ability.common';
import dataPreferences from '@ohos.data.preferences';
import { DisplayUtil, LogUtil, CommonUtil, AccessibilityPlayUtil } from '@hmos/common';
import { CalculatorState, ERROR_CODE } from '../components/types';
import { PhysicsButtonInfo } from '../info/PhysicsButtonInfo';
import {
  AccessibilityInfo,
  ACCESSIBILITY_ERROR,
  ACCESSIBILITY_CLEARED,
  ACCESSIBILITY_DELETED,
} from '../info/AccessibilityInfo';
import { ExpressionsModel } from '../model/ExpressionsModel';
import { KeyCode, KEYCODE_MAP } from './KeyCode';
import { KeyText } from './KeyText';

const TAG: string = 'Evaluator';
const SHARE_MEMORY: string = 'share_memory';
const NAN: string = 'NaN';

/**
 * Evaluator class, use thread
 *
 * @since 2023-03-20
 */
export class Evaluator {
  private calculatorState: CalculatorState = CalculatorState.INIT;
  private expressionsModel: ExpressionsModel;
  private sharePreference: dataPreferences.Preferences | null = null;
  private controller: TextInputController | null = null;
  private result: string = '';
  //默认是角度制
  private angles: string = 'deg';
  //需要补充括号的key列表
  private needLeftParenthesisCodes: number[] = [
    KeyCode.KEYCODE_SIN,
    KeyCode.KEYCODE_COS,
    KeyCode.KEYCODE_TAN,
    KeyCode.KEYCODE_ASIN,
    KeyCode.KEYCODE_ACOS,
    KeyCode.KEYCODE_ATAN,
    KeyCode.KEYCODE_NATURAL_LOGARITHM,
    KeyCode.KEYCODE_LOGARITHM,
    KeyCode.KEYCODE_SQUARE_ROOTING,
  ];
  private resultAdd: number[] = [
    KeyCode.KEYCODE_INVERSE_PROPORTIONAL,
    KeyCode.KEYCODE_SQUARED,
    KeyCode.KEYCODE_CUBE,
    KeyCode.KEYCODE_POWER,
    KeyCode.KEYCODE_FACTORIAL,
    KeyCode.KEYCODE_PERCENT,
    KeyCode.KEYCODE_CUBE_ROOTING,
  ];
  private resultKeyValueAdd: string[] = [
    KeyText.KEYTEXT_INVERSE_PROPORTIONAL,
    KeyText.KEYTEXT_SQUARED,
    KeyText.KEYTEXT_CUBE,
    KeyText.KEYTEXT_POWER,
    KeyText.KEYTEXT_FACTORIAL,
  ];
  private expression: string = '';
  private isMemRecovery: boolean = false;
  private inSpecial: boolean = false;
  private index: number = 0;
  private worker: worker.ThreadWorker;
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  private arithmeticElement: string[] = [
    'a', 'c', 'o', 'n', 'l', 's', 'g', 't', 'i', '\u207B', '\u00B9',
    '%', '+', '-', '×', '÷', '(', ')', '√', '^', 'E', 'e', 'π', '!'
  ];

  /**
   * constructor
   *
   * @param worker worker.ThreadWorker
   */
  constructor(worker: worker.ThreadWorker) {
    this.worker = worker;
    this.expressionsModel = new ExpressionsModel();
    this.getPreference();
    let expressionValue: string | undefined = AppStorage.get<string>('globalExpression');
    if (expressionValue !== undefined) {
      this.expression = expressionValue;
    }
    let resultValue: string | undefined = AppStorage.get<string>('globalResult');
    if (resultValue !== undefined) {
      this.result = resultValue;
    }
    let radOrDegFlag: boolean | undefined = AppStorage.get<boolean>('radOrDegFlag');
    if (radOrDegFlag !== undefined) {
      this.angles = radOrDegFlag ? 'rad' : 'deg';
    }
  }

  /**
   * 设置TextInputController.
   *
   * @param TextInputController 需要设置的TextInputController
   */
  public setTextInputController(controller: TextInputController): void {
    this.controller = controller;
  }

  /**
   * is operator
   *
   * @param operator operator
   */
  isOperator(operator: number): boolean {
    return operator === KeyCode.KEYCODE_ADD || operator === KeyCode.KEYCODE_SUBTRACT ||
      operator === KeyCode.KEYCODE_MULTIPLY || operator === KeyCode.KEYCODE_DIVIDE;
  }

  /**
   * is operator char
   * @param operator operator
   */
  isOperatorChar(operator: string): boolean {
    return (operator === '-' || operator === '+' || operator === '×' || operator === '÷');
  }

  isOperatorCharOrLeftParentheses(operator: string): boolean {
    return (operator === '-' || operator === '+' || operator === '×' || operator === '÷' || operator === '(');
  }

  /**
   * setState
   *
   * @param state CalculatorState
   */
  setState(state: CalculatorState): void {
    this.calculatorState = state;
    AppStorage.set<CalculatorState>('calculatorState', state);
  }

  /**
   *
   * @param exp
   */
  setGlobalExpression(exp: string): void {
    LogUtil.info(TAG, 'GlobalExpression:', exp);
    AppStorage.setOrCreate('globalExpression', exp);
  }

  setGlobalResult(exp: string): void {
    LogUtil.info(TAG, 'globalResult:', exp)
    AppStorage.setOrCreate('globalResult', exp);
  }

  /**
   * clear
   */
  onClear(): void {
    this.index = 0;
    CommonUtil.updateTextInputOffset(0);
    this.expression = '';
    this.result = '';
    CommonUtil.updateCopyResult('');
    this.setState(CalculatorState.INPUT);
    this.setGlobalExpression('');
    this.setGlobalResult('');
  }

  /**
   * add expression
   *
   * @param pButton PhysicsButtonInfo
   * @param callBack Function
   */
  addExpression(callBack: Function, pButton?: PhysicsButtonInfo, pValue?: string): void {
    if (this.calculatorState !== CalculatorState.RESULT) {
      this.calculatorState = AppStorage.get('calculatorState') || CalculatorState.ERROR;
    }
    if (this.calculatorState === CalculatorState.RESULT && this.result !== '') {
      this.expression = this.result;
      this.result = '';
      CommonUtil.updateCopyResult(this.result);
    }

    // handle keyboard button
    if (pValue !== null && pValue !== undefined && this.addKeyboardValue(callBack, pValue)) {
      return;
    }
    // handle physics button
    if (pButton !== null && pButton !== undefined && this.addButtonValue(callBack, pButton)) {
      return;
    }

    this.setGlobalExpression(this.expression);
    this.setGlobalResult(this.result);
    if (this.expression.length > 0) {
      this.sendMsg(this.expression, this.angles);
      this.receiveMsg(callBack);
    }
  }

  /**
   * To deal with pValue
   *
   * @param { string } pValue
   * @param { Function } callBack
   */
  private addKeyboardValue(callBack: Function, pValue: string): boolean {
    let leftAndRightExp: string[] = this.getLeftAndRightExp();
    let leftExp: string = leftAndRightExp[0];
    let rightExp: string = leftAndRightExp[1];
    if (this.calculatorState === CalculatorState.ANIMATE || pValue === 'error') {
      CommonUtil.updateTextInputOffset(this.getDisplayIndex());
      return true;
    }
    if (pValue === '') {
      if (AppStorage.get('isSelectAll')) {
        return this.onClearByKey(callBack);
      }
      return this.dealPvalueNull(callBack, leftExp, rightExp);
    } else if (pValue === 'C') {
        return  this.onClearByKey(callBack);
    } else if (this.isOperatorChar(pValue)) {
      this.setState(CalculatorState.INPUT);
      return this.handleExpressionWithByKey(leftExp, rightExp, pValue, callBack);
    } else if (pValue === '=') {
      this.handleEqualBtnClick(callBack);
      return true;
    }
    if (this.calculatorState === CalculatorState.RESULT && this.expression !== '') {
      if (pValue === '%' || this.resultKeyValueAdd.includes(pValue)) {
        this.setState(CalculatorState.INPUT);
      } else {
        this.resultStateClearAction(pValue, callBack);
       /* if (this.expression === '') {
          this.cleanAction(callBack);
        }*/
        return false;
      }
    }
    if (pValue === '.') {
      if (this.pointAction(pValue, leftExp, rightExp, callBack)) {
        return true;
      }
    } else if (DisplayUtil.isDigit(pValue.toString())) {
      return this.numberInputAction(pValue.toString(), leftExp, rightExp, callBack);
    }
    this.expression = leftExp + pValue + rightExp;
    CommonUtil.updateTextInputOffset(DisplayUtil.formatAddSeparator(leftExp + pValue).length);
    return false;
  }

  private dealPvalueNull(callBack: Function, leftExp: string, rightExp: string) {
    if (CommonUtil.getTextInputOffset() <= 0) {
      if (this.clearOrNoActionByKey(callBack)) {
        return true;
      }
    }
    this.backAction(leftExp, rightExp);
    return false;
  }
  /**
   * Deal with Operator Char
   *
   * @param { string } pValue
   */
  private dealWithOperatorCharInLast(pValue: string): void {
    this.expression = this.handleExpressionWithOperator(pValue, this.expression);
    this.setState(CalculatorState.INPUT);
    this.setGlobalExpression(this.expression);
    if (DisplayUtil.isNumber(this.expression)) {
      this.result = '';
      CommonUtil.updateCopyResult(this.result);
    }
    this.setGlobalResult(this.result);
  }

  private handleExpressionWithByKey(leftExp: string, rightExp: string, pValue: string, callBack: Function): boolean {
    if (rightExp === '') {
      this.dealWithOperatorCharInLast(pValue);
      CommonUtil.updateCopyResult(this.result);
      callBack({ 'result': this.result } as Record<string, string>);
      CommonUtil.updateTextInputOffset(DisplayUtil.formatAddSeparator(this.expression).length);
      return true;
    } else {
      leftExp = this.handleExpressionWithOperator(pValue, leftExp);
      this.expression = leftExp + rightExp;
      CommonUtil.updateTextInputOffset(DisplayUtil.formatAddSeparator(leftExp).length);
      return false;
    }
  }

  private onClearByKey(callBack: Function): boolean {
    this.onClear();
    CommonUtil.updateTextInputOffset(0);
    CommonUtil.updateCopyResult(this.result);
    callBack({ 'result': this.result } as Record<string, string>);
    return true;
  }

  /**
   * 获取当前页面的光标位置
   *
   * returns 光标位置
   */
  private getDisplayIndex(): number {
    if (this.controller === null) {
      return 0;
    }
    return this.controller.getCaretOffset().index;
  }

  /**
   * To deal with pButton
   *
   * @param { PhysicsButtonInfo } pButton
   * @param { Function } callBack
   */
  private getLeftAndRightExp(): string[] {
    // 首先获取带逗号的表达式原型，以匹配节目传过来的带逗号之后的index
    let expressionValue: string | undefined = AppStorage.get<string>('globalExpression');
    if (expressionValue !== undefined) {
      this.expression = DisplayUtil.formatAddSeparator(expressionValue);
    }
    if (this.expression === this.context.resourceManager.getStringSync($r('app.string.invalid_input').id)) {
      this.onClear();
    }
    let leftExp: string = '';
    let rightExp: string = '';

    // 用于判定当前光标是否在一些特殊的表达式如三角函数内
    this.inSpecial = false;

    // 这个index时带逗号占位之后产生的index
    this.index = this.getDisplayIndex();

    // 判断如果在某些特殊表达式中间或者刚好在最右边，标记一下，或者移动位置，保证下个字符或者删除操作可以在它后面执行
    if (this.expression !== '' && this.expression !== null && this.index > 0) {
      if (['a', 'c', 'o', 'n', 'l', 's', 'g', 't', 'i', '\u207B', '\u00B9']
        .includes(this.expression[this.index - 1])) {
        this.inSpecial = true;
        this.getSpecialIndex();
      }
      if (this.expression[this.index - 1] === '(' && this.index > 1) {
        if (['a', 'c', 'o', 'n', 'l', 's', 'g', 't', 'i', '\u207B', '\u00B9']
          .includes(this.expression[this.index - 2])) {
          this.inSpecial = true;
        }
      }
    }
    if (this.index === 0) {
      // 如何当前index为0，则right就是exp，为空时也一样
      rightExp = this.expression;
    } else if (this.index === this.expression.length) {
      // 如果index为当前exp的长度，则left为exp，为空时也一样
      leftExp = this.expression;
    } else {
      // 如果index不为0，则将表达式切分为左右两段
      leftExp = this.expression.substring(0, this.index);
      rightExp = this.expression.substring(this.index, this.expression.length);
    }

    // 切分完成后去掉逗号以便于后续操作
    this.expression = this.expression.replace(new RegExp(',', 'g'), '');
    leftExp = leftExp.replace(new RegExp(',', 'g'), '');
    rightExp = rightExp.replace(new RegExp(',', 'g'), '');
    return [leftExp, rightExp];
  }

  private getSpecialIndex(): void {
    for (let i = this.index - 1; i < this.expression.length; i++) {
      if (this.expression[i] === '(') {
        this.index = i + 1;
        break;
      }
    }
  }

  private backActionForRightNumber(leftExp: string, rightExp: string, rightDigitNumber: number, keyText: string) {
    //处理删除完成后数字合并的各种问题
    let rightNumber = rightExp.substring(0, rightDigitNumber);
    let completeNumber = leftExp + keyText + rightNumber;

    if (!DisplayUtil.isLegalFormulaTail(completeNumber)) {
      //如果最后的数字不满足显示条件，则先判断左边的最后是不是0，如果是，则删除
      if (leftExp.substring(leftExp.length - 1, leftExp.length) === '0') {
        leftExp = leftExp.substring(0, leftExp.length - 1)
        completeNumber = leftExp + keyText + rightNumber;
      }
    }

    if (!DisplayUtil.isLegalFormulaTail(completeNumber) && !this.checkPastScience(completeNumber)) {
      //如果依然不满足条件，则开始处理右边字符串的数字，进行删除0直到满足条件
      let rightNumberIndex = rightNumber.length;
      for (let i = 0; i < rightNumberIndex; i++) {
        rightNumber = rightNumber.substring(1, rightNumber.length);
        rightExp = rightExp.substring(1, rightExp.length);
        completeNumber = leftExp + keyText + rightNumber;
        if (DisplayUtil.isLegalFormulaTail(completeNumber)) {
          rightDigitNumber = rightDigitNumber - (i + 1);
          break;
        }
      }
    }

    //处理完成后计算index位置
    completeNumber = DisplayUtil.formatAddSeparator(completeNumber);
    if (rightDigitNumber > 0) {
      let final = this.getIndexByNumberComma(completeNumber, rightDigitNumber);
      CommonUtil.updateTextInputOffset(final);
    } else {
      CommonUtil.updateTextInputOffset(DisplayUtil.formatAddSeparator(leftExp + keyText).length);
    }
    this.expression = leftExp + keyText + rightExp;
    return;
  }

  private checkPastScience(completeNumber: string): boolean {
    let res: boolean = false;
    let arr: string[] = completeNumber.split('E');
    let i = 0;
    while (arr[0].indexOf('.', i) !== -1) {
      i = arr[0].indexOf('.', i) + 1;
    }
    if (arr.length > 0 && i > 1) {
      res = true;
    }
    return res;
  }

  private checkLeftExpTailHasPoint(leftExp: string): boolean {
    //判断左边最末尾是否有小数点
    if (leftExp === '') {
      return false;
    }
    let length = leftExp.length;
    for (let i = 0; i < leftExp.length; i++) {
      let substring = leftExp.substring(length - (i + 1), length - i);
      if (DisplayUtil.isDigit(substring) || substring === '.') {
        if (substring === '.') {
          return true;
        }
      } else {
        break;
      }
    }
    return false;
  }

  private deleteRightExpFirstPoint(rightExp: string): string {
    //删除右侧最开始的小数点
    let returnExp = rightExp;
    let length = rightExp.length;
    for (let i = 0; i < length; i++) {
      let substring = rightExp.substring(i, i + 1);
      if (DisplayUtil.isDigit(substring) || substring === '.') {
        if (substring === '.') {
          returnExp = rightExp.substring(0, i) + rightExp.substring(i + 1, length);
        }
      } else {
        break;
      }
    }
    return returnExp;
  }

  private backAction(leftExp: string, rightExp: string): void {
    // 如何在特殊符号内部或者边上
    let keyText: string = '';
    if (this.inSpecial) {
      let length: number = leftExp.length;
      if (leftExp.substring(length - 3, length) === KeyText.KEYTEXT_NATURAL_LOGARITHM) {
        leftExp = leftExp.substring(0, leftExp.length - 3);
      } else if (leftExp.substring(length - 4, length) === KeyText.KEYTEXT_SIN ||
        leftExp.substring(length - 4, length) === KeyText.KEYTEXT_COS ||
        leftExp.substring(length - 4, length) === KeyText.KEYTEXT_TAN ||
        leftExp.substring(length - 4, length) === KeyText.KEYTEXT_LOGARITHM) {
        leftExp = leftExp.substring(0, leftExp.length - 4);
      } else if (leftExp.substring(length - 6, length) === KeyText.KEYTEXT_ASIN ||
        leftExp.substring(length - 6, length) === KeyText.KEYTEXT_ACOS ||
        leftExp.substring(length - 6, length) === KeyText.KEYTEXT_ATAN) {
        leftExp = leftExp.substring(0, leftExp.length - 6);
      } else {
        leftExp = leftExp.substring(0, leftExp.length - 1);
      }
      CommonUtil.updateTextInputOffset(DisplayUtil.formatAddSeparator(leftExp).length);
      if (rightExp !== '') {
        if (this.checkLeftExpTailHasPoint(leftExp)) {
          rightExp = this.deleteRightExpFirstPoint(rightExp);
        }
        let rightDigitNumber: number = this.getRightDigitNumber(rightExp);
        if (rightDigitNumber > 0) {
          this.backActionForRightNumber(leftExp, rightExp, rightDigitNumber, keyText);
          return;
        }
      }
      this.expression = leftExp + keyText + rightExp;
    } else {
      leftExp = leftExp.substring(0, leftExp.length - 1);
      CommonUtil.updateTextInputOffset(DisplayUtil.formatAddSeparator(leftExp).length);
      if (rightExp !== '') {
        if (this.checkLeftExpTailHasPoint(leftExp)) {
          rightExp = this.deleteRightExpFirstPoint(rightExp);
        }
        let rightDigitNumber: number = this.getRightDigitNumber(rightExp);
        if (rightDigitNumber > 0) {
          this.backActionForRightNumber(leftExp, rightExp, rightDigitNumber, keyText);
          return;
        }
      }
      this.expression = leftExp + keyText + rightExp;
    }
    this.setGlobalExpression(this.expression);
    if (!this.expression) {
      this.result = '';
    }
    this.setGlobalResult(this.result);
  }


  private setAngelByButton(keyCode: number) {
    if (keyCode === KeyCode.KEYCODE_DEGREE) {
      this.angles = 'deg';
      this.expression = this.expression.replace(new RegExp(',', 'g'), '');
    }
    // 设置为弧度制
    if (keyCode === KeyCode.KEYCODE_RAD) {
      this.angles = 'rad';
      this.expression = this.expression.replace(new RegExp(',', 'g'), '');
    }
  }

  private cleanAction(callBack: Function) {
    this.onClear();
    CommonUtil.updateTextInputOffset(0);
    callBack({ 'result': this.result } as Record<string, string>);
  }

  private clearOrNoAction(callBack: Function, keyCode: number): boolean {
    // 如果只有一个字符或者在result模式下，删除直接清空,或者按了清空按钮，也直接清空
      if (keyCode === KeyCode.KEYCODE_CLEAR || this.calculatorState === CalculatorState.RESULT ||
        this.expression === '' || (this.expression.length === 1 && this.index > 0)) {
        this.cleanAction(callBack);
        return true;
      }

    // 如果index为0，则不执行任何操作
    if (this.index === 0) {
      CommonUtil.updateTextInputOffset(0);
      CommonUtil.updateCopyResult(this.result);
      callBack({ 'result': this.result } as Record<string, string>);
      return true;
    }
    return false;
  }

  private clearOrNoActionByKey(callBack: Function): boolean {
    // 如果只有一个字符或者在result模式下，删除直接清空,或者按了清空按钮，也直接清空
    if (this.calculatorState === CalculatorState.RESULT || this.expression === '' ||
      (this.expression.length === 1 && this.index > 0)) {
      this.cleanAction(callBack);
      return true;
    }
    // 如果index为0，则不执行任何操作
    if (this.index === 0) {
      CommonUtil.updateTextInputOffset(0);
      CommonUtil.updateCopyResult(this.result);
      callBack({ 'result': this.result } as Record<string, string>);
      return true;
    }
    return false;
  }

  private needLeftParenthesis(keyText: string, keyCode: number): string | Resource {
    if (this.needLeftParenthesisCodes.includes(keyCode)) {
      keyText += '(';
    }
    return keyText;
  }

  private operatorAction(leftExp: string, rightExp: string, keyCode: number, callBack: Function): boolean {
    if (rightExp === '') {
      this.operatorForChar(keyCode, callBack);
      CommonUtil.updateTextInputOffset(DisplayUtil.formatAddSeparator(this.expression).length);
      return true;
    } else {
      let res: string = this.getOperatorForKeyCode(keyCode);
      leftExp = this.handleExpressionWithOperator(res, leftExp);
      this.expression = leftExp + rightExp;
      LogUtil.info(TAG, 'operator left', leftExp)
      CommonUtil.updateTextInputOffset(DisplayUtil.formatAddSeparator(leftExp).length);
      return false;
    }
  }

  private setSpecialKeyText(keyText: string | Resource, keyCode: number): string | Resource {
    // 科学计算器通过keycode赋值
    if (KEYCODE_MAP.has(keyCode)) {
      keyText = KEYCODE_MAP.get(keyCode)!;
    }
    return keyText;
  }

  private backClearButtonAction(callBack: Function, keyCode: number, leftExp: string, rightExp: string): boolean {
    if (this.clearOrNoAction(callBack, keyCode)) {
      return true;
    } else {
      this.backAction(leftExp, rightExp);
      if (this.expression === '') {
        this.cleanAction(callBack);
      }
      return false;
    }
  }

  private addButtonValue(callBack: Function, pButton?: PhysicsButtonInfo): boolean {
    if (this.calculatorState === CalculatorState.ANIMATE) {
      return true;
    }
    let keyCode: number = pButton!.keyCode;
    let leftRightExps: string[] = this.getLeftAndRightExp();
    let leftExp: string = leftRightExps[0];
    let rightExp: string = leftRightExps[1];
    if (keyCode === KeyCode.KEYCODE_DEGREE || keyCode === KeyCode.KEYCODE_RAD) {
      this.setAngelByButton(keyCode);
      return false;
    }
    if (keyCode === KeyCode.KEYCODE_INVERSE_MATRIX || this.isMemoryButtonClick(keyCode, callBack, leftExp, rightExp)) {
      return true;
    }
    let keyText: string | Resource = pButton!.keyText;
    if (keyCode === KeyCode.KEYCODE_BACK || keyCode === KeyCode.KEYCODE_CLEAR) {
      return this.backClearButtonAction(callBack, keyCode, leftExp, rightExp);
    }
    keyText = this.setSpecialKeyText(keyText, keyCode);
    if (this.isOperator(keyCode)) {
      // 解决了在计算结果中间插入运算符号等时点击等号没反应的问题
      this.setState(CalculatorState.INPUT);
      return this.operatorAction(leftExp, rightExp, keyCode, callBack);
    }
    if (keyCode === KeyCode.KEYCODE_EQUALS) {
      this.handleEqualBtnClick(callBack);
      return true;
    }
    // 设置部分按钮点击时不清除结果，直接在后面增加对应text
    if (this.calculatorState === CalculatorState.RESULT && this.expression !== '' && this.expression !== null) {
      if (this.resultAdd.includes(keyCode)) {
        this.setState(CalculatorState.INPUT);
        // 修改了在结果中插入平方立方等计算符显示在最后位置的问题
        // leftExp = this.expression;
        // rightExp = '';
      } else {
        this.resultStateClearAction(keyText.toString(), callBack);
        return false;
      }
    }
    if (this.pointAction(keyText.toString(), leftExp, rightExp, callBack)) {
      return true;
    }
    if (DisplayUtil.isDigit(keyText.toString())) {
      return this.numberInputAction(keyText.toString(), leftExp, rightExp, callBack);
    }
    this.expression = leftExp + keyText + rightExp;
    CommonUtil.updateTextInputOffset(DisplayUtil.formatAddSeparator(leftExp + keyText).length);
    return false;
  }

  private resultStateClearAction(keyText: string, callBack: Function): void {
    this.onClear();
    this.expression = keyText;
    this.setGlobalExpression(keyText);
    CommonUtil.updateTextInputOffset(DisplayUtil.formatAddSeparator(this.expression).length);
    callBack({ 'result': this.result } as Record<string, string>);
  }

  private pointAction(keyText: string, leftExp: string, rightExp: string, callBack: Function): boolean {
    if (keyText === '.') {
      if (!DisplayUtil.isLegalFormulaTail(leftExp + keyText)) {
        CommonUtil.updateCopyResult(this.result);
        callBack({ 'result': this.result } as Record<string, string>);
        return true;
      }
      if (rightExp !== '') {
        return this.checkRightPoint(rightExp, callBack);
      }
    }
    return false;
  }

  private checkRightPoint(rightExp: string, callBack: Function): boolean {
    for (let i = 0; i < rightExp.length; i++) {
      if (DisplayUtil.isDigit(rightExp[i].toString()) || rightExp[i] === '.') {
        if (rightExp[i] === '.') {
          CommonUtil.updateCopyResult(this.result);
          callBack({ 'result': this.result } as Record<string, string>);
          return true;
        }
      } else {
        break;
      }
    }
    return false;
  }

  private numberInputAction(keyText: string, leftExp: string, rightExp: string, callBack: Function): boolean {
    if (!DisplayUtil.isLegalFormulaTail(leftExp + keyText)) {
      if (leftExp.charAt(leftExp.length - 1) == '0') {
        leftExp = leftExp.slice(0, -1);
      } else {
        CommonUtil.updateCopyResult(this.result);
        callBack({ 'result': this.result } as Record<string, string>);
        return true;
      }
    }
    //找到完整的数字，加上逗号之后重新计算index的位置发给前端
    if (rightExp !== '') {
      if (leftExp === '') {
        if (keyText === '0' && DisplayUtil.isDigit(rightExp.substring(0, 1))) {
          CommonUtil.updateCopyResult(this.result);
          callBack({ 'result': this.result } as Record<string, string>);
          return true;
        }
      } else {
        let leftLast = leftExp.substring(leftExp.length - 1, leftExp.length);
        if ((!DisplayUtil.isDigit(leftLast) && leftLast !== '.')
          && keyText === '0' && DisplayUtil.isDigit(rightExp.substring(0, 1))) {
          CommonUtil.updateCopyResult(this.result);
          callBack({ 'result': this.result } as Record<string, string>);
          return true;
        }
      }
      let rightDigitNumber = this.getRightDigitNumber(rightExp);
      if (rightDigitNumber > 0) {
        let completeNumber = leftExp + keyText + rightExp.substring(0, rightDigitNumber);
        completeNumber = DisplayUtil.formatAddSeparator(completeNumber);
        let final = this.getIndexByNumberComma(completeNumber, rightDigitNumber);
        CommonUtil.updateTextInputOffset(final);
        this.expression = leftExp + keyText + rightExp;
        return false;
      }
    }
    this.expression = leftExp + keyText + rightExp;
    CommonUtil.updateTextInputOffset(DisplayUtil.formatAddSeparator(leftExp + keyText).length);
    return false;
  }

  private getRightDigitNumber(rightExp: string): number {
    let rightDigitNumber: number = 0;
    for (let i = 0; i < rightExp.length; i++) {
      if (DisplayUtil.isDigit(rightExp.substring(i, i + 1).toString())) {
        rightDigitNumber++;
      } else {
        break;
      }
    }
    return rightDigitNumber;
  }

  private getIndexByNumberComma(completeNumber: string, rightDigitNumber: number): number {
    //删除右边加入数字个数，剩下的就是真正的index位置
    let final: number = 0;
    for (let i = completeNumber.length - 1; i >= 0; i--) {
      if (DisplayUtil.isDigit(completeNumber.substring(i, i + 1).toString())) {
        rightDigitNumber--;
        if (rightDigitNumber === 0) {
          final = i;
          break;
        }
      }
    }
    return final;
  }

  /**
   * operatorForChar
   *
   * @param keyCode number
   * @param callBack Function
   */
  private operatorForChar(keyCode: number, callBack: Function): void {
    let res: string = this.getOperatorForKeyCode(keyCode);
    this.expression = this.handleExpressionWithOperator(res, this.expression);
    this.setState(CalculatorState.INPUT);
    this.setGlobalExpression(this.expression);
    if (DisplayUtil.isNumber(this.expression)) {
      this.result = '';
      CommonUtil.updateCopyResult('');
    }
    CommonUtil.updateCopyResult(this.result);
    callBack({ 'result': this.result } as Record<string, string>);
  }

  private getOperatorForKeyCode(keyCode: number): string {
    let res: string = '';
    switch (keyCode) {
      case KeyCode.KEYCODE_ADD: {
        res = '+';
        break;
      }
      case KeyCode.KEYCODE_SUBTRACT: {
        res = '-';
        break;
      }
      case KeyCode.KEYCODE_DIVIDE: {
        res = '÷';
        break;
      }
      case KeyCode.KEYCODE_MULTIPLY: {
        res = '×';
        break;
      }
      default: {
        res = '';
        break;
      }
    }
    return res;
  }

  /**
   * Handle expression with operator.
   *
   * @param { string } operator
   * @returns { string } Processed expression.
   */
  private handleExpressionWithOperator(res: string, leftExpression: string): string {
    let expression: string = leftExpression;
    if (expression.length === 0) {
      expression = res === '-' ? res : '';
    } else {
      let preCharacter: string = expression.charAt(expression.length - 1);
      if (res === '-') {
        expression = (preCharacter === '-' || preCharacter === '+') ?
        expression.substring(0, expression.length - 1) : expression;
      } else {
        while (this.isOperatorChar(preCharacter)) {
          expression = expression.substring(0, expression.length - 1);
          preCharacter = expression.charAt(expression.length - 1);
        }
      }
      expression += res;
    }
    return expression;
  }

  /**
   * handleEqualBtnClick
   *
   * @param callBack Function
   */
  private handleEqualBtnClick(callBack: Function): void {
    let copyResult: string = CommonUtil.getCopyResult();
    this.result = copyResult;
    if (this.result === '' || this.result === ERROR_CODE) {
      if (this.result !== '') {
        AccessibilityInfo.playAccessibilityByStr(ACCESSIBILITY_ERROR);
      }
      return;
    }
    CommonUtil.updateTextInputOffset(DisplayUtil.formatAddSeparator(this.result).length);
    let valueData: relationalStore.ValuesBucket = {
      'expression': DisplayUtil.formatAddSeparator(this.expression),
      'result': DisplayUtil.formatAddSeparator(this.result),
      'time_stamp': new Date().getTime(),
    };
    this.expressionsModel.insertRecord(valueData);
    this.setState(CalculatorState.ANIMATE);
    CommonUtil.updateCopyResult(this.result);
    callBack({ 'result': this.result } as Record<string, string>);
    AccessibilityPlayUtil.announceForAccessibility(this.result);
    this.expression = '';
  }

  /**
   * send msg
   *
   * @param exp string
   */
  sendMsg(exp: string, angles: String): void {
    if (exp !== null && exp !== undefined && exp.length > 1) {
      if (this.isOperatorChar(exp?.substr(exp.length - 1, exp.length))) {
        exp = exp?.substr(0, exp.length - 1);
      }
    }
    this.worker.postMessage({ exp: exp, angles: angles });
  }

  /**
   * receive msg
   *
   * @param calculatorCallBack Function
   */
  receiveMsg(calculatorCallBack: Function): void {
    this.worker.onmessage = (msg: MessageEvents) => {
      this.result = msg.data.result;
      if (DisplayUtil.isNumber(msg.data.exp) || DisplayUtil.isNumber(this.expression) ||
      this.isOperatorChar(this.expression)) {
        this.result = '';
      }
      CommonUtil.updateCopyResult(this.result);
      calculatorCallBack({ 'result': this.result } as Record<string, string>);
    };
  }

  /**
   * isMemoryButtonClick
   *
   * @param keyCode number
   * @param callBack Function
   */
  private isMemoryButtonClick(keyCode: number, callBack: Function, leftExp: string, rightExp: string): boolean {
    let isMem: boolean = false;
    switch (keyCode) {
      case KeyCode.KEYCODE_MEM_CLEAR: {
        isMem = true;
        this.clearMemory();
        break;
      }
      case KeyCode.KEYCODE_MEM_ADD: {
        isMem = true;
        this.handleMemoryChange('+');
        break;
      }
      case KeyCode.KEYCODE_MEM_SUBTRACT: {
        isMem = true;
        this.handleMemoryChange('-');
        break;
      }
      case KeyCode.KEYCODE_MEM_RECOVERY: {
        isMem = true;
        if (!this.isMemRecovery) {
          break;
        }
        let promise: Promise<string> = this.getMemory();
        promise.then(res => {
          this.memRecoveryAction(res, leftExp, rightExp, callBack);
        })
        break;
      }
      default: {
        isMem = false;
        break;
      }
    }
    return isMem;
  }

  private memRecoveryAction(res: string, leftExp: string, rightExp: string, callBack: Function) {
    let needResult: boolean = false;
    if (res === NAN) {
      this.result = ERROR_CODE;
      this.expression = '';
    } else {
      needResult = this.checkMemNeedSplice(leftExp, rightExp, res);
    }
    CommonUtil.updateTextInputOffset(DisplayUtil.formatAddSeparator(this.expression).length);
    if (needResult) {
      this.sendMsg(this.expression, this.angles);
      this.receiveMsg(callBack);
    } else {
      CommonUtil.updateCopyResult(this.result);
      this.setState(CalculatorState.RESULT);
      this.setGlobalExpression(this.expression);
      callBack({ 'result': this.result } as Record<string, string>);
    }
  }

  private checkMemNeedSplice(leftExp: string, rightExp: string, res: string): boolean {
    if (rightExp === ''
      && (leftExp != ''
        && this.isOperatorCharOrLeftParentheses(leftExp.substring(leftExp.length - 1, leftExp.length)))) {
      this.expression = this.expression + res;
      this.setGlobalExpression(this.expression);
      return true;
    } else {
      this.expression = res;
      this.setGlobalExpression(this.expression);
      this.result = '';
      return false;
    }
  }

  /**
   * handleMemoryChange
   *
   * @param operator string
   */
  private async handleMemoryChange(operator: string): Promise<void> {
    let memory: string = await this.getMemory();
    if (memory !== NAN) {
      let tmp: string = this.result || this.expression;
      if (tmp === ERROR_CODE || (tmp === '' && this.expression === '')) {
        return;
      }
      if (this.calculatorState === CalculatorState.RESULT && tmp === '') {
        tmp = this.expression;
      }
      this.sendMsg(memory + operator + tmp, this.angles);
      this.worker.onmessage = (msg: MessageEvents) => {
        if (msg.data.result === ERROR_CODE) {
          this.saveMemory(NAN);
        }
        this.saveMemory(msg.data.result);
      }
    }
  }

  /**
   * clear menory
   */
  private async clearMemory(): Promise<void> {
    this.saveMemory('');
  }

  /**
   * save memory
   */
  private async saveMemory(str: string): Promise<void> {
    await this.getPreference();
    if (this.sharePreference === null) {
      LogUtil.error(TAG, 'sharePreference is null');
      return;
    }
    try {
      await this.sharePreference.put(SHARE_MEMORY, str);
      await this.sharePreference.flush();
    } catch (err) {
      LogUtil.error(TAG, 'saveMemory Failed to get preferences', err?.message);
    }
  }

  /**
   * get memory
   */
  private async getMemory(): Promise<string> {
    await this.getPreference();
    if (this.sharePreference === null) {
      LogUtil.error(TAG, 'sharePreference is null');
      return '';
    }
    let mem: dataPreferences.ValueType = '';
    try {
      mem = await this.sharePreference.get(SHARE_MEMORY, '');
    } catch (err) {
      LogUtil.error(TAG, 'getMemory Failed to get preferences: ', err?.message);
    }
    return mem.toString();
  }

  /**
   * get memoryDisplay
   *
   * @return isMemoryDisplay true/false
   */
  async getMemoryDisplay(): Promise<boolean> {
    await this.getPreference();
    if (this.sharePreference === null) {
      LogUtil.error(TAG, 'sharePreference is null');
      return false;
    }
    let res: dataPreferences.ValueType = await this.sharePreference.get(SHARE_MEMORY, '');
    if(res !== ''){
      this.isMemRecovery = true;
    }
    return res !== '';
  }

  /**
   * get share prefernce
   */
  async getPreference(): Promise<void> {
    if (this.sharePreference !== null) {
      return;
    }
    try {
      this.sharePreference = await dataPreferences.getPreferences(this.context, SHARE_MEMORY);
    } catch (err) {
      LogUtil.error(TAG, 'getPreference Failed to get preferences', err?.message);
    }
  }

  /**
   * updateMemoryDisplay
   *
   * @param value PhysicsButtonInfo
   * @param callBack PhysicsButtonInfo
   */
  updateMemoryDisplay(value: PhysicsButtonInfo, callBack: Function): void {
    const key: number = value.keyCode;
    let change: boolean = false;
    let isDisplay: boolean = false;
    if (key === KeyCode.KEYCODE_MEM_CLEAR) {
      change = true;
      this.isMemRecovery = false;
    } else if (this.expression !== '' && (key === KeyCode.KEYCODE_MEM_ADD || key === KeyCode.KEYCODE_MEM_SUBTRACT)) {
      change = true;
      isDisplay = true;
      this.isMemRecovery = true;
    } else {
      change = false;
    }
    callBack({ 'change': change, 'isDisplay': isDisplay } as Record<string, boolean>);
  }

  public checkArithmeticExp(value: string): boolean {
    let res: boolean = true;
    let arr: string[] = value.split('');
    for (let i = 0; i < arr.length; i++) {
      if (DisplayUtil.isNumberOrPoint(arr[i]) || this.arithmeticElement.includes(arr[i])) {
        res = true;
      } else {
        res = false;
        break;
      }
    }
    return res;
  }
}