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
import { describe, it, expect } from '@ohos/hypium';
import { InputUtil } from '@hmos/common';

/**
 * InputUtil testcase
 *
 * @since 2024-02-21
 */
export default function InputUtilTest() {
  describe('InputUtilTest', () => {
    it('InputUtilTest_001', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_DEL, false);
      expect(char).assertEqual('');
    });

    it('InputUtilTest_002', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_DEL, true);
      expect(char).assertEqual('');
    });

    it('InputUtilTest_003', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_DIVIDE, false);
      expect(char).assertEqual('÷');
    });

    it('InputUtilTest_004', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_DIVIDE, true);
      expect(char).assertEqual('÷');
    });

    it('InputUtilTest_005', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_SLASH, false);
      expect(char).assertEqual('÷');
    });

    it('InputUtilTest_006', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_SLASH, true);
      expect(char).assertEqual('÷');
    });

    it('InputUtilTest_007', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_MULTIPLY, false);
      expect(char).assertEqual('×');
    });

    it('InputUtilTest_008', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_MULTIPLY, true);
      expect(char).assertEqual('×');
    });

    it('InputUtilTest_009', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_SUBTRACT, false);
      expect(char).assertEqual('-');
    });

    it('InputUtilTest_010', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_SUBTRACT, true);
      expect(char).assertEqual('-');
    });

    it('InputUtilTest_011', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_MINUS, false);
      expect(char).assertEqual('-');
    });

    it('InputUtilTest_012', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_MINUS, true);
      expect(char).assertEqual('-');
    });

    it('InputUtilTest_013', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_ADD, false);
      expect(char).assertEqual('+');
    });

    it('InputUtilTest_014', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_ADD, true);
      expect(char).assertEqual('+');
    });

    it('InputUtilTest_015', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_PLUS, false);
      expect(char).assertEqual('+');
    });

    it('InputUtilTest_016', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_PLUS, true);
      expect(char).assertEqual('+');
    });

    it('InputUtilTest_017', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_DOT, false);
      expect(char).assertEqual('.');
    });

    it('InputUtilTest_018', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_DOT, true);
      expect(char).assertEqual('.');
    });

    it('InputUtilTest_019', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_PERIOD, false);
      expect(char).assertEqual('.');
    });

    it('InputUtilTest_020', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_PERIOD, true);
      expect(char).assertEqual('.');
    });

    it('InputUtilTest_021', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_5, false);
      expect(char).assertEqual('5');
    });

    it('InputUtilTest_022', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_5, true);
      expect(char).assertEqual('%');
    });

    it('InputUtilTest_023', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_8, false);
      expect(char).assertEqual('8');
    });

    it('InputUtilTest_024', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_8, true);
      expect(char).assertEqual('×');
    });

    it('InputUtilTest_025', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_9, false);
      expect(char).assertEqual('9');
    });

    it('InputUtilTest_026', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_9, true);
      expect(char).assertEqual('(');
    });

    it('InputUtilTest_027', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_0, false);
      expect(char).assertEqual('0');
    });

    it('InputUtilTest_028', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_0, true);
      expect(char).assertEqual(')');
    });

    it('InputUtilTest_029', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_EQUALS, false);
      expect(char).assertEqual('=');
    });

    it('InputUtilTest_030', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_EQUALS, true);
      expect(char).assertEqual('+');
    });

    it('InputUtilTest_031', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_ENTER, false);
      expect(char).assertEqual('(');
    });

    it('InputUtilTest_032', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_ENTER, true);
      expect(char).assertEqual('(');
    });

    it('InputUtilTest_033', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_EQUALS, false);
      expect(char).assertEqual('(');
    });

    it('InputUtilTest_034', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_EQUALS, true);
      expect(char).assertEqual('(');
    });

    it('InputUtilTest_035', 0, () => {
      let char: string = InputUtil.keyToString(KeyCode.KEYCODE_ENTER, false);
      expect(char).assertEqual('=');
    });

    it('InputUtilTest_036', 0, () => {
      let char: string = InputUtil.keyToString(KeyCode.KEYCODE_ENTER, true);
      expect(char).assertEqual('=');
    });

    it('InputUtilTest_037', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_LEFT_PAREN, false);
      expect(char).assertEqual('(');
    });

    it('InputUtilTest_038', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_LEFT_PAREN, true);
      expect(char).assertEqual('(');
    });

    it('InputUtilTest_039', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_RIGHT_PAREN, false);
      expect(char).assertEqual(')');
    });

    it('InputUtilTest_040', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_RIGHT_PAREN, true);
      expect(char).assertEqual(')');
    });

    it('InputUtilTest_041', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_0, false);
      expect(char).assertEqual('0');
    });

    it('InputUtilTest_042', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_0, true);
      expect(char).assertEqual('0');
    });

    it('InputUtilTest_043', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_9, false);
      expect(char).assertEqual('9');
    });

    it('InputUtilTest_044', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_9, true);
      expect(char).assertEqual('9');
    });

    it('InputUtilTest_045', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_4, false);
      expect(char).assertEqual('4');
    });

    it('InputUtilTest_046', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUMPAD_4, true);
      expect(char).assertEqual('4');
    });

    it('InputUtilTest_047', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_0, false);
      expect(char).assertEqual('0');
    });

    it('InputUtilTest_048', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_0, true);
      expect(char).assertEqual(')');
    });

    it('InputUtilTest_049', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_9, false);
      expect(char).assertEqual('9');
    });

    it('InputUtilTest_050', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_9, true);
      expect(char).assertEqual('(');
    });

    it('InputUtilTest_051', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_5, false);
      expect(char).assertEqual('5');
    });

    it('InputUtilTest_052', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_5, true);
      expect(char).assertEqual('%');
    });

    it('InputUtilTest_053', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_4, false);
      expect(char).assertEqual('4');
    });

    it('InputUtilTest_054', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_4, true);
      expect(char).assertEqual('4');
    });

    it('InputUtilTest_055', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUM_LOCK, false);
      expect(char).assertEqual('error');
    });

    it('InputUtilTest_056', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_NUM_LOCK, true);
      expect(char).assertEqual('error');
    });

    it('InputUtilTest_057', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_UNKNOWN, false);
      expect(char).assertEqual('error');
    });

    it('InputUtilTest_058', 0, () => {
      let char: string = InputUtil.keyForString(KeyCode.KEYCODE_UNKNOWN, true);
      expect(char).assertEqual('error');
    });
  });
}