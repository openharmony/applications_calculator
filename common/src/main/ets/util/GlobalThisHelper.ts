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

import { LogUtil } from './LogUtil';

const TAG: string = 'GlobalThisHelper';

/**
 * GlobalThisHelper
 *
 * @since 2023-9-11
 */
export class GlobalThisHelper {
  /**
   * 将变量value挂载到globalThis实例上
   *
   * @param key 要挂载的key
   * @param value 要挂载的value
   */
  public static set<T>(key: string, value: T): void {
    if (GlobalThisHelper.isEmptyString(key)) {
      LogUtil.error(TAG, 'The key is empty, return set!!');
      return;
    }
    globalThis[key] = value;
  }

  /**
   * 获取挂载到globalThis上的全局变量
   *
   * @param key 要挂载的key
   * @param defaultValue 默认值
   * @return 成功返回value，失败返回默认值，无默认值返回undefined
   */
  public static get<T>(key: string, defaultValue?: T): T {
    return GlobalThisHelper.isEmptyString(key) ? defaultValue : globalThis[key] as T ?? defaultValue;
  }

  /**
   * 判断是否是空串
   *
   * @param target 要判断的字符
   * @return 成功表示空串，失败表示非空串
   */
  public static isEmptyString(target: string): boolean {
    if (target === null || target === '') {
      return true;
    }
    return false;
  }

  /**
   * 删除挂载到globalThis上的全局变量
   *
   * @param key 挂载的key
   */
  public static remove(key: string): void {
    if (GlobalThisHelper.isEmptyString(key)) {
      LogUtil.error(TAG, 'The key is empty, return remove!!');
      return;
    }
    globalThis[key] = null;
  }
}