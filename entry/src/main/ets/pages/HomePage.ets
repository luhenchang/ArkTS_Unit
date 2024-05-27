//@Entry
import { tabContentList, TabContentModel } from '../data/model/TabContentModel';
import { tabContentBuilder } from './HomeWidget';


// xxx.ets
@Entry
@Component
struct HomePage {
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#1196db'
  @State @Watch('selectedIndex') currentIndex: number = 0
  private controller: TabsController = new TabsController()


  selectedIndex() {
    this.controller.changeIndex(this.currentIndex)
  }

  tabContents = ["", "", "", ""]

  @Builder
  tabBuilder(index: number, defaultSrc: string, selectedSrc: string, name: string) {
    Column() {
      Image($r(this.currentIndex == index ? selectedSrc : defaultSrc)).height(26).width(26).margin({ top: 10 })
      Text(name)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(12)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .margin({ top: 3, bottom: 5 })
    }.width('100%').align(Alignment.Center)
  }


  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
      Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
        ForEach(tabContentList, (item: TabContentModel) => {
          TabContent() {
            tabContentBuilder(item)
          }
          .tabBar(this.tabBuilder(item.index, item.defaultIcon, item.selectedIcon, item.title))
        })
      }
      .vertical(false)
      .barWidth('100%')
      .barHeight(60)
      .animationDuration(56)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width('100%')
      .height('100%')
      .margin({ top: 27 })
    }.width('100%')
  }
}