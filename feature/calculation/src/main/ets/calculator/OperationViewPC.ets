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

import common from '@ohos.app.ability.common';
import worker, { MessageEvents } from '@ohos.worker';
import deviceInfo from '@ohos.deviceInfo';
import { KeyCode } from '@ohos.multimodalInput.keyCode';
import { DisplayUtil, InputUtil, LogUtil, CommonUtil, } from '@hmos/common';
import { CalculatorState, ERROR_CODE } from '../components/types';
import { PhysicsButtonInfo } from '../info/PhysicsButtonInfo';
import { FONT_FAMILY_DEFAULT } from '../info/PanelSizeInfo';
import { DigitPanelController } from '..';
import UDC from '@ohos.data.unifiedDataChannel';
import UTD from '@ohos.data.uniformTypeDescriptor';

const TAG: string = 'OperationViewPC';
const ANIMATE_DURATION: number = 300;

/**
 * Operation view of PC
 *
 * @since 2023-11-13
 */
@Component
export struct OperationViewPC {
  @Consume('pageInfos') pageInfos: NavPathStack;
  @StorageLink('calculatorState') @Watch('onChange') calculatorState: CalculatorState = CalculatorState.INIT;
  @StorageLink('globalExpression') @Watch('globalExpChange') globalExp: string = '';
  @State @Watch('checkInputIncludeInvalid') displayExpression: string = this.checkResult(this.globalExp);
  @Link result: string;
  @Link isMemoryDisplay: boolean;
  @Link radOrDeg: boolean;
  @State enableCopyOrCut: boolean = true;
  @State moveExp: number = 0;
  @State moveRes: number = 0;
  @State scaleX: number = 1;
  @State scaleY: number = 1;
  @State centerX: number = 0;
  private expArea?: Area;
  private hideExpArea?: Area;
  private resArea?: Area;
  private inputValue?: (value?: PhysicsButtonInfo, keyValue?: string) => void;
  private isShiftPressed: boolean = false;
  private isPastePressed: boolean = false;
  private textInputController: TextInputController = new TextInputController();
  private textInputOffset: CaretOffset = { index: 0, x: 0, y: 0 };
  private context = getContext(this) as common.UIAbilityContext;
  @Link worker: worker.ThreadWorker;

  globalExpChange(value: string): void {
    this.displayExpression = this.checkResult(this.globalExp);
  }

  private checkPasteValue(value: string, event?: PasteEvent): void {
    if (event != undefined && event.preventDefault) {
      event.preventDefault();
    }
    let number = value.replace(new RegExp(',', 'g'), '')
    let BigNumberResult = DisplayUtil.isBigNumber(number);
    if (BigNumberResult) {
      this.pasteScientificNotation(number);
      this.isPastePressed = true;
      return;
    }
    let result = DisplayUtil.isNumberOrFloat(number);
    if (result) {
      if (new RegExp(/^-?(\.)?$/, 'g').test(number)) {
        return;
      } else {
        this.checkAndResetExp(number);
        this.isPastePressed = true;
      }
    } else {
      if(DigitPanelController.getInstance().getEvaluator()?.checkArithmeticExp(number)){
        this.pasteScientificNotation(number);
        this.isPastePressed = true;
        return;
      }
      // 如果校验粘贴内容不满足纯数字正则匹配，则显示非法输入提示
      this.isPastePressed = false;
      this.result = '';
      this.globalExp = this.context.resourceManager.getStringSync($r('app.string.invalid_input').id);

      // 设置光标位置到末尾
      CommonUtil.updateTextInputOffset(this.checkResult(this.globalExp).toString().length);
      CommonUtil.updateCopyResult('');
    }
  }

  pasteScientificNotation(value: string) {
    let trueIndex: number = CommonUtil.getTrueIndex(this.textInputController.getCaretOffset().index,this.displayExpression);
    trueIndex = CommonUtil.displayIndexToExpIndex(this.displayExpression, trueIndex);
    let leftExp: string = this.globalExp.substring(0, trueIndex);
    let rightExp: string = this.globalExp.slice(trueIndex);
    value = value.replace(new RegExp('E+', 'g'), 'E');
    let newEXPString: string = leftExp + value + rightExp;
    this.globalExp = newEXPString;
    let finalIndex = CommonUtil.expIndexToDisplayIndex(newEXPString, leftExp.length + value.length);
    CommonUtil.updateTextInputOffset(finalIndex);
    this.textInputController.caretPosition(finalIndex);
  }

  /**
   * 将粘贴的文字插入到光标位置并重新渲染表达式
   * @param void
   */
  private checkAndResetExp(value: string): void {
    let trueIndex: number = CommonUtil.getTrueIndex(this.textInputController.getCaretOffset().index,this.displayExpression);
    trueIndex = CommonUtil.displayIndexToExpIndex(this.displayExpression, trueIndex);
    let finalIndex = this.globalExp.length - trueIndex;
    // 定义粘贴位置附近的数字元素列表，记录粘贴内容在提取数字数组中的坐标位置，记录提取数字在原表达式中的头尾坐标
    let numberArr: string[] = [value];
    let valIndex: number = 0;
    let startIndex: number = 0;
    let endIndex: number = 0;
    for (let i = trueIndex - 1; i >= 0; i--) {
      if (DisplayUtil.isNumberOrPoint(this.globalExp[i])) {
        numberArr.unshift(this.globalExp[i]);
        valIndex++;
      } else {
        // 前面提取的元素不是数字之后，保存数字的前端坐标
        startIndex = i + 1;
        break;
      }
    }
    // 如果光标后是数字，则加入到list里
    for (let j = trueIndex; j < this.globalExp.length + 1; j++) {
      if (DisplayUtil.isNumberOrPoint(this.globalExp[j])) {
        numberArr.push(this.globalExp[j]);
      } else {
        // 后面提取的元素不是数字之后，保存数字的后端坐标
        endIndex = j;
        break;
      }
    }
    // 粘贴插入位置及附近数字小数点判断及转换
    let splitNumber: string = CommonUtil.splitNumber(numberArr, valIndex);

    // 将表达式拼接起来，数字前的表达式+粘贴内容与前面的数字+粘贴内容后面的数字+数字后面的表达式
    let newEXPString = this.globalExp.slice(0, startIndex) + splitNumber + this.globalExp.slice(endIndex);
    newEXPString = newEXPString.replace('--', '-').replace('+-', '-');
    // 设置光标位置：表达式总长-插入位置后面的表达式的长度
    let finalTextInputIndex = CommonUtil.expIndexToDisplayIndex(newEXPString, newEXPString.length - finalIndex);
    // 更新表达式和光标位置
    this.globalExp = newEXPString;
    CommonUtil.updateTextInputOffset(finalTextInputIndex);
    this.textInputController.caretPosition(finalTextInputIndex);
  }

  async aboutToAppear() {
    let index = this.checkResult(this.globalExp).toString().length;
    CommonUtil.updateTextInputOffset(index);
    this.textInputController.caretPosition(index);
  }

  /**
   * Listening for calculatorState change.
   */
  onChange(): void {
    LogUtil.info(TAG, 'calculatorState: ', this.calculatorState.toString());
    if (this.calculatorState === CalculatorState.ANIMATE) {
      if (this.result === '') {
        AppStorage.set<CalculatorState>('calculatorState', CalculatorState.RESULT);
      }

      animateTo({
        duration: ANIMATE_DURATION,
        curve: Curve.Linear,
        playMode: PlayMode.Normal,
        onFinish: () => {
          if (this.result && this.result !== ERROR_CODE) {
            this.globalExp = this.result;
            this.result = '';
            AppStorage.set<CalculatorState>('calculatorState', CalculatorState.RESULT);
          }
          this.restoreAnimateParam();
        },
      },
        () => {
          this.setAnimateParam();
        });
    }
  }

  /**
   * Restore the parameters of animation.
   */
  private restoreAnimateParam(): void {
    this.moveExp = 0;
    this.moveRes = 0;
    this.scaleX = 1;
    this.scaleY = 1;
    this.centerX = 0;
  }

  /**
   * Set the parameters of animation.
   */
  private setAnimateParam(): void {
    LogUtil.info(TAG, 'setAnimateParam');
    if (this.expArea?.height !== undefined) {
      this.moveExp = -Number.parseInt(this.expArea.height.toString());
    }
    if (this.resArea?.width !== undefined) {
      this.centerX = Number.parseInt(this.resArea.width.toString());
    }
    let expPosY: number = 0;
    if (this.hideExpArea?.globalPosition?.y !== undefined) {
      expPosY = Number.parseInt(this.hideExpArea.globalPosition.y.toString());
    }
    let resPosY: number = 0;
    if (this.resArea?.globalPosition?.y !== undefined) {
      resPosY = Number.parseInt(this.resArea.globalPosition.y.toString());
    }
    this.moveRes = expPosY - resPosY;
    if (this.hideExpArea?.width !== undefined && this.resArea?.width !== undefined) {
      this.scaleX = Number.parseInt(this.hideExpArea.width.toString()) /
      Number.parseInt(this.resArea.width.toString());
    }
    if (this.hideExpArea?.height !== undefined && this.resArea?.height !== undefined) {
      this.scaleY = Number.parseInt(this.hideExpArea.height.toString()) /
      Number.parseInt(this.resArea.height.toString());
    }
  }

  /**
   * Handle keyboard event.
   *
   * @param { KeyEvent } event data of KeyEvent
   */
  private handleKeyEvent(event?: KeyEvent): void {
    if (deviceInfo.deviceType === '2in1') {
      if (event === null || event === undefined) {
        return;
      }
      if (event.keyCode === KeyCode.KEYCODE_SHIFT_LEFT || event.keyCode === KeyCode.KEYCODE_SHIFT_RIGHT) {
        this.isShiftPressed = event.type === KeyType.Down;
      }
      if (event.type === KeyType.Down) {
        const character: string = InputUtil.keyToString(event.keyCode, this.isShiftPressed);
        if (character !== null && this.inputValue !== undefined && this.inputValue !== null) {
          this.inputValue(undefined, character);
        }
      }
    }
  }

  /**
   * Check the value of result.
   *
   * @param { string } calculation result.
   * @return { string } formatAddSeparator result.
   */
  private checkResult(value: string): string {
    const result: string = DisplayUtil.formatAddSeparator(value);
    if (result === ERROR_CODE) {
      return this.context.resourceManager.getStringSync($r('app.string.error').id);
    }
    return result;
  }

  getDataFromUdmfRetry(event: DragEvent, callback: (data: DragEvent) => void) {
    try {
      let data: UnifiedData = event.getData();
      if (!data) {
        return false;
      }
      let records: Array<UDC.UnifiedRecord> = data.getRecords();
      if (!records || records.length <= 0) {
        return false;
      }
      callback(event);
      return true;
    } catch (e) {
      console.log("getData failed, code = " + e.code + ", message = " + e.message);
      return false;
    }
  }

  getDataFromUdmf(event: DragEvent, callback: (data: DragEvent) => void) {
    if (this.getDataFromUdmfRetry(event, callback)) {
      return;
    }
    setTimeout(() => {
      this.getDataFromUdmfRetry(event, callback);
    }, 1500);
  }

  @Builder
  FirstTextBuilder() {
    Stack({ alignContent: Alignment.End }) {
      Text(this.checkResult(this.result))
        .fontSize($r('app.float.display_formula_font_size_pc'))
        .maxFontSize($r('app.float.display_formula_font_size_pc'))
        .minFontSize($r('app.float.display_result_font_size_pc'))
        .maxLines(1)
        .opacity(0)
        .fontWeight(FontWeight.Medium)
        .fontFamily(FONT_FAMILY_DEFAULT)
        .textAlign(TextAlign.End)
        .onAreaChange((_, newValue) => {
          LogUtil.info(TAG, `onAreaChange: First text area is changing.`);
          this.hideExpArea = newValue;
        })
        .focusable(true)
        .defaultFocus(true)
        .onKeyEvent((event?: KeyEvent) => {
          this.handleKeyEvent(event);
        })
        .id('id_first_text_pc')

      TextInput({ text: this.displayExpression, controller: this.textInputController })
        .fontSize($r('app.float.display_formula_font_size_pc'))
        .maxFontSize($r('app.float.display_formula_font_size_pc'))
        .minFontSize($r('app.float.display_result_font_size_pc'))
        .fontColor($r('sys.color.font_primary'))
        .align(Alignment.TopEnd)
        .backgroundColor(Color.Transparent)
        .fontWeight(FontWeight.Medium)
        .fontFamily(FONT_FAMILY_DEFAULT)
        .focusable(true)
        .defaultFocus(true)
        .caretColor(Color.Blue)
        .maxLines(1)
        .padding(0)
        .margin(0)
        .border({ radius: 0 })
        .width('100%')
        .height('100%')
        .textAlign(TextAlign.End)
        .align(Alignment.End)
        .copyOption(this.enableCopyOrCut ? CopyOptions.LocalDevice : CopyOptions.None)
        .translate({ y: this.moveExp })
        .enableKeyboardOnFocus(false)
        .customKeyboard(this.customKeyBoardBuilder)
        .allowDrop([UTD.UniformDataType.PLAIN_TEXT])
        .onDrop((dragEvent?: DragEvent) => {
          LogUtil.info(TAG, `yangsiyi onDrop(): ${dragEvent?.getResult()}`)
          this.getDataFromUdmf((dragEvent as DragEvent), (event: DragEvent) => {
            event.setResult(DragResult.DRAG_CANCELED);
            let records: Array<UDC.UnifiedRecord> = event.getData().getRecords();
            let plainText: UDC.PlainText = records[0] as UDC.PlainText;
            let abstractContent = plainText.abstract as string;
            let textContent = plainText.textContent;
            LogUtil.info(TAG, `yangsiyi plainText.abstractContent: ${abstractContent}, textContent: ${textContent}`)
            this.checkPasteValue(textContent);
          })
        })
        .onChange((value: string) => {
          this.textInputController.caretPosition(CommonUtil.getTextInputOffset());
          LogUtil.info(TAG, `isPastePressed: ${this.isPastePressed}`);
          if (this.isPastePressed) {
            this.globalExp = value.replace(new RegExp(',', 'g'), '');
            LogUtil.info(TAG, 'globalExp value = ', this.globalExp);
            if (this.globalExp !== '') {
              this.sendMsg(this.globalExp, this.radOrDeg ? 'rad' : 'deg')
              this.receMsg(value);
            } else {
              this.result = ''
            }
            this.isPastePressed = false;
          }
          if (this.globalExp === '' && this.result !== '') {
            this.displayExpression = this.checkResult(this.result).toString();
          } else {
            this.displayExpression = this.checkResult(this.globalExp).toString();
          }
        })
        .onCopy((value: string) => {
          this.onTextInputCopyOrCut(value, 'copy');
        })
        .onCut((value: string) => {
          this.onTextInputCopyOrCut(value, 'cut');
        })
        .onPaste((value: string, event?: PasteEvent) => {
          this.checkPasteValue(value, event);
        })
        .onKeyEvent((event?: KeyEvent) => {
          this.handleKeyEvent(event);
        })
        .onTextSelectionChange((selectionStart: number, selectionEnd: number) => {
          this.handleTextSelectionChange(selectionStart, selectionEnd);
        })
        .onSubmit((enterKey: EnterKeyType, event: SubmitEvent) => {
          event.keepEditableState()
          CommonUtil.updateTextInputOffset(this.result.length)
        })
        .id('id_global_exp_pc')
    }
    .width('100%')
    .height($r('app.float.operation_view_first_height_pc'))
    .clip(true)
    .onAreaChange((_, newValue) => {
      this.expArea = newValue;
      DigitPanelController.getInstance().getEvaluator()?.setTextInputController(this.textInputController);
    })
  }

  @Builder
  SecondTextBuilder() {
    Stack({ alignContent: Alignment.End }) {
      Text(this.checkResult(this.result))
        .fontSize($r('app.float.display_result_font_size_pc'))
        .maxFontSize($r('app.float.display_result_font_size_pc'))
        .minFontSize($r('app.float.display_formula_small_font_size'))
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Clip })
        .copyOption(CopyOptions.LocalDevice)
        .textAlign(TextAlign.End)
        .fontWeight(FontWeight.Regular)
        .fontFamily(FONT_FAMILY_DEFAULT)
        .fontColor($r('sys.color.font_secondary'))
        .opacity($r('sys.float.ohos_id_alpha_content_primary'))
        .draggable(true)
        .translate({ y: this.moveRes })
        .onAreaChange((_, newValue) => {
          LogUtil.info(TAG, `onAreaChange: Second text area is changing.`);
          this.resArea = newValue;
        })
        .scale({
          x: this.scaleX,
          y: this.scaleY,
          centerX: this.centerX,
          centerY: 0,
        })
        .align(Alignment.BottomEnd)
        .focusable(true)
        .onKeyEvent((event?: KeyEvent) => {
          this.handleKeyEvent(event);
        })
        .id('id_second_text_pc')
    }
    .width('100%')
    .height($r('app.float.operation_view_second_height_pc'))
  }

  build() {
    Column() {
      this.FirstTextBuilder()

      this.SecondTextBuilder()
    }
    .width('100%')
    .margin({
      top: $r('app.float.operation_view_pc_margin_top'),
    })
    .id('id_operation_view_pc')
  }

  @Builder
  customKeyBoardBuilder() {
    Row().width('0').height('0')
  }

  /**
   * rece msg
   *
   * @param calcuCallBack Function
   */
  receMsg(value: string): void {
    this.worker.onmessage = (msg: MessageEvents) => {
      this.result = msg.data.result;
      if (DisplayUtil.isNumber(msg.data.exp) || DisplayUtil.isNumber(value.replace(new RegExp(',', 'g'), '')) ||
      this.isOperatorChar(value)) {
        this.result = '';
      }
      if (this.result !== '') {
        CommonUtil.updateCopyResult(this.result);
      }
      LogUtil.info(TAG, 'receMsg: ', msg.data.result);
    }
  }

  sendMsg(exp: string, angles: String): void {
    this.worker.postMessage({ exp: exp, angles: angles });
    LogUtil.info(TAG, `sendMsg: ${exp}`);
  }

  /**
   * is operator char
   * @param operator operator
   */
  isOperatorChar(operator: string): boolean {
    return (operator === '-' || operator === '+' || operator === '×' || operator === '÷');
  }

  private handleTextSelectionChange(selectionStart: number, selectionEnd: number): void {
    if (selectionStart === selectionEnd) {
      LogUtil.info(TAG, 'click, select nothing');
      AppStorage.setOrCreate('isSelectAll', false);
      return;
    }
    AppStorage.setOrCreate('isSelectAll', true);
    CommonUtil.updateTextInputOffset(this.checkResult(this.globalExp).toString().length);
    this.textInputController.setTextSelection(0, this.checkResult(this.globalExp).toString().length);
  }
  private onTextInputCopyOrCut(value: string, type: string): void {
    this.isPastePressed = CommonUtil.checkPastePressed(CommonUtil.isPastePressed(value,type));
    this.textInputController.stopEditing();
    CommonUtil.updateTextInputOffset(this.checkResult(this.globalExp).toString().length);
  }

  /**
   * 判断textInput里是否为"无效输入", 当为无效输入时，禁止复制和剪切操作
   * @param void
   */
  checkInputIncludeInvalid(value: string): void {
    let text = this.context.resourceManager.getStringSync($r('app.string.invalid_input').id);
    if (text === this.displayExpression) {
      this.enableCopyOrCut = false;
    } else {
      this.enableCopyOrCut = true;
    }
  }
}