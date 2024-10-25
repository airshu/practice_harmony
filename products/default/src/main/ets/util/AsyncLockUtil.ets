import { ArkTSUtils } from "@kit.ArkTS";


export default class AsyncLockUtil {

  private constructor() {
  }

  static instance: AsyncLockUtil = new AsyncLockUtil();

  test() {
    ArkTSUtils.locks.AsyncLock.request("test").lockAsync(() => {
      console.info("test");
    });

    foo(new A());


    let lock = new ArkTSUtils.locks.AsyncLock();
    let p1 = lock.lockAsync<void>(() => {
      console.log("p1 执行某些操作");
    }, ArkTSUtils.locks.AsyncLockMode.EXCLUSIVE);


    let states: ArkTSUtils.locks.AsyncLockState[] = ArkTSUtils.locks.AsyncLock.queryAll();
    if (states.length == 0) {
      console.info("AsyncLockUtil test queryAll: no lock");
    }
  }


  count_: number = 0;
  async getCount(): Promise<number> {
    let lock: ArkTSUtils.locks.AsyncLock = ArkTSUtils.locks.AsyncLock.request("lock_1");
    return lock.lockAsync(() => {
      return this.count_;
    })
  }
  async setCount(count: number) {
    let lock: ArkTSUtils.locks.AsyncLock = ArkTSUtils.locks.AsyncLock.request("lock_1");
    await lock.lockAsync(() => {
      this.count_ = count;
    })
  }
}

class A {
  count_: number = 0;
  lock_: ArkTSUtils.locks.AsyncLock = new ArkTSUtils.locks.AsyncLock();
  async getCount(): Promise<number> {
    return this.lock_.lockAsync(() => {
      return this.count_;
    })
  }
  async setCount(count: number) {
    await this.lock_.lockAsync(() => {
      this.count_ = count;
    })
  }
}

@Concurrent
async function foo(a: A) {
  await a.setCount(10)
}