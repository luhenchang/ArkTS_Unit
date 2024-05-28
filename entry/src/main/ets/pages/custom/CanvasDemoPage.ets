import { CirclePieChartMaxBean, dataList } from '../../data/model/CirclePieChartMaxBean'


@Entry
@Component
struct CanvasDemoPage {
  private settings: RenderingContextSettings = new RenderingContextSettings(true)
  private context: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings)
  @State rotation: number = 0
  @State rotateValue: number = 0

  build() {
    Column() {
      Canvas(this.context)
        .width('100%')
        .height('100%')
        .backgroundColor(Color.White)
          // 双指旋转触发该手势事件
        .gesture(
          RotationGesture()
            .onActionStart((event: GestureEvent) => {
              console.info('Rotation start')
            })
            .onActionUpdate((event: GestureEvent) => {
              this.rotation = this.rotateValue + event.angle
              this.draw()
            })
            .onActionEnd(() => {
              this.rotateValue = this.rotation
              console.info('Rotation end')
            })
        )
        .onReady(() => {
          this.draw()
        })
    }
    .height('100%')
  }

  private draw() {

    this.context.save()
    //设置字体大小
    this.context.font = "30px"
    let radius = 80
    let routeAngle = 0
    let startAngle = 0
    let defaultAngle = -90 + this.rotation
    let sum: number = dataList.reduce((accumulator, currentValue) => accumulator + currentValue.valueData, 0);
    let width = this.context.width
    let height = this.context.height
    //清空画布，避免重绘，否则每次drawSector都会绘制一次。最后重叠交错
    this.context.clearRect(0, 0, width, height)
    this.context.save()
    //将坐标圆心变换到屏幕中心即圆心
    this.context.translate(width / 2, height / 2)
    for (let index = 0; index < dataList.length; index++) {
      const angleData = dataList[index]
      //每个扇形区域
      let sweepAngle = angleData.valueData / sum * 360
      let halfAngle = defaultAngle + sweepAngle / 2
      console.log("sweepAngle", sweepAngle.toString())

      //绘制扇形区域开始
      this.drawArc(routeAngle, sweepAngle, radius, angleData)
      //开始绘制指示线
      this.drawTextLine(radius, halfAngle, angleData)

      defaultAngle += sweepAngle
      routeAngle += sweepAngle
    }

    this.drawTextCenter(radius)
    this.context.restore()
  }

  private drawTextCenter(radius: number) {
    this.context.arc(0, 0, radius - 25, 0, Math.PI * 2)
    this.context.fillStyle = Color.White
    this.context.shadowBlur = 0
    this.context.shadowOffsetY = 0
    this.context.fill()

    this.context.fillStyle = 'rgba(53,158,255,1.00)'
    this.context.shadowBlur = 6
    this.context.shadowOffsetY = 3
    this.context.shadowColor = 'rgba(53,158,255,1.00)'
    let centerTextMeasure = this.context.measureText("APP")
    this.context.font = "40px"
    this.context.fillText("APP", -centerTextMeasure.width / 2, centerTextMeasure.height / 2)
  }

  private drawTextLine(radius: number, halfAngle: number, angleData: CirclePieChartMaxBean) {
    const pointToCircle = 20
    const titleLineToPDistance = 20
    const mTitleMarginStar = 10
    this.context.font = "44px"
    let centerX = (radius + pointToCircle) * Math.sin(this.degreesToRadians(halfAngle + 90))
    let centerY = -(radius + pointToCircle) * Math.cos(this.degreesToRadians(halfAngle + 90))
    if (this.determineQuadrant(halfAngle + 90.0) == 1 || this.determineQuadrant(halfAngle + 90.0) == 2) {
      let centerX =
        (radius + pointToCircle) * Math.sin(this.degreesToRadians(halfAngle + 90))
      let centerY =
        -(radius + pointToCircle) * Math.cos(this.degreesToRadians(halfAngle + 90))
      let lineTwoPointX =
        (radius + pointToCircle + titleLineToPDistance) * Math.sin(
          this.degreesToRadians(
            halfAngle + 90
          )
        )
      let lineTwoPointY =
        -(radius + pointToCircle + titleLineToPDistance) * Math.cos(
          this.degreesToRadians(
            halfAngle + 90
          )
        )
      let textTitleMeasure = this.context.measureText(angleData.title)
      let textSubMeasure = this.context.measureText(angleData.sub)

      this.context.beginPath()
      this.context.moveTo(centerX, centerY)
      this.context.lineTo(lineTwoPointX, lineTwoPointY)
      this.context.lineTo(
        lineTwoPointX + textTitleMeasure.width + mTitleMarginStar,
        lineTwoPointY
      )

      let textDrawStartX = lineTwoPointX + mTitleMarginStar
      let textSubStartX = lineTwoPointX + textTitleMeasure.width + mTitleMarginStar - textSubMeasure.width

      this.context.lineWidth = 1
      this.context.shadowBlur = 4
      this.context.shadowOffsetY = 0.5
      this.context.shadowColor = 'rgb(0,0,0)'
      this.context.strokeStyle = 'rgba(53,158,255,1.00)'
      this.context.stroke()

      //绘制线头圆点
      this.context.beginPath()
      this.context.arc(centerX, centerY, 5, 0, Math.PI * 2)
      this.context.fillStyle = 'rgba(53,158,255,1.00)'
      this.context.fill()

      this.context.beginPath()
      this.context.arc(centerX, centerY, 3, 0, Math.PI * 2)
      this.context.fillStyle = 'rgba(255,255,255,1.00)'
      this.context.fill()

      //绘制文字
      this.context.shadowBlur = 2
      this.context.shadowOffsetY = 0.5
      this.context.fillStyle = 'rgba(53,158,255,1.00)'
      this.context.fillText(angleData.sub, textSubStartX, lineTwoPointY - textSubMeasure.height / 2)
      this.context.fillStyle = 'rgb(0,0,0)'
      this.context.fillText(angleData.title, textDrawStartX, lineTwoPointY + textTitleMeasure.height)


    } else if (this.determineQuadrant(halfAngle + 90.0) == 3 || this.determineQuadrant(halfAngle + 90.0) == 4) {

      let centerX =
        (radius + pointToCircle) * Math.sin(this.degreesToRadians(halfAngle + 90))
      let centerY =
        -(radius + pointToCircle) * Math.cos(this.degreesToRadians(halfAngle + 90))


      let lineTwoPointX =
        (radius + pointToCircle + titleLineToPDistance) * Math.sin(
          this.degreesToRadians(
            halfAngle + 90
          )
        )
      let lineTwoPointY =
        -(radius + pointToCircle + titleLineToPDistance) * Math.cos(
          this.degreesToRadians(
            halfAngle + 90
          )
        )
      let textTitleMeasure = this.context.measureText(angleData.title)
      let textSubMeasure = this.context.measureText(angleData.sub)

      this.context.beginPath()

      this.context.moveTo(lineTwoPointX - textTitleMeasure.width - mTitleMarginStar, lineTwoPointY)
      this.context.lineTo(lineTwoPointX, lineTwoPointY)
      this.context.lineTo(
        centerX, centerY
      )
      this.context.stroke()
      //绘制文字
      let textDrawStartX = lineTwoPointX - textTitleMeasure.width - mTitleMarginStar
      let textSubStartX = textDrawStartX

      this.context.lineWidth = 1
      this.context.shadowBlur = 4
      this.context.shadowOffsetY = 0.5
      this.context.shadowColor = 'rgb(0,0,0)'
      this.context.strokeStyle = 'rgba(53,158,255,1.00)'
      this.context.stroke()

      //绘制线头圆点
      this.context.beginPath()
      this.context.arc(centerX, centerY, 5, 0, Math.PI * 2)
      this.context.fillStyle = 'rgba(53,158,255,1.00)'
      this.context.fill()

      this.context.beginPath()
      this.context.arc(centerX, centerY, 3, 0, Math.PI * 2)
      this.context.fillStyle = 'rgba(255,255,255,1.00)'
      this.context.fill()

      //绘制文字
      this.context.shadowBlur = 2
      this.context.shadowOffsetY = 0.5
      this.context.fillStyle = 'rgba(53,158,255,1.00)'
      this.context.fillText(angleData.sub, textSubStartX, lineTwoPointY - textSubMeasure.height / 2)
      this.context.fillStyle = 'rgb(0,0,0)'
      this.context.fillText(angleData.title, textDrawStartX, lineTwoPointY + textTitleMeasure.height)
    }
  }

  private drawArc(routeAngle: number, sweepAngle: number, radius: number, angleData: CirclePieChartMaxBean) {
    this.context.save()
    //我习惯垂直方向向上作为弧度绘制开始，而不喜欢水平，这个应该由产品决定，而我这里选择了-90到了12点位置作为绘制起始
    //为了让扇形每一份都朝着自己弧度中心向外traslate，所以我这里让会让坐标系横轴X转到每个扇形弧度中间，接着直接translate(间隙距离,0)就可以达到间隙效果。
    let rotateAngle = (routeAngle + sweepAngle / 2 - 90 + this.rotation)
    this.context.rotate(rotateAngle / 180 * Math.PI)
    this.context.translate(5, 0)
    this.context.beginPath()
    this.context.moveTo(0, 0)

    this.context.arc(0, 0, radius, Math.PI * (-sweepAngle / 2 / 180), Math.PI * (sweepAngle / 2 / 180))
    this.context.closePath()
    this.context.fillStyle = angleData.color.toString()
    this.context.shadowBlur = 10
    this.context.shadowOffsetX = 1
    this.context.shadowColor = 'rgb(0,0,0)'
    this.context.fill()
    this.context.restore()
  }

  //进行象限获取
  determineQuadrant(angleDegrees: number): number {
    // 将角度标准化到0-360度之间
    let standardizedAngle = angleDegrees % 360;

    // 将负角度转换为对应的正角度
    if (standardizedAngle < 0) {
      standardizedAngle += 360;
    }

    // 判断角度所在的象限
    if (standardizedAngle >= 0 && standardizedAngle < 90) {
      return 1;
    } else if (standardizedAngle >= 90 && standardizedAngle < 180) {
      return 2;
    } else if (standardizedAngle >= 180 && standardizedAngle < 270) {
      return 3;
    } else {
      return 4;
    }
  }

  degreesToRadians(degrees:
    number
  ):
    number {
    return (degrees * Math.PI / 180)
  }
}



