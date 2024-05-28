export class HomeStyles {
  static fontColor: string = '#182431'
  static selectedFontColor: string = '#1196db'

  static getColor(selected: boolean): string {
    return selected ? HomeStyles.selectedFontColor : HomeStyles.fontColor
  }
}