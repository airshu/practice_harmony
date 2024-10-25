
import { collections } from '@kit.ArkTS';


export default class CollectionUtil {
  private constructor() {
  }

  static instance: CollectionUtil = new CollectionUtil();

  testArray() {
    let concatArray : collections.ConcatArray<number> = new collections.Array<number>(1, 2, 4, 8, 16, 32, 64);
    console.info("CollectionUtil Element at index 1: ", concatArray[1]);

    let concatArray1 : collections.ConcatArray<string> = new collections.Array<string>('a', 'b', 'c');
    let joinedString = concatArray1.join('-'); // 返回 "a-b-c"
    console.info("CollectionUtil joinedString: ", joinedString);

    let slicedArray = concatArray.slice(1, 3); // 返回[2, 3]，原Array保持不变
    console.info("CollectionUtil slicedArray: ", slicedArray);

    // 创建数组的方式
    let arrayPara  = [1,2,3];
    let array = new collections.Array<number>(...arrayPara);
    let lastElement = array.pop(); // 返回3，Array变为[1, 2]
    let length = array.push(4, 5); // 返回5，Array变为[1, 2, 3, 4, 5]
    let firstElement = array.shift(); //
    let newLength = array.unshift(0);
    array.sort((a: number, b: number) => a - b); // [1, 2, 3, 4, 5]
    array.sort((a: number, b: number) => b - a); // [5, 4, 3, 2, 1]

    let array1 = collections.Array.create<number>(3, 10); // [10, 10, 10]

    // 正例
    let array2 : Array<string> = ['str1', 'str2', 'str3']; // 原生Array<T>，T是Sendable数据类型。
    let sendableArray = collections.Array.from<string>(array2); // 返回Sendable Array<T>

  }

  testMap() {
    const myMap = new collections.Map<number, number>();

    const myMap1 = new collections.Map<number, string>([
      [1, "one"],
      [2, "two"],
      [3, "three"],
    ]);

    new collections.Map<string, number>([
      ['foo', 0],
      ['bar', 1],
      ['baz', 2],
    ]).forEach((value, key, map) => {
      console.info(`m[${key}] = ${value}`);
    });

    console.log('CollectionUtil testMap myMap1: ', myMap1);
    const iterator = myMap1.entries();
    console.info('CollectionUtil testMap myMap1: ', iterator.next().value);
    console.info('CollectionUtil testMap myMap1: ', iterator.next().value);

    const iteratorKey = myMap1.keys();
    console.info('CollectionUtil testMap myMap1: ', iteratorKey.next().value);
    const iteratorValues = myMap1.values();
    console.info('CollectionUtil testMap myMap1: ', iteratorValues.next().value);

    // Expected output: 2
    console.info("size:" + myMap1.size);
    myMap1.clear();
    // Expected output: 0
    console.info("size:" + myMap1.size);

    const myMap2 = new collections.Map<string, string>([
      ["hello", "world"],
    ]);
    // Expected output: "world"
    console.info(myMap2.get("hello"));
    // Expected output: undefined
    console.info(myMap2.get("world"));
    // Expected result: true
    console.info("result:" + myMap2.delete("hello"));
    // Expected result: false
    console.info("result:" + myMap2.has("hello"));
    // Expected result: false
    console.info("result:" + myMap2.delete("hello"));


  }

  testSet() {
    const mySet = new collections.Set<number>();
    const mySet1 = new collections.Set<number>([1, 2, 3, 4, 5]);
    const iterator = mySet.entries();
  }


  testArrayBuffer() {
    let arrayBuffer: collections.ArrayBuffer = new collections.ArrayBuffer(10);
    console.info("byteLength: " + arrayBuffer.byteLength); // byteLength: 10
    let slicedBuffer: collections.ArrayBuffer = arrayBuffer.slice(0, 4);
    console.info("byteLength: " + slicedBuffer.byteLength); // byteLength: 4
  }

  testTypedArray() {
    // 以长度参数构造对象
    let int8Array: collections.Int8Array = new collections.Int8Array(12);
    let uint8Array: collections.Uint8Array = new collections.Uint8Array(12);
    let int16Array: collections.Int16Array = new collections.Int16Array(12);
    let uint16Array: collections.Uint16Array = new collections.Uint16Array(12);
    let int32Array: collections.Int32Array = new collections.Int32Array(12);
    let uint32Array: collections.Uint32Array = new collections.Uint32Array(12);
    let uint8ClampedArray: collections.Uint8ClampedArray = new collections.Uint8ClampedArray(12);
    let float32Array: collections.Float32Array = new collections.Float32Array(12);

    // 例1 从一个ArrayLike构造对象
    let arrayLike = [1, 3, 5];
    let array: collections.Uint32Array = new collections.Uint32Array(arrayLike);

    // 例2 从一个ArrayBuffer构造对象
    let arrayBuffer: collections.ArrayBuffer = new collections.ArrayBuffer(12);
    let array1: collections.Uint32Array = new collections.Uint32Array(arrayBuffer);

    // 例3 从另一ArkTS TypedArray构造对象
    let arrayLike2 = [1, 3, 5];
    let uint8Array2: collections.Uint8Array = new collections.Uint8Array(arrayLike2);
    // Uint8Array [1, 3, 5]
    let uint32Array2: collections.Uint32Array = new collections.Uint32Array(uint8Array2);
    // Uint32Array [1, 3, 5]

    let array3: collections.Uint32Array = collections.Uint32Array.from([1, 2, 3, 4, 5, 6, 7, 8]);
    let copied: collections.Uint32Array = array3.copyWithin(3, 1, 3);
    // Uint32Array [1, 2, 3, 2, 3, 6, 7, 8]

    let arrayLike4 = [-10, 20, -30, 40, -50];
    let uint32Array4: collections.Uint32Array = new collections.Uint32Array(arrayLike4);
    uint32Array4.some((element: number) => element < 0); // false

    let int32Array4: collections.Int32Array = new collections.Int32Array(arrayLike4);
    int32Array4.some((element: number) => element < 0); // true


  }

  /**
   * BitVector是一种线性数据结构，底层基于数组实现。BitVector中存储元素为bit值，能存储和处理bit级别的操作。
   */
  testBitVector() {

    let bitVector: collections.BitVector = new collections.BitVector(0);
    bitVector.push(0);
    bitVector.push(1);
    bitVector.push(0);
    bitVector.push(1);
    bitVector.push(0); // bitVector: [0, 1, 0, 1, 0]

    let res0: boolean = bitVector.has(0, 1, 4);
    console.info("bitVector has 0:", res0) // true

    bitVector.setBitsByRange(1, 1, 3); // bitVector: [0, 1, 1, 1, 0]

    let res = bitVector.pop(); // bitVector: [0, 1, 1, 1]
    console.info("bitVector pop:", res) // 0

  }


}