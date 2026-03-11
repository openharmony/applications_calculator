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
 * LooseObject
 *
 * @since 2023-02-13
 */
export class LooseObject {
  public date?: string;
  public expression: string = '';
  public isDateVisible: boolean = false;
  public result: string = '';
  public time_stamp: number = -1;
  public id: string = '';
  public dbId: string = '';
  public history: Array<HistoryObject> = [];
}

export class HistoryObject {
  public expression: string = '';
  public result: string = '';
  public id: string = '';
  public isDateVisible: boolean = false;
}