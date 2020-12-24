//
//  DoGroupBox.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/17.
//

import SwiftUI

struct DoGroupBox: View {
    
    var body: some View {
        /*:
         `GroupBox`可以很方便的为我们提供一个卡片视图，
         支持三种初始化方式：`label+content`、`content`、`config`。
         其中label和content是some View，
         而config是`GroupBoxStyleConfiguration`类型，
         提供两个内部的View：Label、Content，分别对应GroupBox中的label和content。
         */
        ExampleContainterView("GroupBox") {
            
            doBasic
            
            doOnlyContent
            
            doCustomGroupBoxStyle
            
            doGroupBoxInScrollView
        }
    }
    
    var doBasic: some View {
        /*:
         使用label+content创建的GroupBox会发现label是偏左，content居中的样式，
         另外，swiftUI已经为我们设置了圆角，
         以及默认的背景颜色（systemGroupedBackground）。
         */
        VExampleView("基础用法") {
            
            GroupBox(
                label: Text("Label")
                    .font(.system(size: 24))
                    .foregroundColor(.orange)
            ) {
                Text("Content")
            }
        }
    }
    
    var doOnlyContent: some View {
        /*:
         另外会发现，只有content的时候默认的GroupBox尺寸会比较小，
         这很好理解，因为没有了label在水平和垂直方向上的尺寸拓展。
         */
        VExampleView("只显示 content ") {
            
            GroupBox{
                Text("Content")
            }
        }
    }
    
    var doCustomGroupBoxStyle: some View {
        /*:
         GroupBox也为我们提供了自定义样式的`GroupBoxStyle`协议，
         通过这个协议我们可以创建独特的卡片。
         */
        VExampleView("使用自定义的 GroupBoxStyle ") {
            
            GroupBox(
                label: Text("Label")
                    .font(.system(size: 29))
                    .foregroundColor(.pink)
            ) {
                Text("Content")
            }
            .groupBoxStyle(HomeworkBoxStyle(colors: [.blue, .orange, .green]))
        }
    }
    
    var doGroupBoxInScrollView: some View {
        /*:
         默认GroupBox是在水平方向上撑满屏幕，但是如果放在一个ScrollView+HStack的容器中，
         GroupBox的宽度就由label和content来撑起，两者取最宽的值。
         */
        
        VExampleView("在 ScrollView 中使用 GroupBox ") {
            
            ScrollView(.horizontal){
                /*:
                 虽然我们指定了ScrollView为水平方向滑动，
                 但是由于其内部是按照垂直方向添加子View的，
                 因此，如果不使用LazyHStack来布局，就会按照默认的垂直排列子View。
                 */
                LazyHStack{
                    ForEach(1..<10){
                        /*:
                         并且由于HStack的影响，GroupBox默认的label、content居左将会变成`居中`显示。
                         */
                        GroupBox(label: Text("\($0)Label").border(Color.red)) {
                            Text("This is a looooong content")
                                .border(Color.orange)
                        }
                    }
                }
            }
        }
    }
    
    struct HomeworkBoxStyle: GroupBoxStyle {
        
        let colors: [Color]
        
        func makeBody(configuration: Configuration) -> some View {
            HStack{
                
                VStack(alignment: .leading){
                    configuration.label
                    configuration.content
                }
                
                Spacer()
                
                Image(systemName: "clock.fill").foregroundColor(.white)
            }
            .padding()
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        
        var background: some View{
            LinearGradient(gradient: Gradient(colors: colors),
                           startPoint: .leading,
                           endPoint: .trailing)
        }
    }
}

struct DoGroupBox_Previews: PreviewProvider {
    static var previews: some View {
        DoGroupBox()
    }
}
