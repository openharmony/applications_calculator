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

import {
  describe,
  beforeAll,
  beforeEach,
  afterEach,
  afterAll,
  it,
  expect,
} from '@ohos/hypium';
import { CommonUtil } from '@hmos/common';

/**
 * CommonUtil testcase
 *
 * @since 2023-12-02
 */
export default function CommonUtilTest() {
  describe('CommonUtilTest', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })

    /**
     * @tc.number: checkIfDeviceIsPhone_001
     * @tc.name: 判断当前设备是否为手机
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否为手机，应该返回true
     */
    it('checkIfDeviceIsPhone_001', 0, () => {
      const isPhone: boolean = CommonUtil.checkIfDeviceIsPhone();
      expect(isPhone).assertTrue();
    });

    /**
     * @tc.number: checkIfDeviceIsPC_001
     * @tc.name: 判断当前设备是否为PC
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否为PC，应该返回false
     */
    it('checkIfDeviceIsPC_001', 0, () => {
      const isPC: boolean = CommonUtil.checkIfDeviceIsPC();
      expect(isPC).assertFalse();
    });

    /**
     * @tc.number: checkIfDeviceIsTablet_001
     * @tc.name: 判断当前设备是否为平板
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否为平板，应该返回false
     */
    it('checkIfDeviceIsTablet_001', 0, () => {
      const isTablet: boolean = CommonUtil.checkIfDeviceIsTablet();
      expect(isTablet).assertFalse();
    });

    /**
     * @tc.number: checkIfDeviceIsFold_001
     * @tc.name: 判断当前设备是否为折叠屏
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否为折叠屏，应该返回false
     */
    it('checkIfDeviceIsFold_001', 0, () => {
      const isFold: boolean = CommonUtil.checkIfDeviceIsFold();
      expect(isFold).assertFalse();
    });

    /**
     * @tc.number: checkFoldIsExpanded_001
     * @tc.name: 判断当前设备是否为折叠屏-展开态
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否为折叠屏-展开态，应该返回false
     */
    it('checkFoldIsExpanded_001', 0, () => {
      const isExpanded: boolean = CommonUtil.checkFoldIsExpanded();
      expect(isExpanded).assertFalse();
    });

    /**
     * @tc.number: checkFoldIsFolded_001
     * @tc.name: 判断当前设备是否为折叠屏-折叠态
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否为折叠屏-折叠态，应该返回false
     */
    it('checkFoldIsFolded_001', 0, () => {
      const isFolded: boolean = CommonUtil.checkFoldIsFolded();
      expect(isFolded).assertFalse();
    });

    /**
     * @tc.number: checkFoldIsHalfFolded_001
     * @tc.name: 判断当前设备是否为折叠屏-半折叠态
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否为折叠屏-半折叠态，应该返回false
     */
    it('checkFoldIsHalfFolded_001', 0, () => {
      const isHalfFolded: boolean = CommonUtil.checkFoldIsHalfFolded();
      expect(isHalfFolded).assertFalse();
    });

    /**
     * @tc.number: isLandSpace_001
     * @tc.name: 判断当前是否是横屏
     * @tc.type: 0
     * @tc.desc: 判断当前设备是否是横屏，应该返回false
     */
    it('isLandSpace_001', 0, () => {
      let isLandSpace: boolean = CommonUtil.isLandSpace();
      expect(isLandSpace).assertFalse();
    });

    /**
     * @tc.number: getCurBp_001
     * @tc.name: 获取当前BREAKPOINT
     * @tc.type: 0
     * @tc.desc: 获取当前BREAKPOINT,预期值为'sm_md'
     */
    it('getCurBp_001', 0, () => {
      let curBp: string = CommonUtil.getCurBp();
      expect(curBp).assertEqual('sm_md');
    });

    /**
     * @tc.number: getDisPlayWidth_001
     * @tc.name: 获取当前屏幕的宽度
     * @tc.type: 0
     * @tc.desc: 测试机为noh，宽度应该为384vp
     */
    it('getDisPlayWidth_001', 0, () => {
      let disPlayWidth: number = CommonUtil.getDisPlayWidth();
      expect(disPlayWidth).assertEqual(384);
    });

    /**
     * @tc.number: getWindowWidth_001
     * @tc.name: 获取当前窗口的宽度
     * @tc.type: 0
     * @tc.desc: 测试机为noh，宽度应该为384vp
     */
    it('getWindowWidth_001', 0, () => {
      let windowWidth: number = CommonUtil.getWindowWidth();
      expect(windowWidth).assertEqual(384);
    });

    /**
     * @tc.number: getContentWidth_001
     * @tc.name: 获取当前内容窗口的宽度
     * @tc.type: 0
     * @tc.desc: 测试机为noh，宽度应该为384vp
     */
    it('getContentWidth_001', 0, () => {
      let contentWidth: number = CommonUtil.getContentWidth();
      expect(contentWidth).assertEqual(384);
    });

    /**
     * @tc.number: getDisplayExp
     * @tc.name: 将表达式转换为显示的表达式
     * @tc.type: 0
     * @tc.desc: 测试表达式转换符合预期
     */
    it('getDisplayExp_equal', 0, () => {
      let displayExp: string = CommonUtil.getDisplayExp('123456');
      expect(displayExp).assertEqual('123,456');
    });

    /**
     * @tc.number: displayIndexToExpIndex
     * @tc.name: 将表达式的光标位置转换为显示的表达式的光标位置
     * @tc.type: 0
     * @tc.desc: 测试光标位置转换是否符合预期
     */
    it('displayIndexToExpIndex', 0, () => {
      let expIndex: number = CommonUtil.displayIndexToExpIndex('123,456', 2);
      expect(expIndex).assertEqual(2);
    });

    /**
     * @tc.number: displayIndexToExpIndex
     * @tc.name: 将表达式的光标位置转换为显示的表达式的光标位置
     * @tc.type: 0
     * @tc.desc: 测试光标位置转换是否符合预期
     */
    it('displayIndexToExpIndex_01', 0, () => {
      let expIndex: number = CommonUtil.displayIndexToExpIndex('123,456', 5);
      expect(expIndex).assertEqual(4);
    });

    /**
     * @tc.number: expIndexToDisplayIndex
     * @tc.name: 将显示的表达式的光标位置转换为显示的表达式的光标位置
     * @tc.type: 0
     * @tc.desc: 试光标位置转换是否符合预期
     */
    it('expIndexToDisplayIndex', 0, () => {
      let expIndex: number = CommonUtil.expIndexToDisplayIndex('123456', 3);
      expect(expIndex).assertEqual(4);
    });

    it('expIndexToDisplayIndex_01', 0, () => {
      let expIndex: number = CommonUtil.expIndexToDisplayIndex('1234567',4);
      expect(expIndex).assertEqual(5);
    });
  })

  /**
   * @tc.number: getSpecialIndex
   * @tc.name: 如果在特殊字符串里粘贴数字，将光标位置重新计算
   * @tc.type: 0
   * @tc.desc: 光标位置是否符合预期
   */
  it('getSpecialIndex', 0, () => {
    let expIndex: number = CommonUtil.getSpecialIndex(2, 'sin(12');
    expect(expIndex).assertEqual(4);
  });
   //add
  it('setContentWidth_001', 0, () => {
    CommonUtil.setContentWidth();
  });

  it('getCurrentBreakpoint_001', 0, () => {
    const  getCurrentBreakpoint: number= CommonUtil.getCurrentBreakpoint(840);
    expect(getCurrentBreakpoint).assertEqual(BREAKPOINT_LG);
  });
  it('getCurrentBreakpoint_001', 0, () => {
    let arr: string [] =[1,'.',2,3,'+',4,5,6,7,8]

    const  getCurrentBreakpoint: number= CommonUtil.splitNumber(arr,5);
    expect(getCurrentBreakpoint).assertEqual(BREAKPOINT_LG);
  });

  it('getCurrentBreakpoint_002', 0, () => {
    const  getCurrentBreakpoint: number= CommonUtil.getCurrentBreakpoint(520);
    expect(getCurrentBreakpoint).assertEqual(BREAKPOINT_MD);
  });

  it('getCurrentBreakpoint_003', 0, () => {
    const  getCurrentBreakpoint: number= CommonUtil.getCurrentBreakpoint(320);
    expect(getCurrentBreakpoint).assertEqual(BREAKPOINT_SM);
  });

  it('getCurrentBreakpoint_004', 0, () => {
    const  getCurrentBreakpoint: number= CommonUtil.getCurrentBreakpoint(200);
    expect(getCurrentBreakpoint).assertEqual(BREAKPOINT_XS);
  });

  it('splitNunber',0,() => {
    expect(CommonUtil.splitNumber(['123','656','789'],1)).assertEqual('123456789');
    expect(CommonUtil.splitNumber(['-123','656','789'],0)).assertEqual('-123456789');
    expect(CommonUtil.splitNumber(['123','656','789'],2)).assertEqual('123456789');
    expect(CommonUtil.splitNumber(['.23','.'],0)).assertEqual('23.');
    expect(CommonUtil.splitNumber(['.','1.23-'],1)).assertEqual('.1.23-');
    expect(CommonUtil.splitNumber(['.','1.23-'],2)).assertEqual('1.23-');
    expect(CommonUtil.splitNumber(['.1'],0)).assertEqual('.1');
    expect(CommonUtil.splitNumber(['1','-.2'],1)).assertEqual('1-.2');
    expect(CommonUtil.splitNumber(['1-2','.','3'],0)).assertEqual('1-2.3');
    expect(CommonUtil.splitNumber(['10-2','3'],0)).assertEqual('1-23');
    expect(CommonUtil.splitNumber(['1','03'],1)).assertEqual('103');
    expect(CommonUtil.splitNumber(['.','2','3','+','-log('],4)).assertEqual('.23-log(');
    expect(CommonUtil.splitNumber(['-0.10.12312323123'],0)).assertEqual('-0.1012312323123');
    expect(CommonUtil.splitNumber(['00000000000000'],0)).assertEqual('0');
    expect(CommonUtil.splitNumber(['00000000000000','123'],0)).assertEqual('123');
    expect(CommonUtil.splitNumber(['-00000000000000','123'],0)).assertEqual('-123');
    expect(CommonUtil.splitNumber(['-','.','1','-.123','2','3','1'],3)).assertEqual('-.1-.123231');
    expect(CommonUtil.splitNumber(['0','0','1','123','0','0','0'],3)).assertEqual('1123000');
    expect(CommonUtil.splitNumber(['.123','123'],1)).assertEqual('.123123');
    expect(CommonUtil.getTrueIndex(4,'')).assertEqual(4);
    expect(CommonUtil.getTrueIndex(5,'123cos(1')).assertEqual(7);
    expect(CommonUtil.getTrueIndex(5,'12345123')).assertEqual(5);
    AppStorage.set('globalExpression','123cos(1213+123123)+123%');
    AppStorage.setOrCreate('textInputIndex', 5);
    expect(CommonUtil.setFinalTextInputIndex("123123",5,'3cos(1)+')).assertEqual(15);
    expect(CommonUtil.isPastePressed("123123",'cut')).assertTrue();
    expect(CommonUtil.isPastePressed("123123",'cuts')).assertFalse();
    AppStorage.set('globalExpression','123cos(1213+123123)+123%');
    expect(CommonUtil.checkPastePressed(true)).assertTrue();
    AppStorage.set('globalExpression','');
    expect(CommonUtil.checkPastePressed(true)).assertFalse();
  })
    
  it('getNumberFromAppStorage_001', 0, () => {
    const  getNumberFromAppStorage: number= CommonUtil.getNumberFromAppStorage(undefined);
    expect(getNumberFromAppStorage).assertEqual(0);
  });

  it('getNumberFromAppStorage_002', 0, () => {
    const  getNumberFromAppStorage: number= CommonUtil.getNumberFromAppStorage("001");
    expect(getNumberFromAppStorage).assertEqual(AppStorage.get<number>("001"));
  });

  it('getDisplayExp_001', 0, () => {
    const  getDisplayExp: number= CommonUtil.getDisplayExp("001");
    const  getDisplayExp: number= CommonUtil.getDisplayExp("001");
    expect(getDisplayExp).assertEqual(DisplayUtil.formatAddSeparator("001"));
  });

  it('getDisplayExp_001', 0, () => {
    const  getDisplayExp: number= CommonUtil.getDisplayExp("001");
    expect(getDisplayExp).assertEqual(DisplayUtil.formatAddSeparator("001"));
  });

  it('checkIfDeviceIsStandPhone_001', 0, () => {
    const  getDisplayExp: number= CommonUtil.getDisplayExp("001");
    expect(getDisplayExp).assertEqual(DisplayUtil.formatAddSeparator("001"));
  });

  it('updateWindowSize_001', 0, () => {
    const  getDisplayExp: number= CommonUtil.updateWindowSize(800);
  });
}