import { TabContentModel } from '../../data/model/TabContentModel'
import { CanvasPage } from '../../pages/custom/CanvasPage'
import { HomeComponent } from '../struct/HomeComponent'

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


@Builder
export function tabContentBuilder(item: TabContentModel) {
  if (item.index == 0) {
    HomeComponent()
  } else if (item.index == 1) {
    Text(item.title)
  } else if (item.index == 2) {
    CanvasPage()
  } else {
    Text(item.title)
  }
}