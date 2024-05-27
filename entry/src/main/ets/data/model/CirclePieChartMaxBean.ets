
export class CirclePieChartMaxBean {
  valueData: number//票数
  title: string//指示器标题
  sub: string//指示器副标题
  color: ResourceColor | string//扇形区域颜色

  constructor(valueData: number, title: string, sub: string, color: ResourceColor | string) {
    this.valueData = valueData
    this.title = title
    this.sub = sub
    this.color = color
  }
}

export let dataList: Array<CirclePieChartMaxBean> = [
  new CirclePieChartMaxBean(
    30,
    "Compose",
    "60%",
    'rgba(53,158,255,1.00)'
  ),
  new CirclePieChartMaxBean(
    30,
    "Flutter",
    "30%",
    'rgba(67, 223, 210, 1.00)'
  ),
  new CirclePieChartMaxBean(
    10,
    "ArkTS",
    "5%",
    'rgba(255, 212, 81, 1.00)'
  ),
  new CirclePieChartMaxBean(
    20,
    "Xml",
    "3%",
    'rgba(155, 115, 226, 1.00)'
  ),
  new CirclePieChartMaxBean(
    10,
    "Vue",
    "10%",
    'rgba(239, 184, 200, 1.00)'
  )
]