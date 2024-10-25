import { uri } from "@kit.ArkTS";


export default class URIUtil {

  private constructor() {
  }

  static instance: URIUtil = new URIUtil();

  test() {
    const uriObj1 = new uri.URI("ftp://ftp.aaa.bbb.ccc/dddd/eee.txt");
    console.info(uriObj1.host) // ftp.aaa.bbb.ccc
    console.info(uriObj1.fragment) // null
    console.info(uriObj1.path) // /dddd/eee.txt
    console.info(uriObj1.scheme) // ftp
    console.info(uriObj1.userInfo) // null
    console.info(uriObj1.port) // -1
    console.info(uriObj1.query) // null

    const uriObj2 = new uri.URI("gopher://spinaltap.micro.umn.edu/00/Weather/California/Los%20Angeles#fragment");
    console.info(uriObj2.host) // spinaltap.micro.umn.edu
    console.info(uriObj2.fragment) // fragment
    console.info(uriObj2.path) // /00/Weather/California/Los Angeles
    console.info(uriObj2.scheme) // gopher
    console.info(uriObj2.userInfo) // null
    console.info(uriObj2.port) //-1
    console.info(uriObj2.query) // null

    const uriObj3 = new uri.URI("datashare:///com.samples.datasharetest.DataShare/DB00/TBL00");
    console.info(uriObj3.host) // null
    console.info(uriObj3.fragment) // null
    console.info(uriObj3.path) // /com.samples.datasharetest.DataShare/DB00/TBL00
    console.info(uriObj3.scheme) // datashare
    console.info(uriObj3.userInfo) // null
    console.info(uriObj3.port) // -1
    console.info(uriObj3.query) // null

    const uriObj4 = new uri.URI("https://username:password@host:8080/directory/file?foo=1&bar=2#fragment");
    console.info(uriObj4.host) // host
    console.info(uriObj4.fragment) // fragment
    console.info(uriObj4.path) // /directory/file
    console.info(uriObj4.scheme) // https
    console.info(uriObj4.userInfo) // username:password
    console.info(uriObj4.port) // 8080
    console.info(uriObj4.query) // foo=1&bar=2

    const uriObj5 = new uri.URI("dataability:///com.example.DataAbility");
    console.info(uriObj5.host) // null
    console.info(uriObj5.fragment) // null
    console.info(uriObj5.path) // /com.example.DataAbility:
    console.info(uriObj5.scheme) // dataability
    console.info(uriObj5.userInfo) // null
    console.info(uriObj5.port) // -1
    console.info(uriObj5.query) // null

    const uriObj6 = new uri.URI("https://username:my+name@host:8080/directory/my+file?foo=1&bar=2#fragment");
    console.info(uriObj6.encodedUserInfo) // username:my+name
    console.info(uriObj6.encodedPath) // /directory/my+file
    console.info(uriObj6.encodedQuery) // foo=1&bar=2
    console.info(uriObj6.encodedFragment) // fragment
    console.info(uriObj6.encodedAuthority) // username:my+name@host:8080
    console.info(uriObj6.encodedSSP) // //username:my+name@host:8080/directory/my+file?foo=1&bar=2

    let uriObj7 = new uri.URI("www.abc.com:8080/directory/file?ab=pppppp#qwer=da");
    console.log(uriObj7.scheme) // www.abc.com
    console.log(uriObj7.host) // null
    console.log(uriObj7.port) // -1
    console.log(uriObj7.path) // null
    console.log(uriObj7.query) // null
    console.log(uriObj7.authority) // null
    console.log(uriObj7.fragment) // qwer=da
    console.log(uriObj7.ssp) // 8080/directory/file?ab=pppppp
    console.log("result:", uriObj7.checkIsAbsolute()) // result: true

    const result = new uri.URI('https://username:password@host:8080/directory/file?ab=pppppp#qwer da');
    let result1 = result.toString(); // https://username:password@host:8080/directory/file?ab=pppppp#qwer%20da


  }
}

