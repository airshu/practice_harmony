import { ArkTSUtils, collections, lang } from "@kit.ArkTS";

/**
 * 为支持将JSON字符串解析成共享数据，即Sendable支持的数据类型，ArkTS语言基础库新增了ASON工具。
 * ASON支持开发者解析JSON字符串，并生成共享数据进行跨并发域传输，同时ASON也支持将共享数据转换成JSON字符串。
 */
export default class ASONUtil {
  private constructor() {
  }

  static instance: ASONUtil = new ASONUtil();

  test() {
    type ISendable = lang.ISendable;
    let jsonText = '{"name": "John", "age": 30, "city": "ChongQing"}';
    let obj = ArkTSUtils.ASON.parse(jsonText) as ISendable;
    console.info((obj as object)?.["name"]);
    // 期望输出: 'John'
    console.info((obj as object)?.["age"]);
    // 期望输出: 30
    console.info((obj as object)?.["city"]);
    // 期望输出: 'ChongQing'

    let options: ArkTSUtils.ASON.ParseOptions = {
      bigIntMode: ArkTSUtils.ASON.BigIntMode.PARSE_AS_BIGINT,
      parseReturnType: ArkTSUtils.ASON.ParseReturnType.OBJECT,
    }
    let numberText = '{"largeNumber":112233445566778899}';
    let numberObj = ArkTSUtils.ASON.parse(numberText, undefined, options) as ISendable;

    console.info((numberObj as object)?.["largeNumber"]);
    // 期望输出: 112233445566778899


    let arr1 = new collections.Array(1, 2, 3);
    let str = ArkTSUtils.ASON.stringify(arr1);
    console.info(str);
    // 期望输出: '[1,2,3]'
  }
}