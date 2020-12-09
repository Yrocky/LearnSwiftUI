//
//  DoToggle.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/9.
//

import SwiftUI

struct DoToggle: View {
    
    @State var isOn = true
    
    var body: some View {
        VStack{
            /*:
             Toggle在swiftUI中用来表示开关控件，其属性也具备响应性，
             因此需要使用`@State`来修饰。同时还支持使用一个自定义的View来展示内容，
             由于Toggle、Stepper、Slider这些控件基本上都是在表单中使用，
             所以swiftUI中默认都会以行来表示。
             */
            Toggle(isOn: $isOn) {
                Text("Open Location")
            }
            .background(Color.pink)
            .padding(10)
            
            /*:
             便捷的使用字符串来创建一个Toggle，内部会转化为Text，
             和UISwitch所不同的是，Toggle并没有提供改变状态的事件回调，
             这是由于其可变的属性（isOn）已经具备响应性了，并不需要
             */
            Toggle("Show Rank Info", isOn:$isOn)
            
            /*:
             swiftUI对开关控件的自定义接口开放程度比UIKit高得多，
             我们可以通过`ToggleStyle`来自定义样式。
             
             swiftUI默认的左边一个Label、右边一个开关的样式，
             就是使用的`TitleOnlyLabelStyle`。
             
             `ToggleStyle`是一个协议，我们需要创建具体的类型来设置样式，
             另外系统内置开关的样式是使用了`SwitchToggleStyle`结构体，
             通过这个style，我们可以修改开关的颜色，仅此而已，因为系统只开放了这一个接口。
             
             */
            VStack {
                Toggle("Light mode", isOn: $isOn)
                    .toggleStyle(SwitchToggleStyle(tint: .red))
                
                /*:
                 我们自定义一个遵守`ToggleStyle`协议的类型，来实现一个单选开关
                 */
                Toggle("Dark mode", isOn: $isOn)
                    .toggleStyle(MyToggleStyle(onColor: .orange, offColor: .yellow))
                
                /*:
                 至于像UISwitch中修改多个颜色的功能，也是自定义ToggleStyle实现的，
                 具体需求需要编码。
                 */
            }
        }
    }
    
    /*:
     我们创建一个`MyToggleStyle`
     */
    struct MyToggleStyle: ToggleStyle {

        //: 虽然协议中是需要指明Body，但是这里指明之后会报错
//        typealias Body = Toggle
        
        var onColor = Color.green
        var offColor = Color.gray
        
        func makeBody(configuration: Configuration) -> some View {
            
            let imageName = configuration.isOn ? "checkmark.circle.fill" : "circle"
            return HStack {
                //: 打开这两个View，就可以的得到和系统一样的行样式的Toggle
//                configuration.label
//
//                Spacer()
//
                /*:
                 我们使用Image来自定义开关，做一个单选开关的样式，
                 通过为Image添加TapGesture来完成对isOn的修改
                 */
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(configuration.isOn ? onColor : offColor)
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
            }
            .padding(10)
            .border(Color.gray)
            
            //: 下面的代码是系统文档中的实例，没有什么自定义的特效
//            Toggle(configuration)
//                .padding(10)
//                .border(Color.purple)
        }
    }
}

struct DoToggle_Previews: PreviewProvider {
    static var previews: some View {
        DoToggle()
    }
}