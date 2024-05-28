//导入模块
import http from '@ohos.net.http';

//2.使用http模块发送请求，处理相应
let httpRequest = http.createHttp()
httpRequest.request('http://localholst:3000/users', {
  method: http.RequestMethod.GET,
  extraData: { 'param1': 'VALUE1' }, //k1=V1&K2=V2
  readTimeout: 60000,
  connectTimeout: 50 * 1000
})//Promise:存放未来会完成结果
  //2.3处理相应结果
  .then((res: http.HttpResponse) => {
    if (res.responseCode === 200) {
      //请求成功
    }
  }).catch((err: Error) => {
  //请求错误
})