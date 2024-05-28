import { ArticleModel } from '../../data/model/ArticleModel'
import { http } from '@kit.NetworkKit'

class HarmonyViewModel {
  pageIndex: number = 0
  //https://www.wanandroid.com/article/list/11/json
  baseURL: string = "https://www.wanandroid.com/article/list/"

  //网络请求
  requestData(): Promise<ArticleModel> {
    return new Promise((resolve, reject) => {
      //1、创建http请求
      let httpRequest = http.createHttp()
      //2、发送请求
      httpRequest.request(
        `${this.baseURL}${this.pageIndex}/json`,
        {
          method: http.RequestMethod.GET
        }
      ).then(resp => {
        if (resp.responseCode === 200) {
          //查询成功
          resolve(JSON.parse(resp.result.toString()))
        } else {
          console.log('查询数据失败', JSON.stringify(resp));
          reject('查询失败')
        }
      }).catch(error => {
        console.log('查询失败', JSON.parse(error));
        reject('查询失败')
      })
    })
  }
}

export const harmonyViewModel = new HarmonyViewModel()

export default harmonyViewModel as HarmonyViewModel