import { Tmp } from '../../data/model/Tmp'

//引用传递，会更新
@Builder
export function MyGlobalTextBuilderFunction
(params: Tmp) {
  Text(`${params.paramA1}`)
    .fontSize(50)
    .fontWeight(FontWeight.Bold)
}

//按值传递参数
@Builder
export function MyGlobalTextBuilderFunction1(
  params: string) {
  Text(`${params}`)
    .fontSize(50)
    .fontWeight(FontWeight.Bold)
}


