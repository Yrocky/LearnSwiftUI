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
        
        ExampleContainterView("Toggle") {
            /*:
             Toggle在swiftUI中用来表示开关控件，其属性也具备响应性，
             因此需要使用`@State`来修饰。同时还支持使用一个自定义的View来展示内容，
             由于Toggle、Stepper、Slider这些控件基本上都是在表单中使用，
             所以swiftUI中默认都会以行来表示。
             */
            doTextToggle
            
            doStringToggle
            
            doSystemToggleStyle
            
            doMyToggleStyle
            
            doMyRectangleToggleStyle
        }
    }
    
    var doTextToggle: some View {
        
        VExampleView("基础用法") {
            Toggle(isOn: $isOn) {
                Text("Open Location")
            }
            .background(Color.orange)
        }
    }
    
    var doStringToggle: some View {
        /*:
         便捷的使用字符串来创建一个Toggle，内部会转化为Text，
         和UISwitch所不同的是，Toggle并没有提供改变状态的事件回调，
         这是由于其可变的属性（isOn）已经具备响应性了，并不需要
         */
        VExampleView("使用 String 作为 label 进行显示") {
            Toggle("Show Rank Info", isOn:$isOn)
        }
    }
    
    var doSystemToggleStyle: some View {
        /*:
         swiftUI对开关控件的自定义接口开放程度比UIKit高得多，
         我们可以通过`ToggleStyle`来自定义样式。
         
         swiftUI默认的左边一个Label、右边一个开关的样式，
         就是使用的`TitleOnlyLabelStyle`。
         
         `ToggleStyle`是一个协议，我们需要创建具体的类型来设置样式，
         
         */
        VExampleView("系统内置的 ToggleStyle ") {
            
            Toggle("Default style", isOn: $isOn)
                .toggleStyle(DefaultToggleStyle())

            /*:
             另外通过`SwitchToggleStyle`，我们可以修改开关的颜色，
             仅此而已，因为系统只开放了这一个接口。
             */
            Toggle("Switch toggle style", isOn: $isOn)
                .toggleStyle(SwitchToggleStyle(tint: .red))
        }
    }
    
    var doMyToggleStyle: some View {
        
        /*:
         我们自定义一个遵守`ToggleStyle`协议的类型，来实现一个单选开关
         */
        VExampleView("自定义 ToggleStyle，不显示 label") {
            
            Toggle("Dark mode", isOn: $isOn)
                .toggleStyle(MyToggleStyle(onColor: .orange, offColor: .yellow))
        }
    }
    
    var doMyRectangleToggleStyle: some View {
        /*:
         至于像UISwitch中修改多个颜色的功能，也是自定义ToggleStyle实现的，
         具体需求需要编码。
         */
        
        VExampleView("自定义特殊风格的 ToggleStyle ") {
            
            Toggle(isOn:$isOn){
                Text("飞行模式")
            }
            .toggleStyle(MyRectangleToggleStyle(
                width: 100,
                offColor: .green,
                thumColor: .orange
            ))
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
    
    //: 接下来我们快速的创建一个方形的开关
    struct MyRectangleToggleStyle: ToggleStyle {
        
        var width: CGFloat = 50.0
        var cornerRadius: CGFloat = 4.0
        
        var onColor = Color.red
        var offColor = Color.gray
        var thumColor = Color.white
        
        func makeBody(configuration: Configuration) -> some View {
            
            let alignment = configuration.isOn ?
                Alignment.trailing :
                Alignment.leading
            
            let toggleColor = configuration.isOn ?
                onColor: offColor
            
            return HStack {
                
                configuration.label

                Spacer()
                
                ZStack(alignment: alignment) {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: width, height: width / 3)
                        .foregroundColor(toggleColor)
                    
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: width * 0.45, height: width * 0.25)
                        .padding(4)
                        .foregroundColor(thumColor)
                }
                .onTapGesture {
                    withAnimation {
                        configuration.isOn.toggle()
                    }
                }
            }
            .padding(10)
            .background(Color.gray)
        }
    }
}

//: https://zhuanlan.zhihu.com/p/149836622
struct DoToggle_Previews: PreviewProvider {
    static var previews: some View {
        DoToggle()
    }
}
