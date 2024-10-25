import { util } from "@kit.ArkTS";

export default class AspectUtil {


  test() {

    let asp = new MyClass();
    let result = asp.foo('123');
    // 输出结果：foo arg is 123
    console.info('result is ' + result);
    // 输出结果：result is msg000
    console.info('asp.msg is ' + asp.msg);
    // 输出结果：asp.msg is msg000

    util.Aspect.addBefore(MyClass, 'foo', false, (instance: MyClass, arg: string) => {
      console.info('arg is ' + arg);
      instance.msg = 'msg111';
      console.info('msg is changed to ' + instance.msg)
    });

    result = asp.foo('123');
    // 输出结果：arg is 123
    // 输出结果：msg is changed to msg111
    // 输出结果：foo arg is 123
    console.info('result is ' + result);
    // 输出结果：result is msg111
    console.info('asp.msg is ' + asp.msg);
    // 输出结果：asp.msg is msg111



    let res = MyClass.bar('456');
    // 输出结果：bar arg is 456
    console.info('res is ' + res);
    // 输出结果：res is data000
    console.info('MyClass.data is ' + MyClass.data);
    // 输出结果：MyClass.data is data000

    util.Aspect.addBefore(MyClass, 'bar', true, (target: Object, arg: string) => {
      console.info('arg is ' + arg);
      let newVal = 'data111';
      Reflect.set(target, 'data', newVal);
      console.info('data is changed to ' + newVal);
    });

    res = MyClass.bar('456');
    // 输出结果：arg is 456
    // 输出结果：data is changed to data111
    // 输出结果：bar arg is 456
    console.info('res is ' + res);
    // 输出结果：res is data111
    console.info('MyClass.data is ' + MyClass.data);
    // 输出结果：MyClass.data is data111
  }
}


class MyClass {
  msg: string = 'msg000';
  foo(arg: string): string {
    console.info('foo arg is ' + arg);
    return this.msg;
  }

  static data: string = 'data000';
  static bar(arg: string): string {
    console.info('bar arg is ' + arg);
    return MyClass.data;
  }
}
