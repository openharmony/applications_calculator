// Script for compiling build behavior. It is built in the build plug-in and cannot be modified currently.

import { getHvigorNode, hvigor } from '@ohos/hvigor';
import { hapTasks } from '@ohos/hvigor-ohos-plugin';
import * as path from 'path';
import fs from 'fs';
import { executeOnlineSign } from '../../hw_sign/sign.js';
// import { initTesting } from '@ohos/hypium-plugin';

const mModule = getHvigorNode(__filename);
const ohosPlugin = hapTasks(mModule);

const onlineSignHapTaskName = 'onlineSignHap';
let curTargetName = 'default';
const mModuleName = mModule.getName();
const projectRootPath = process.cwd();

// 若是feature模块签名，此处填写依赖的entry模块名称
const entryName = '';

ohosPlugin.getNeedExecTargetServiceList().forEach(targetServices => {
  curTargetName = targetServices.getTargetData().getTargetName();

  // 注册在线签名任务和创建任务依赖
  // const onlineSignTask = mModule.task(() => {
  //   // 构建的未签名的hap的输出根目录
  //   const moduleBuildOutputDir = path.resolve(projectRootPath, 'product/', mModuleName, 'build/default/outputs/default/');
  //   // 未签名的hap包路径
  //   const inputFile = path.resolve(moduleBuildOutputDir, `${mModuleName}${entryName ? '-' + entryName : ''}-default-unsigned.hap`);
  //   // 签名后的hap包路径
  //   const outputFile = path.resolve(moduleBuildOutputDir, `${mModuleName}${entryName ? '-' + entryName : ''}-default-signed.hap`);
  //   // 执行在线签名
  //   executeOnlineSign(inputFile, outputFile);
  //
  //   // 构建的未签名的ohosTest包的输出根目录
  //   const moduleBuildOhTestOutputDir = path.resolve(projectRootPath, 'product/', mModuleName, 'build/default/outputs/ohosTest/');
  //   // 未签名的ohosTest包路径
  //   const inputHapTestFile = path.resolve(moduleBuildOhTestOutputDir, `${mModuleName}${entryName ? '-' + entryName : ''}-ohosTest-unsigned.hap`);
  //   if (fs.existsSync(inputHapTestFile)) {
  //     // 签名后的ohosTest包路径
  //     const outputHapTestFile = path.resolve(moduleBuildOhTestOutputDir, `${mModuleName}${entryName ? '-' + entryName : ''}-ohosTest-signed.hap`);
  //     // 执行ohosTest包在线签名
  //     executeOnlineSign(inputHapTestFile, outputHapTestFile);
  //   }
  // }, onlineSignHapTaskName).dependsOn(`${curTargetName}@PackageHap`);
  //
  // // 使用在线签名,可以把离线签名任务disable掉
  // if (onlineSignTask.getEnabled()) {
  //   mModule.getTaskByName(`${curTargetName}@SignHap`).setEnabled(false);
  // }
  mModule.getTaskByName(`${curTargetName}@SignHap`).setEnabled(true);
});

// 将在线签名任务挂接在assembleHap任务上,如果需要在IDE上使用,assembleHap任务是固定的
// mModule.getTaskByName('assembleHap').dependsOn(onlineSignHapTaskName);
const config = {
  hvigor: hvigor,
  packageConfig: {
    appName: 'Calculator', // 与cde架构定义的模块名相同，每个模块流水线归档的hap名，不填默认是module.json5定的模块名
    commandParams: hvigor.getExtraConfig(), // hvigor 命令行参数
    module: mModule, // 当前模块对象,
    entryName: '', // 若是feature模块签名，此处填写依赖的entry模块名称
  },
};

// initTesting(config);

module.exports = {
  ohos: ohosPlugin
}