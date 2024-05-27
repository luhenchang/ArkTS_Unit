import { hilog } from '@kit.PerformanceAnalysisKit';

@Entry
@Component
struct CustomTabBoBottomBgPage {
  @State message: string = 'Hello World';
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State @Watch('selectedIndex') currentIndex: number = 0

  selectedIndex() {

  }
  build() {
    Canvas(this.context).width('100%').height(83).onReady(() => {
      this.draw();
    })
  }


  private draw() {
    this.context.save()
    let width = this.context.width
    let height = this.context.height

    let circleRadius = 0
    let cubicWidthMargin = 20
    this.context.clearRect(0, 0, width, height)
    this.context.save()



    this.context.translate(0, -circleRadius)
    let scaleWidth = (width / 3)
    hilog.error(0x0000, 'moveWidth', this.currentIndex.toString(), this.currentIndex)
    let moveWidth = scaleWidth * this.currentIndex;
    hilog.error(0x0000, 'moveWidth', moveWidth.toString(), this.currentIndex)
    let unit = scaleWidth / 8
    let cubicBottom = height / 2.5

    this.context.beginPath();
    this.context.moveTo(0, 0);
    this.context.lineTo(cubicWidthMargin + moveWidth, 0);

    this.context.bezierCurveTo(
      unit * 1 + cubicWidthMargin + moveWidth,
      0,
      unit * 1 + cubicWidthMargin + moveWidth,
      cubicBottom,
      unit * 4 + moveWidth,
      cubicBottom
    );
    this.context.bezierCurveTo(
      unit * 7 - cubicWidthMargin + moveWidth,
      cubicBottom,
      unit * 7 - cubicWidthMargin + moveWidth,
      0,
      unit * 8 - cubicWidthMargin + moveWidth,
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
}

