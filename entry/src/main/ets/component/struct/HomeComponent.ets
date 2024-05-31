import { ArticleItem, ArticleModel } from '../../data/model/ArticleModel';
import HarmonyViewModel from '../../pages/viewmodel/HarmonyViewModel';
import {
  closeLoadMore,
  closeRefresh,
  CustomRefreshLoadLayout,
  listTouchEvent,
  NoMoreLayout,
  PullRefreshModel
} from '../pullrefresh/PullRefreshExport'
import { PageState } from '../pullrefresh/PullRefreshConstant'

@Component
export struct HomeComponent {
  @State articleList: ArticleItem[] = [];
  // 需绑定列表或宫格组件
  private scroller: Scroller = new Scroller();
  @State dataModel: PullRefreshModel = new PullRefreshModel()
  @State isLoading: boolean = true
  @State showFakeHead: boolean = true

  aboutToAppear(): void {
    this.loadArticleInfo(false);
  }

  private loadArticleInfo(isLoadMore: boolean) {
    HarmonyViewModel.pageIndex = this.dataModel.currentPage
    HarmonyViewModel.requestData().then(articleModel => {
      // 模拟网络请求操作，请求网络2秒后得到数据，通知组件，变更列表数据
      this.dataModel.pageState = PageState.Success;
      //这里pageCount表示公共的页面数据。当请求次数小于总的页面次数表示可以继续加载
      if (this.dataModel.currentPage < articleModel.data.pageCount) {
        this.dataModel.currentPage++;
        this.dataModel.hasMore = true;
      } else {
        this.dataModel.hasMore = false;
      }
      //表示还有数据，可以继续加载更多
      if (isLoadMore) {
        this.articleList = this.articleList.concat(articleModel.data.datas)
        closeLoadMore(this.dataModel)
      } else {//表示第一次请求
        this.articleList = articleModel.data.datas
        closeRefresh(this.dataModel, true)
      }
      this.dataModel.dataSize = this.articleList.length
    })
  }

  build() {
    Column() {
      // 列表首条 Item
      CustomRefreshLoadLayout({ config: this.dataModel.refreshLayoutConfig })

      List({ scroller: this.scroller }) {
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
        // 列表末条 Item
        ListItem() {
          if (this.dataModel.hasMore) {
            CustomRefreshLoadLayout({ config: this.dataModel.loadMoreLayoutConfig })
          } else {
            NoMoreLayout()
          }
        }
      }
      .listDirection(Axis.Vertical) // 排列方向
      .onTouch((event: TouchEvent | undefined) => {
        if (event) {
          if (this.dataModel.pageState === PageState.Success) {
            console.log("listTouchEvent=", this.dataModel.pageState)
            listTouchEvent(this.dataModel, event, (isLoadMore: boolean) => {
              console.log("loadArticleInfo=", isLoadMore)
              this.loadArticleInfo(isLoadMore)
            });
          }
        }
      })
      .onScrollIndex((start: number, end: number) => {
        console.log(`headfloat start:${start}`)
        this.dataModel.startIndex = start;
        this.dataModel.endIndex = end;
      })
      .scrollBar(BarState.Off)
      .backgroundColor('#E5E5E5')
      .edgeEffect(EdgeEffect.None) // 必须设置列表为滑动到边缘无效果
    }
  }
}