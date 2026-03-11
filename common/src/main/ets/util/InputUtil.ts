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

/**
 * GlobalThisHelper
 *
 * @since 2023-9-11
 */
export class InputUtil {
  private static keyForNumber(keyCode: number, isShfitPressed: boolean,result:string): string{
    switch (keyCode) {
      case KeyCode.KEYCODE_0:
        result = '0';
        if (isShfitPressed) {
          result = ')';
        }
        break;
      case KeyCode.KEYCODE_1:
        result = '1';
        if (isShfitPressed) {
          result = '!';
        }
        break;
      case KeyCode.KEYCODE_2:
        result = '2';
        if (isShfitPressed) {
          result = '√(';
        }
        break;
      case KeyCode.KEYCODE_5:
        result = '5';
        if (isShfitPressed) {
          result = '%';
        }
        break;
      case KeyCode.KEYCODE_6:
        result = '6';
        if (isShfitPressed) {
          result = '^';
        }
        break;
      case KeyCode.KEYCODE_8:
        result = '8';
        if (isShfitPressed) {
          result = '×';
        }
        break;
      case KeyCode.KEYCODE_9:
        result = '9';
        if (isShfitPressed) {
          result = '(';
        }
        break;
      default :
        if (keyCode >= KeyCode.KEYCODE_0 && keyCode <= KeyCode.KEYCODE_9) {
          result = (keyCode - KeyCode.KEYCODE_0).toString();
        }
        break;
    }
    return result;
  }

  public static keyForAction(keyCode: number, isShfitPressed: boolean,result:string):string{
    switch (keyCode) {
      case KeyCode.KEYCODE_DEL:
        result = '';
        break;
      case KeyCode.KEYCODE_FORWARD_DEL:
        result = 'C';
        break;
      case KeyCode.KEYCODE_NUMPAD_DIVIDE:
      case KeyCode.KEYCODE_SLASH:
        result = '÷';
        break;
      case KeyCode.KEYCODE_NUMPAD_MULTIPLY:
        result = '×';
        break;
      case KeyCode.KEYCODE_NUMPAD_SUBTRACT:
      case KeyCode.KEYCODE_MINUS:
        result = '-';
        break;
      case KeyCode.KEYCODE_NUMPAD_ADD:
      case KeyCode.KEYCODE_PLUS:
        result = '+';
        break;
      case KeyCode.KEYCODE_NUMPAD_DOT:
      case KeyCode.KEYCODE_PERIOD:
        result = '.';
        break;
      case KeyCode.KEYCODE_EQUALS:
        result = '=';
        if (isShfitPressed) {
          result = '+';
        }
        break;
      case KeyCode.KEYCODE_NUMPAD_ENTER:
      case KeyCode.KEYCODE_NUMPAD_EQUALS:
      case KeyCode.KEYCODE_NUMPAD_LEFT_PAREN:
        result = '(';
        break;
      case KeyCode.KEYCODE_NUMPAD_RIGHT_PAREN:
        result = ')';
        break;
      default :
        break;
    }
    return result;
  }
  public static KeyForSpecialString(keyCode: number, isShfitPressed: boolean,result:string): string {
    switch (keyCode) {
      case KeyCode.KEYCODE_S:
        result = 'sin(';
        if (isShfitPressed) {
          result = 'sin\u207B\u00B9(';
        }
        break;
      case KeyCode.KEYCODE_Q:
        result = '^(2)';
        break;
      case KeyCode.KEYCODE_R:
        result = '^(-1)';
        break;
      case KeyCode.KEYCODE_T:
        result = 'tan(';
        if (isShfitPressed) {
          result = 'tan\u207B\u00B9(';
        }
        break;
      case KeyCode.KEYCODE_Y:
        result = '^(';
        if (isShfitPressed) {
          result = '^(1÷';
        }
        break;
      case KeyCode.KEYCODE_O:
        result = 'cos(';
        if (isShfitPressed) {
          result = 'cos\u207B\u00B9(';
        }
        break;
      case KeyCode.KEYCODE_P:
        result = 'π';
        break;
      case KeyCode.KEYCODE_L:
        result = 'log(';
        break;
      case KeyCode.KEYCODE_N:
        result = 'ln(';
        break;
      default :
        break;
    }
    return result;
  }
  /**
   * 重新定义用户输入的字符
   *
   * @param keyCode 用户输入的字符code
   * @param isShfitPressed 是否按shift
   * @return 重定义的字符
   */
  public static keyForString(keyCode: number, isShfitPressed: boolean): string {
    let result: string = 'error';
    if (keyCode >= KeyCode.KEYCODE_NUMPAD_0 && keyCode <= KeyCode.KEYCODE_NUMPAD_9) {
      result = (keyCode - KeyCode.KEYCODE_NUMPAD_0).toString();
      return result;
    }
    result = this.keyForNumber(keyCode, isShfitPressed, result);
    result = this.keyForAction(keyCode, isShfitPressed, result);
    result = this.KeyForSpecialString(keyCode, isShfitPressed, result);
    return result;
  }

  /**
   * 重新定义用户输入的字符包含回车键
   *
   * @param keyCode 用户输入的字符code
   * @param isShfitPressed 是否按shift
   * @return 重定义的字符
   */
  public static keyToString(keyCode: number, isShfitPressed: boolean): string {
    if (keyCode === KeyCode.KEYCODE_ENTER) {
      return '=';
    } else {
      return this.keyForString(keyCode, isShfitPressed);
    }
  }
}