import { Deque } from "@kit.ArkTS";


export default class DequeUtil {
  private constructor() {
  }

  static instance: DequeUtil = new DequeUtil();

  test() {
    class C1 {
      name: string = ""
      age: string = ""
    }
    let deque: Deque<string | number | boolean | Array<number> | C1> = new Deque();
    deque.insertFront("a");
    deque.insertFront(1);
    let b = [1, 2, 3];
    deque.insertFront(b);
    let c: C1 = {name : "Dylan", age : "13"};
    deque.insertFront(c);
    deque.insertFront(false);
  }
}

