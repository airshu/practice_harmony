import { AppManagerUtil, BundleManagerUtil } from "@ohos/common"
import StateManagerPage1 from "./StateManagerPage1"
import { AppStorageV2, PersistenceV2 } from "@kit.ArkUI"


@ObservedV2
class SampleChild {
  @Trace p1: number = 0;
  p2: number = 10;
}

@ObservedV2
export class Sample {
  @Trace p1: number = 0;
  p2: number = 10;

  @Trace f: SampleChild = new SampleChild();

  toString() {
    return `p1: ${this.p1}, p2: ${this.p2}`
  }
}

@ComponentV2
export struct IndexComponent {

  @Local prop: Sample = AppStorageV2.connect(Sample, () => new Sample())!;

  @Local persistence: Sample = PersistenceV2.connect(Sample, () => new Sample())!;

  build() {
    Column() {
      Button() {
        Text('Click me')
      }.onClick(() => {
        console.log('Button clicked')
        AppManagerUtil.instance.test();
        BundleManagerUtil.instance.test();
      })

      Button('Page2 connect the key Sample1')
        .onClick(() => {
          // 在AppStorageV2中创建一个key为Sample1的键值对（如果存在，则返回AppStorageV2中的数据），并且和prop关联
          this.prop = AppStorageV2.connect(Sample, 'Sample1', () => new Sample())!;
        })

      Text(`Page2 add 1 to prop.p1: ${this.prop.p1}`)
        .fontSize(30)
        .onClick(() => {
          this.prop.p1++;

        })

      Text(`Page2 add 1 to prop.p2: ${this.prop.p2}`)
        .fontSize(30)
        .onClick(() => {
          // 页面不刷新，但是p2的值改变了；只有重新初始化才会改变
          this.prop.p2++;
          console.log('prop>>>>>:', this.prop)
        })

      // 获取当前AppStorageV2里面的所有key
      Text(`all keys in AppStorage: ${AppStorageV2.keys()}`)
        .fontSize(30)

      Button('Page1 connect the key Sample')
        .onClick(() => {
          // 在PersistenceV2中创建一个key为Sample的键值对（如果存在，则返回PersistenceV2中的数据），并且和prop关联
          // 不建议对prop属性换connect的对象
          this.prop = PersistenceV2.connect(Sample, 'Sample', () => new Sample())!;
        })

      Button('Page1 remove the key Sample')
        .onClick(() => {
          // 从PersistenceV2中删除后，prop将不会再与key为Sample的值关联
          PersistenceV2.remove(Sample);
        })

      Button('Page1 save the key Sample')
        .onClick(() => {
          // 如果处于connect状态，持久化key为Sample的键值对
          PersistenceV2.save(Sample);
        })

      Text(`Page1 add 1 to prop.p1: ${this.prop.f.p1}`)
        .fontSize(30)
        .onClick(() => {
          this.prop.f.p1++;
        })

      Text(`Page1 add 1 to prop.p2: ${this.prop.f.p2}`)
        .fontSize(30)
        .onClick(() => {
          // 页面不刷新，但是p2的值改变了
          this.prop.f.p2++;
        })

      // 获取当前PersistenceV2里面的所有key
      Text(`all keys in PersistenceV2: ${PersistenceV2.keys()}`)
        .fontSize(30)

      Index()
    }
  }
}



@Entry
@ComponentV2
struct Index {
  @Local value: number = 0;

  build() {
    Column() {
      Text(`${this.value}`)
      Button(`change value`).onClick(() => {
        this.value++;
      })
      Star({ value: this.value!! })//双向绑定 https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-new-binding-V5
    }
  }
}


@ComponentV2
struct Star {
  @Param value: number = 0;
  @Event $value: (val: number) => void = (val: number) => {};

  build() {
    Column() {
      Text(`${this.value}`)
      Button(`change value `).onClick(() => {
        this.$value(10);
      })
    }
  }
}
