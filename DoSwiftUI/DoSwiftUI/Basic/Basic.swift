//
//  Basic.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/9.
//

import SwiftUI

struct Basic: View {
    
    /*:
     在siwftUI中如果要绑定控件的值到变量，
     需要使用`@State`来修饰变量，以表示该变量是有状态的
     */
    @State private var toggleIsOn = false
    @State private var sliderValue = 0.33
    
    var body: some View {
        /*:
         我们可以使用`Group`来创建多个View，在之后的章节中会专门讲解下Group。
         */
        VStack{
            /*:
             `Text`是最基础控件，可以用来展示文本信息，类似于UIKit中的UILabel。
             但是在swiftUI中并不能将两者进行等同，他们只是在功能上都是用来展示文本，其内部思想却差别很多。
             */
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .foregroundColor(.red)
                .bold()
                .font(.system(size: 23))
                .fontWeight(.light)
                .italic()
                .shadow(color: .green, radius: 7, x: 1, y: 2)
            
            /*:
             如果有专门的一组Text具备相同的特性：颜色、字体、阴影等等，
             可以使用一个`容器View`来设置这些属性，这里我们使用`VStack`来作为容器View。
             
             具体的VStack会在后续的章节中涉及到，这里只需要知道它可以将多个View在垂直方向上排布即可。
             */
            VStack{
                Text("Hello, World!")
                Text("·")
                /*:
                 需要注意的是，如果外部容器和自身View都设置了相同的属性，
                 比如这里的`foregroundColor`，结果将会以自身View设置的为结果。
                 这一点和HTML中为标签设置style样式是一致的：内联样式大于全局样式，符合`就近原则`。
                 */
                Text("swiftUI")
                    .foregroundColor(.green)
            }
            .foregroundColor(.purple)
            .font(.system(size: 30))
            .shadow(color: .red, radius: 3, x: 3, y: 2)
            
            /*:
             `Image`是swiftUI中用来展示图片的控件，只需要设置图片名称即可。
             swiftUI默认使用图片原始尺寸来展示，如果要使用固定图片来展示图片，
             需要使用`resizable`方法，然后使用`frame`指定图片的尺寸。
             */
            VStack {
                Image("icon_map_location")
                    .resizable()
                    .frame(width: 76/2.0, height: 86/2.0, alignment: .center)
                    .shadow(color: .red, radius: 3, x: 1, y: 1)
                    .border(Color.red, width: 2)
            }
            
            /*:
             `Button`是swiftUI中用来展示按钮的类型，这里提供了更灵活的构建方式，区别于UIButton以往UILabel+UIImageView两个展示控件，这里的Button可以在`label`函数中返回任意样式、任意内容的控件类型。
             
             一个Button除了要展示的内容，还要具备响应点击事件的能力，在swiftUI中，Button的初始化就包括这两者：样式（label）、事件（action）。
             */
            Button(action: {
                print("button did tap")
                toggleIsOn.toggle()
            }, label: {
                HStack {
                    Image("icon_map_location")
                        .resizable()
                        .frame(width: 38, height: 43, alignment: .center)
                    Text("Tap here")
                        .foregroundColor(.blue)
                        .font(.system(size: 34))
                        .bold()
                    Toggle(isOn: $toggleIsOn, label: {
                        Text("Toggle")
                            .foregroundColor(.orange)
                    })
                    .background(Color.pink)
                }
            })
            
            /*:
             `Toggle`用来展示开关控件，但是它只能展示成行元素，
             并不可以像Text、Image等那样使用。
             */
            Toggle(isOn: $toggleIsOn) {
                Text("Label")
            }
            .padding(20)
            
//            TextField.init(<#T##title: StringProtocol##StringProtocol#>, text: <#T##Binding<String>#>, onEditingChanged: <#T##(Bool) -> Void#>, onCommit: <#T##() -> Void#>)
        }
    }
}

struct Basic_Previews: PreviewProvider {
    static var previews: some View {
        Basic()
    }
}
