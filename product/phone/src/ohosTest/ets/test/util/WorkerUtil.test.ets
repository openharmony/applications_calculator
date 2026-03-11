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

import { describe, it, expect } from '@ohos/hypium';
import { WorkerUtil } from '@hmos/common';
import { create, all, BigNumber } from 'mathjs';
/**
 * WorkerUtil testcase
 *
 * @since 2024-06-25
 */
export default function WorkerUtilTest() {

  describe('WorkerUtilTest', () => {

    it('setSinValue_001', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setSinValue(MATH.bignumber(30),MATH.bignumber(20), MATH);
      expect(char).assertEqual('0.5');
    });

    it('setSinValue_002', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setSinValue(MATH.bignumber(150),MATH.bignumber(20), MATH);
      expect(char).assertEqual('0.5');
    });

    it('setSinValue_003', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setSinValue(MATH.bignumber(330),MATH.bignumber(20), MATH);
      expect(char).assertEqual('0.5');
    });

    it('setSinValue_004', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setSinValue(MATH.bignumber(180),MATH.bignumber(20), MATH);
      expect(char).assertEqual('0');
    });

    it('setSinValue_005', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setSinValue(MATH.bignumber(1),MATH.bignumber(20), MATH);
      expect(char).assertEqual('20');
    });

    it('setCosValue_001', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setCosValue(MATH.bignumber(60),MATH.bignumber(20), MATH);
      expect(char).assertEqual('0.5');
    });

    it('setCosValue_002', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setCosValue(MATH.bignumber(300),MATH.bignumber(20), MATH);
      expect(char).assertEqual('0.5');
    });

    it('setCosValue_003', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setCosValue(MATH.bignumber(240),MATH.bignumber(20), MATH);
      expect(char).assertEqual('-0.5');
    });

    it('setCosValue_004', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setCosValue(MATH.bignumber(90),MATH.bignumber(20), MATH);
      expect(char).assertEqual('0');
    });

    it('setCosValue_005', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setCosValue(MATH.bignumber(270),MATH.bignumber(20), MATH);
      expect(char).assertEqual('0');
    });

    it('setCosValue_006', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setCosValue(MATH.bignumber(1),MATH.bignumber(20), MATH);
      expect(char).assertEqual('20');
    });

    it('setTanValue_001', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setTanValue(MATH.bignumber(45),MATH.bignumber(20), MATH);
      expect(char).assertEqual('1');
    });

    it('setTanValue_002', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setTanValue(MATH.bignumber(135),MATH.bignumber(20), MATH);
      expect(char).assertEqual('-1');
    });

    it('setTanValue_003', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setTanValue(MATH.bignumber(0),MATH.bignumber(20), MATH);
      expect(char).assertEqual('0');
    });

    it('setTanValue_004', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setTanValue(MATH.bignumber(90),MATH.bignumber(20), MATH);
      expect(char).assertEqual(MATH.bignumber(Infinity));
    });

    it('setTanValue_005', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setTanValue(MATH.bignumber(1),MATH.bignumber(20), MATH);
      expect(char).assertEqual('20');
    });

    it('setSpecialValue_001', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setSpecialValue(MATH.bignumber(1),MATH.bignumber(20),'cos', MATH);
      expect(char).assertEqual('20');
    });
    it('setSpecialValue_002', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setSpecialValue(MATH.bignumber(1),MATH.bignumber(20),'sin', MATH);
      expect(char).assertEqual('20');
    });
    it('setSpecialValue_003', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setSpecialValue(MATH.bignumber(1),MATH.bignumber(20),'tan', MATH);
      expect(char).assertEqual('20');
    });

    it('setSpecialValue_004', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setSpecialValue(MATH.bignumber(1),MATH.bignumber(20),'acos', MATH);
      expect(char).assertEqual(20);
    });

    it('setSpecialValueRad_001', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setSpecialValueRad(MATH.bignumber(MATH.pi / 2),MATH.bignumber(20),'cos', MATH);
      expect(char).assertEqual(0);
    });

    it('setSpecialValueRad_002', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setSpecialValueRad(MATH.bignumber(123),MATH.bignumber(20),'cos', MATH);
      expect(char).assertEqual(20);
    });

    it('setCosValueRad_001', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setCosValueRad(MATH.bignumber(MATH.pi / 2),MATH.bignumber(20), MATH);
      expect(char).assertEqual(0);
    });

    it('setCosValueRad_002', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.setCosValueRad(MATH.bignumber(123),MATH.bignumber(20), MATH);
      expect(char).assertEqual(20);
    });

    it('getSpecialValue2_001', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.getSpecialValue2(MATH.bignumber(0.5),'asin',20, MATH);
      expect(char).assertEqual(30);
    });

    it('getSpecialValue2_002', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.getSpecialValue2(MATH.bignumber(-0.5),'asin',20, MATH);
      expect(char).assertEqual(-30);
    });

    it('getSpecialValue2_003', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.getSpecialValue2(MATH.bignumber(1),'asin',20, MATH);
      expect(char).assertEqual(MATH.bignumber(20 / 2 / Math.PI * 360));
    });

    it('getSpecialValue2_004', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.getSpecialValue2(MATH.bignumber(0.5),'acos',20, MATH);
      expect(char).assertEqual(60);
    });

    it('getSpecialValue2_005', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.getSpecialValue2(MATH.bignumber(-0.5),'acos',20, MATH);
      expect(char).assertEqual(120);
    });

    it('getSpecialValue2_006', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.getSpecialValue2(MATH.bignumber(1),'acos',20, MATH);
      expect(char).assertEqual(MATH.bignumber(20 / 2 / Math.PI * 360));
    });

    it('getSpecialValue2_007', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: BigNumber = WorkerUtil.getSpecialValue2(MATH.bignumber(1),'atan',20, MATH);
      expect(char).assertEqual(MATH.bignumber(20 / 2 / Math.PI * 360));
    });

    it('WorkerUtilTest_001', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: string = WorkerUtil.calculate('1+1', MATH);
      expect(char).assertEqual('2');
    });

    it('WorkerUtilTest_002', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: string = WorkerUtil.calculate('1+1', MATH);
      expect(char).assertEqual('2');
    });

    it('WorkerUtilTest_003', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: string = WorkerUtil.calculate('1+1+', MATH);
      expect(char).assertEqual('2');
    });

    it('WorkerUtilTest_004', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: string = WorkerUtil.calculate('1++1+', MATH);
      expect(char).assertEqual('error');
    });

    it('WorkerUtilTest_005', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: string = WorkerUtil.calculate('1++1+', MATH);
      expect(char).assertEqual('error');
    });

    it('WorkerUtilTest_005', 0, () => {
      const MATH: math.MathJsStatic = create(all);
      let char: string = WorkerUtil.calculate('cos(1×0÷1+√3+π)+log(1)+ln(1)+sin⁻¹(1)+cos⁻¹(1)+tan⁻¹(1)+i', MATH);
      expect(char).assertEqual('error');
    });

    it('getPercent_001', 0, () => {
      let char: string = WorkerUtil.getPercent('50+50%%');
      expect(char).assertEqual('50+50/100*%');
    });

    it('isAddAfterAllOperator_001', 0, () => {
      let char: Boolean = WorkerUtil.isAddAfterAllOperator('50+-++50');
      expect(char).assertTrue()
    });

    it('isAddAfterAllOperator_002', 0, () => {
      let char: Boolean = WorkerUtil.isAddAfterAllOperator('1+1');
      expect(char).assertFalse()
    });

    it('resultEXP_001', 0, () => {
      let char: string = WorkerUtil.resultEXP('cos(50+50)+sin(90');
      expect(char).assertEqual('cos(50+50)+sin(90)');
    });

    it('resultEXP_002', 0, () => {
      let char: string = WorkerUtil.resultEXP('1+1');
      expect(char).assertEqual('1+1');
    });

    it('limitResult_001', 0, () => {
      let char: string = WorkerUtil.limitResult('0.51e+12');
      expect(char).assertEqual('0.51E12');
    });

    it('limitResult_002', 0, () => {
      let char: string = WorkerUtil.limitResult('0.51e-12');
      expect(char).assertEqual('0.51E-12');
    });

    it('limitResult_003', 0, () => {
      let char: string = WorkerUtil.limitResult('10123123e+12');
      expect(char).assertEqual('10123123E12');
    });

    it('limitResult_004', 0, () => {
      let char: string = WorkerUtil.limitResult('1012321e-12');
      expect(char).assertEqual('1012321E-12');
    });

    it('limitResult_005', 0, () => {
      let char: string = WorkerUtil.limitResult('0.51231232131231231231232131232131');
      expect(char).assertEqual('0.5123123213123123');
    });

    it('limitResult_006', 0, () => {
      let char: string = WorkerUtil.limitResult('0.51231232131231231e+21231');
      expect(char).assertEqual('error');
    });

    it('limitResult_007', 0, () => {
      let char: string = WorkerUtil.limitResult('0.51231232131231231e+12');
      expect(char).assertEqual('error');
    });

    it('limitResult_008', 0, () => {
      let char: string = WorkerUtil.limitResult('1');
      expect(char).assertEqual('1');
    });

  })
}