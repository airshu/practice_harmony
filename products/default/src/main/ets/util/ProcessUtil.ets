import { process } from "@kit.ArkTS";
import systemDateTime from "@ohos.systemDateTime";
import TimeType from '@ohos.systemDateTime';

// import { systemDateTime } from "@kit.BasicServicesKit";


export default class ProcessUtil {
  private constructor() {
  }

  static instance: ProcessUtil = new ProcessUtil();

  test() {
    let result = process.isIsolatedProcess();
    console.log("ProcessUtil test 进程是否被隔离 isIsolatedProcess: ", result);

    let result1 = process.is64Bit();
    console.log("ProcessUtil test 进程是否是64位 is64Bit: ", result1);

    let realtime = process.getStartRealtime();//获取从系统启动到进程启动所经过的实时时间（以毫秒为单位）。
    let realtime2 = systemDateTime.getUptime(TimeType.TimeType.STARTUP)
    console.log("ProcessUtil test 进程启动时间 getStartRealtime: ", realtime);
    console.log("ProcessUtil test 进程启动时间 getUptime: ", realtime2);

    let result3 = process.getPastCpuTime() ;
    console.log("ProcessUtil test 获取进程启动到当前时间的CPU时间 getPastCpuTime: ", result3);

    let time = process.uptime();
    console.log('ProcessUtil test', time);

    let _SC_ARG_MAX = 0
    let pres = process.getSystemConfig(_SC_ARG_MAX)
    console.log('ProcessUtil test getSystemConfig: ', pres);

    let pro = new process.ProcessManager();
    let pres11 = pro.getSystemConfig(_SC_ARG_MAX);


    let pro2 = new process.ProcessManager();
    // uid通过process.uid获取
    let pres2 = process.uid;
    let result4 = pro2.isAppUid(pres2);
    console.log("result: " + result4); // result: true


    let pro5 = new process.ProcessManager();
    let tid5 = process.tid;
    let pres5 = pro5.getThreadPriority(tid5);
    console.log("ProcessUtil test getThreadPriority: ", pres5);

  }
}
