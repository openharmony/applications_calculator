// Script for compiling build behavior. It is built in the build plug-in and cannot be modified currently.

export { appTasks } from '@ohos/hvigor-ohos-plugin';

import { hvigor, getHvigorNode } from '@ohos/hvigor';
// import { uploadTestCases } from '@ohos/hypium-plugin';

const config = {
  hvigor: hvigor,
  hvigorNode: getHvigorNode(__filename),
  modulesConfig: [
    {
      moduleName: 'phone', // build-profile.json5
      templateEngName: 'CalculatorTask', // CDE任务模板中维护的模板英文名称
    },
    {
      moduleName: 'pc', // build-profile.json5
      templateEngName: 'CalculatorPcTask', // CDE任务模板中维护的模板英文名称
    }
  ]
};

// uploadTestCases(config); // 执行上述配置的模块测试，并上传对应的用例信息。 建议：本地编译测试该方法将注释掉，扫描工程文件会耗时。