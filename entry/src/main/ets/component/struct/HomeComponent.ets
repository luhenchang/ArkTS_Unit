import { ArticleItem, ArticleModel } from '../../data/model/ArticleModel';
import HarmonyViewModel from '../../pages/viewmodel/HarmonyViewModel';

@Component
export struct HomeComponent {
  @State articleList: ArticleItem[] = [];
  @State isLoading: boolean = true

  aboutToAppear(): void {
    this.loadArticleInfo();
  }

  private loadArticleInfo() {
    HarmonyViewModel.requestData().then(articleModel => {
      this.articleList = this.articleList.concat(articleModel.data.datas)
      this.isLoading = false
    })
  }

  build() {
    // HelloComponent自定义组件组合系统组件Row和Text
    List({ space: 20, initialIndex: 0 }) {
      ForEach(this.articleList, (data: ArticleItem) => {
        ListItem() {
          Text('' + data.title)
            .width('100%')
            .height(100)
            .fontSize(16)
            .textAlign(TextAlign.Center)
            .borderRadius(10)
            .backgroundColor(0xFFFFFF)
        }
      })
    }
    .listDirection(Axis.Vertical) // 排列方向
    .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
    .edgeEffect(EdgeEffect.Spring) // 滑动到边缘无效果
    .onScrollIndex((firstIndex: number, lastIndex: number) => {
      console.info('first' + firstIndex)
      console.info('last' + lastIndex)
    })
    .onReachEnd(() => {
      if (!this.isLoading) {
        this.isLoading = true
        HarmonyViewModel.pageIndex++
        this.loadArticleInfo()
      }

    })
    .width('100%')
  }
}