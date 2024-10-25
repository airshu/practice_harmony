import { Decimal } from "@kit.ArkTS";

/**
 * https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/js-apis-arkts-decimal-V5#pow
 */
export default class DecimalUtil {
  test() {
    let a: Decimal = new Decimal(5);
    console.info("test Decimal constructor:" + a.toString()); // '5'

    let a1: Decimal = new Decimal(-0.5).abs();
    console.info("test Decimal abs:" + a1.toString()); // '0.5'

    let a2: Decimal = new Decimal(1.8).floor();
    console.info("test Decimal floor:" + a2.toString()); // '1'

    let a3: Decimal = new Decimal(1.8).ceil();
    console.info("test Decimal ceil:" + a3.toString()); // '2'

    let a4: Decimal = new Decimal(2.5).trunc(); //返回一个新的Decimal，其值是将此Decimal截断为整数部分。
    console.info("test Decimal trunc:" + a4.toString()); // '2'

    let a5: Decimal = new Decimal(10.1).clamp(0, 10); //返回一个值为将该Decimal的值限制在min到max范围内的Decimal对象。
    console.info("test Decimal clamp:" + a5.toString()); // '10'

    let a6: Decimal = new Decimal(0.5).add(0.5);
    console.info("test Decimal add:" + a6.toString()); // '1'


    let a7: Decimal = new Decimal(1).sub(0.5);
    console.info("test Decimal sub:" + a7.toString()); // '0.5'

    let a8: Decimal = new Decimal(1).mul(0.5);
    console.info("test Decimal mul:" + a8.toString()); // '0.5'

    let a9: Decimal = new Decimal(1).div(0.5);
    console.info("test Decimal div:" + a9.toString()); // '2'

    let a10: Decimal = new Decimal(3).pow(-2);
    console.info("test Decimal pow:" + a10.toString()); // '0.11111111111111111111'

  }
}