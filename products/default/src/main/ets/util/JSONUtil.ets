import { JSON } from "@kit.ArkTS";


export default class JSONUtil {
  private constructor() {
  }

  static instance: JSONUtil = new JSONUtil();

  test() {
    let jsonText = '{"name": "John", "age": 30, "city": "ChongQing"}';
    let obj = JSON.parse(jsonText);
    console.log('>>>>', (obj as object)?.['name'])
    let rst = JSON.has(obj, "name");
    console.log('>>>>', rst);
    let options: JSON.ParseOptions = {
      bigIntMode: JSON.BigIntMode.PARSE_AS_BIGINT,
    }
    let numberText = '{"largeNumber":112233445566778899}';
    let numberObj = JSON.parse(numberText,(key: string, value: Object | undefined | null): Object | undefined | null => {
      if(key === "largeNumber") return value;
      return value;
    },options) as Object;

    console.info((numberObj as object)?.["largeNumber"]);
    // 期望输出: 112233445566778899




    interface Person {
      name: string;
      age: number;
      city: string;
    }
    let obj1 = {"name": "John", "age": 30, "city": "ChongQing"} as Person;
    let str1 = JSON.stringify(obj1, ["name"]);
    console.log(str1);

    let str2 = JSON.stringify(obj, this.replacer);
    console.log(str2)



  }

  replacer(key: string, value: Object): Object {
    if (typeof value === "string") {
      return value.toUpperCase();
    }
    return value;
  }
}