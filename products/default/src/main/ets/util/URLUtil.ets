import { url } from "@kit.ArkTS";


export default class URLUtil {
  private constructor() {
  }
  static instance: URLUtil = new URLUtil();

  test() {
    // 通过string[][]方式构造URLParams对象：
    let objectParams = new url.URLParams([ ['user1', 'abc1'], ['query2', 'first2'], ['query3', 'second3'] ]);
    // 通过Record<string, string>方式构造URLParams对象：
    let objectParams1 = new url.URLParams({"fod" : '1' , "bard" : '2'});
    // 通过string方式构造URLParams对象：
    let objectParams2 = new url.URLParams('?fod=1&bard=2');
    // 通过url对象的search属性构造URLParams对象：
    let urlObject = url.URL.parseURL('https://developer.mozilla.org/?fod=1&bard=2');
    let objectParams3 = new url.URLParams(urlObject.search);
    // 通过url对象的params属性获取URLParams对象：
    let urlObject1 = url.URL.parseURL('https://developer.mozilla.org/?fod=1&bard=2');
    let objectParams4 = urlObject1.params;


    let paramsObject = new url.URLParams(urlObject.search.slice(1));
    paramsObject.append('fod', '3');

    let paramsObject1 = new url.URLParams(urlObject.search.slice(1));
    paramsObject1.delete('fod');

    console.log(paramsObject.getAll('fod').toString())


  }
}