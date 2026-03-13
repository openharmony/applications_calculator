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

import worker from '@ohos.worker';
import { create, all, BigNumber } from 'mathjs';
import { WorkerUtil } from '@hmos/common/src/main/ets/util/WorkerUtil';
const MATH: math.MathJsStatic = create(all);
let replacements = {};
const config = {
  angles: 'deg' // 'rad', 'deg', 'grad'
};

// create trigonometric functions replacing the input depending on angle config
const fns1 = ['sin', 'cos', 'tan'];
fns1.forEach(function (name: string) {
  const fn = MATH[name]; // the original function
  const fnNumber = function (x: BigNumber): BigNumber {
    switch (config.angles) {
      case 'deg':
        const result = MATH.bignumber(fn(MATH.number(x) / 360 * 2 * Math.PI));
        return WorkerUtil.setSpecialValue(x, result, name, MATH);
      case 'grad':
        return MATH.bignumber(fn(MATH.number(x) / 400 * 2 * Math.PI));
      default:
        const resultRad: BigNumber = MATH.bignumber(fn(x));
        return WorkerUtil.setSpecialValueRad(x, resultRad, name, MATH);
    }
  };
  // create a typed-function which check the input types
  replacements[name] = MATH.typed(name, {
    'BigNumber': fnNumber,
    'Array | Matrix': function (x) {
      return MATH.map(x, fnNumber);
    }
  });
});


const fns2 = ['asin', 'acos', 'atan'];
fns2.forEach(function (name: string) {
  const fn = MATH[name];
  const fnNumber = function (x: BigNumber): BigNumber {
    const result = fn(MATH.number(x));
    if (typeof result === 'number') {
      switch (config.angles) {
        case 'deg':
          return WorkerUtil.getSpecialValue2(x, name, result, MATH);
        case 'grad':
          return MATH.bignumber(result / 2 / Math.PI * 400);
        default:
          return MATH.bignumber(result);
      }
    }
    return result;
  };
  replacements[name] = MATH.typed(name, {
    'BigNumber': fnNumber,
    'Array | Matrix': function (x) {
      return MATH.map(x, fnNumber);
    }
  });
});
//设置为bignumber保证除三角函数以外的可以精确计算
MATH.config({ number: 'BigNumber' });
// 将所有replacements自定义函数操作导入到 math.js中, 并且采用override方式覆盖原始三角函数操作
MATH.import(replacements, { 'override': true });

// create worker object
const workerPort = worker.workerPort;

// worker thread rece msg
workerPort.onmessage = (exp): void => {
  //添加角度模式判定
  const expData = exp.data.exp;
  const angles = exp.data.angles;
  if (typeof expData !== 'string' || typeof angles !== 'string') {
    return;
  }
  config.angles = angles;
  let res: string = WorkerUtil.calculate(expData, MATH);
  // worker thread post msg
  workerPort.postMessage({ exp: expData, result: res });
};

// worker thread error callback
workerPort.onerror = (err): void => {
};