export class TabContentModel {
  index: number
  defaultIcon: string
  selectedIcon: string
  title: string

  constructor(index: number, defaultIcon: string, selectedIcon: string, title: string) {
    this.index = index
    this.defaultIcon = defaultIcon
    this.selectedIcon = selectedIcon
    this.title = title
  }
}

export let tabContentList = [
  new TabContentModel(0, "app.media.home_default", "app.media.home_selected", "首页"),
  new TabContentModel(1,"app.media.read_default","app.media.read_selected", "课程"),
  new TabContentModel(2,"app.media.canvas_default","app.media.canvas_selected", "画布"),
  new TabContentModel(3,"app.media.setting_default","app.media.setting_selected", "设置"),
]