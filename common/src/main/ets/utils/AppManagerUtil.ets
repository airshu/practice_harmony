import { appManager } from "@kit.AbilityKit";
import { BusinessError } from "@kit.BasicServicesKit";


export class AppManagerUtil {
  private constructor() {
  }

  static instance: AppManagerUtil = new AppManagerUtil();

  test() {
    appManager.getAppMemorySize().then((data) => {
      console.log(`The size of app memory is: ${JSON.stringify(data)}`);
    }).catch((error: BusinessError) => {
      console.error(`error: ${JSON.stringify(error)}`);
    });


    appManager.getRunningProcessInformation().then((data) => {
      console.log(`The running process information is: ${JSON.stringify(data)}`);
    }).catch((error: BusinessError) => {
      console.error(`error: ${JSON.stringify(error)}`);
    });
  }
}