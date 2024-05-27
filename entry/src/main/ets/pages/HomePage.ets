//@Entry
import { CanvasPage } from './CanvasPage';
import { hilog } from '@kit.PerformanceAnalysisKit';


// xxx.ets
@Entry
@Component
struct HomePage {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#007DFF'
  @State @Watch('selectedIndex') currentIndex: number = 0
  private controller: TabsController = new TabsController()
  arrayData = ["hello", 1, 2, 11, 12, 12, 23, 23, 23, 23, 1212, 12123,
    1, 2, 11, 12, 12, 23, 23, 23, 23, 1212, 12123,
    1, 2, 11, 12, 12, 23, 23, 23, 23, 1212, 12123,
    1, 2, 11, 12, 12, 23, 23, 23, 23, 1212, 12123,
    1, 2, 11, 12, 12, 23, 23, 23, 23, 1212, 12123]

  selectedIndex() {
    this.controller.changeIndex(this.currentIndex)
  }

  @Builder
  TabBuilder(index: number, name: string) {
    Column() {
      Text(name)
        .fontColor(this.currentIndex === index ? this.selectedFontColor : this.fontColor)
        .fontSize(16)
        .fontWeight(this.currentIndex === index ? 500 : 400)
        .lineHeight(22)
        .margin({ top: 17, bottom: 7 })
      Divider()
        .strokeWidth(2)
        .color('#007DFF')
        .opacity(this.currentIndex === index ? 1 : 0)
    }.width('100%').onClick(() => {
       this.currentIndex = index
    })
  }
  colors = ['#FFFFFF', '#FFFFFF', '#FFFFFF', '#FFFFFF']
  @Builder
  TabBottomBackgroundCanvas() {
    Column() {
      Column().backgroundColor(this.colors[this.currentIndex]).width('100%').layoutWeight(1)
      Canvas(this.context).width('100%').height(83).onReady(() => {
        this.draw();
      })
  }
}

  private draw() {
    this.context.save()
    let width = this.context.width
    let height = this.context.height

    let circleRadius = 0
    let cubicWidthMargin = 20
    this.context.clearRect(0, 0, width, height)
    this.context.save()



    this.context.translate(0, circleRadius)
    let scaleWidth = (width / 4)
    hilog.error(0x0000, 'moveWidth', this.currentIndex.toString(), this.currentIndex)
    let moveWidth = scaleWidth * this.currentIndex;
    hilog.error(0x0000, 'moveWidth', moveWidth.toString(), this.currentIndex)
    let unit = scaleWidth / 8
    let cubicBottom = height / 2.5

    this.context.beginPath();
    this.context.moveTo(0, 0);
    this.context.lineTo(unit + cubicWidthMargin + moveWidth, 0);

    this.context.bezierCurveTo(
      unit * 2 + cubicWidthMargin + moveWidth,
      0,
      unit * 2.5 + cubicWidthMargin + moveWidth,
      cubicBottom,
      unit * 4 + moveWidth,
      cubicBottom
    );
    this.context.bezierCurveTo(
      unit * 5.5 - cubicWidthMargin + moveWidth,
      cubicBottom,
      unit * 6 - cubicWidthMargin + moveWidth,
      0,
      unit * 7 - cubicWidthMargin + moveWidth,
      0
    );
    this.context.lineTo(width, 0);
    this.context.lineTo(width, height);
    this.context.lineTo(0, height);
    this.context.closePath();
    this.context.clip();
    this.context.fillStyle = '#ff0bdddd';
    this.context.fill();

    this.context.restore()
  }

build() {
  Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
    Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
      TabContent() {
        List({ space: 20, initialIndex: 0 }) {
          ForEach(this.arrayData, (item: string) => {
            ListItem() {
              Text('' + item)
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
      }.tabBar(this.TabBuilder(0, 'green'))

      TabContent() {
        CanvasPage()
      }.tabBar(this.TabBuilder(1, 'blue'))

      TabContent() {
        Column().width('100%').height('100%').backgroundColor('#FFBF00')
      }.tabBar(this.TabBuilder(2, 'yellow'))

      TabContent() {
        Column().width('100%').height('100%').backgroundColor('#E67C92')
      }.tabBar(this.TabBuilder(3, 'pink'))
    }
    .vertical(false)
    .barWidth('100%')
    .barHeight(56)
    .animationDuration(400)
    .onChange((index: number) => {
      this.currentIndex = index
      this.draw()
    })
    .backgroundColor(this.colors[this.currentIndex])
    .background(this.TabBottomBackgroundCanvas(), { align: Alignment.Center })
    .width('100%')
    .height('100%')
    .margin({ top: 27 })
  }.width('100%')
}
}