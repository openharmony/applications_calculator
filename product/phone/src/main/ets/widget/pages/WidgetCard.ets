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

@Entry
@Component
struct WidgetCard {
  /*
   * The title.
   */
  readonly TITLE: string = 'Hello World';

  /*
   * The action type.
   */
  readonly ACTION_TYPE: string = 'router';

  /*
   * The ability name.
   */
  readonly ABILITY_NAME: string = 'CalculatorAbility';

  /*
   * The target page.
   */
  readonly TARGET_PAGE: string = 'funA';

  /*
   * The message.
   */
  readonly MESSAGE: string = 'add detail';

  /*
   * The width percentage setting.
   */
  readonly FULL_WIDTH_PERCENT: string = '100%';

  /*
   * The height percentage setting.
   */
  readonly FULL_HEIGHT_PERCENT: string = '100%';

  /*
   * The background blur style.
   */
  readonly BLUR_STYLE: number = 0.3;

  @Builder
  buildClockDetail(): void {
    Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center, direction: FlexDirection.Column }) {
      Image($r('app.media.ic_form_card'))
        .width($r('app.float.card_calculator_picture_width'))
        .height($r('app.float.card_calculator_picture_height'))
    }
    .width(this.FULL_WIDTH_PERCENT)
    .height(this.FULL_HEIGHT_PERCENT)
  }

  build() {
    Row() {
      this.buildClockDetail()
    }
    .width(this.FULL_WIDTH_PERCENT)
    .height(this.FULL_HEIGHT_PERCENT)
    .backgroundBlurStyle(this.BLUR_STYLE)
    .backgroundColor($r('app.color.card_background_color'))
    .onClick(() => {
      postCardAction(this, {
        action: this.ACTION_TYPE,
        abilityName: this.ABILITY_NAME,
        params: {
          targetPage: this.TARGET_PAGE
        }
      });
    })
  }
}