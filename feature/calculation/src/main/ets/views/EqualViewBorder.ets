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

/**
 * Set the rounded border for the equals sign
 *
 * @since 2023-11-07
 */
@Component
export struct EqualViewBorder {
  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);
  radius: number = 0;
  lineWidth: number = 1;

  build() {
    Canvas(this.context)
      .width('100%')
      .height('100%')
      .onReady(() => {
        this.context.beginPath();
        let x = this.lineWidth / 2.0;
        let y = this.lineWidth / 2.0;
        let w = this.context.width - this.lineWidth;
        let h = this.context.height - this.lineWidth;
        let r = this.radius;
        r = Math.min(r, w / 2, h / 2);
        this.context.moveTo(x + r, y);
        this.context.arcTo(x + w, y, x + w, y + h, r);
        this.context.arcTo(x + w, y + h, x, y + h, r);
        this.context.arcTo(x, y + h, x, y, r);
        this.context.arcTo(x, y, x + w, y, r);
        this.context.closePath();
        let grad = this.context.createLinearGradient(0, y, 0, y + h);
        grad.addColorStop(0.0, '#45ffffff');
        grad.addColorStop(1.0, '#14ffffff');
        this.context.strokeStyle = grad;
        this.context.lineWidth = this.lineWidth;
        this.context.stroke();
      })
  }
}