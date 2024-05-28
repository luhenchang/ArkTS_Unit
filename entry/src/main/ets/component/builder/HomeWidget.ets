import { TabContentModel } from '../../data/model/TabContentModel'
import { CanvasPage } from '../../pages/custom/CanvasPage'

let fontColor: string = '#182431'
let selectedFontColor: string = '#1196db'
export class TabSelected{
  selectedIndex:number = 0
}
@Builder
export function tabBarBuilder($$: TabSelected, index: number, defaultSrc: string, selectedSrc: string, name: string) {
  Column() {
    Image($r($$.selectedIndex == index ? selectedSrc : defaultSrc)).height(26).width(26).margin({ top: 10 })
    Text(name)
      .fontColor($$.selectedIndex === index ? selectedFontColor : fontColor)
      .fontSize(12)
      .fontWeight($$.selectedIndex === index ? 500 : 400)
      .margin({ top: 3, bottom: 5 })
  }.width('100%').align(Alignment.Center)
}

let arrayData = ["hello", 1, 2, 11, 12, 12, 23, 23, 23, 23, 1212, 12123,
  1, 2, 11, 12, 12, 23, 23, 23, 23, 1212, 12123,
  1, 2, 11, 12, 12, 23, 23, 23, 23, 1212, 12123,
  1, 2, 11, 12, 12, 23, 23, 23, 23, 1212, 12123,
  1, 2, 11, 12, 12, 23, 23, 23, 23, 1212, 12123]

@Builder
export function tabContentBuilder(item: TabContentModel) {
  if (item.index == 0) {
    List({ space: 20, initialIndex: 0 }) {
      ForEach(arrayData, (data: string) => {
        ListItem() {
          Text('' + data)
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
    .width('100%')
  } else if (item.index == 1) {
    Text(item.title)
  } else if (item.index == 2) {
    CanvasPage()
  } else {
    Text(item.title)
  }
}