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

import worker from '@ohos.worker';
import { GlobalThisHelper } from '@hmos/common';
import { Evaluator } from './Evaluator';
import { PhysicsButtonInfo } from '../info/PhysicsButtonInfo';
import { SimplePhysicsButtonInfo } from '../info/PhysicsButtonInfo';
import DigitPanelModel from '../model/DigitPanelModel';

const TAG: string = 'DigitPanelController';

/**
 * digit panel model
 *
 * @since 2023-02-13
 */
export class DigitPanelController {
  private static instance: DigitPanelController;
  private digitPanelModel: DigitPanelModel = DigitPanelModel.getInstance();
  private evaluator: Evaluator | null = null;
  private worker: worker.ThreadWorker = GlobalThisHelper.get<worker.ThreadWorker>('workerInstance');

  /**
   * get digitPanelModel
   *
   * @return DigitPanelModel
   */
  private getDigitPanelModel(): DigitPanelModel {
    return this.digitPanelModel;
  }

  /**
   * get worker
   *
   * @return object worker.ThreadWorker
   */
  public getWorker(): worker.ThreadWorker {
    return this.worker;
  }

  /**
   * 获取Evaluator
   *
   * returns Evaluator.
   */
  public getEvaluator(): Evaluator {
    if (this.evaluator === null) {
      this.evaluator = new Evaluator(this.worker);
    }
    return this.evaluator;
  }
  public SetEvaluator(evaluator: Evaluator):void{
    this.evaluator = evaluator
  }

  /**
   * set worker
   *
   * @param worker worker.ThreadWorker
   */
  public setWorker(worker: worker.ThreadWorker): void {
    this.worker = worker;
    this.evaluator = new Evaluator(this.worker);
  }

  /**
   * handleInput
   *
   * @param value PhysicsButtonInfo
   * @param callBack Function
   */
  public handleInput(callBack: Function, value?: PhysicsButtonInfo, keyValue?: string): void {
    if (this.evaluator !== null) {
      this.evaluator.addExpression(callBack, value, keyValue);
    }
  }

  /**
   * single instance
   *
   * @return instance
   */
  public static getInstance(): DigitPanelController {
    if (DigitPanelController.instance == null) {
      DigitPanelController.instance = new DigitPanelController();
    }
    return DigitPanelController.instance;
  }

  /**
   * getStandLists
   *
   * @return Array<Array<SimplePhysicsButtonInfo>>
   */
  public getStandLists(): Array<Array<SimplePhysicsButtonInfo>> {
    return this.digitPanelModel.getStandLists();
  }

  /**
   * get science button list
   *
   * @return Array<Array<SimplePhysicsButtonInfo>> science button list
   */
  public getScienceLists(): Array<Array<SimplePhysicsButtonInfo>> {
    return this.digitPanelModel.getScienceLists();
  }

  /**
   * updateMemoryDisplay
   *
   * @param value PhysicsButtonInfo
   * @param callBack PhysicsButtonInfo
   */
  public updateMemoryDisplay(value: PhysicsButtonInfo, callBack: Function): void {
    if (this.evaluator !== null) {
      this.evaluator.updateMemoryDisplay(value, callBack);
    }
  }

  /**
   * getMemoryDisplay
   *
   * @return true/false
   */
  public async getMemoryDisplay(): Promise<boolean> {
    if (this.evaluator !== null) {
      return await this.evaluator.getMemoryDisplay();
    } else {
      return false;
    }
  }
}