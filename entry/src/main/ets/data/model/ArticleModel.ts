import { List } from '@kit.ArkTS'

export class ArticleModel {
  data: ArticleData
  errorCode: number
  errorMsg: string
}

class ArticleData {
  curPage: number
  datas: ArticleItem[]
  offset: number
  over: Boolean
  pageCount: number
  size: number
  total: number
}

export class ArticleItem {
  author: string
  title: string
}