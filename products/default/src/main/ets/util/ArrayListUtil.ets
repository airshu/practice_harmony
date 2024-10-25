import { ArrayList } from "@kit.ArkTS";


/**
 * 当需要频繁读取集合中的元素时，推荐使用ArrayList。
 */
export default class ArrayListUtil {
  private constructor() {
  }

  static instance: ArrayListUtil = new ArrayListUtil();

  test() {

    class C1 {
      name: string = ""
      age: string = ""
    }
    let arrayList: ArrayList<string | number | boolean | Array<number> | C1> = new ArrayList();
    let result1 = arrayList.add("a");
    let arrayList1: ArrayList<number> = new ArrayList();
    let result2 = arrayList.add(1);
    let b = [1, 2, 3];
    let result3 = arrayList.add(b);
    let c : C1 = {name: "Dylan", age: "13"}
    let result4 = arrayList.add(c);
    let result5 = arrayList.add(false);


    arrayList.insert("A", 0);
    arrayList.insert(0, 1);
    arrayList.insert(true, 2);

    arrayList.add("squirrel");
    let result: boolean = arrayList.has("squirrel");

    let result6: number = arrayList.getIndexOf(2);
    let result7: number = arrayList.getLastIndexOf(2);

  }
}