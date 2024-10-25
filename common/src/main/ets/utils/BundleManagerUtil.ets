import { bundleManager } from "@kit.AbilityKit";
import hilog from "@ohos.hilog";
import { BusinessError } from "@kit.BasicServicesKit";


export class BundleManagerUtil {
  private constructor() {
  }

  static instance: BundleManagerUtil = new BundleManagerUtil();

  test() {

    let bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_APPLICATION | bundleManager.BundleFlag.GET_BUNDLE_INFO_WITH_METADATA;

    try {
      bundleManager.getBundleInfoForSelf(bundleFlags).then((data:bundleManager.BundleInfo) => {
        hilog.info(0x0000, 'testTag', 'getBundleInfoForSelf successfully. Data: %{public}s', JSON.stringify(data));
      }).catch((err: BusinessError) => {
        hilog.error(0x0000, 'testTag', 'getBundleInfoForSelf failed. Cause: %{public}s', err.message);
      });
    } catch (err) {
      let message = (err as BusinessError).message;
      hilog.error(0x0000, 'testTag', 'getBundleInfoForSelf failed: %{public}s', message);
    }
  }
}