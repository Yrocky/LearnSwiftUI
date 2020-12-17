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
        VStack{
            /*:
             使用label+content创建的GroupBox会发现label是偏左，content居中的样式，
             另外，swiftUI已经为我们设置了圆角，
             以及默认的背景颜色（systemGroupedBackground）。
             */
            GroupBox(
                label: Text("Label")
                    .font(.system(size: 24))
                    .foregroundColor(.orange)
            ) {
                Text("Content")
            }
            .padding()
            
            /*:
             另外会发现，只有content的时候默认的GroupBox尺寸会比较小，
             这很好理解，因为没有了label在水平和垂直方向上的尺寸拓展。
             */
            GroupBox{
                Text("Content")
            }
            
            
//            GroupBox.init(GroupBoxStyleConfiguration.ini)
            
            /*:
             GroupBox也为我们提供了自定义样式的`GroupBoxStyle`协议，
             通过这个协议我们可以创建独特的卡片
             */
            GroupBox(
                label: Text("Label")
                    .font(.system(size: 29))
                    .foregroundColor(.pink)
            ) {
                Text("Content")
            }
            .padding()
            .groupBoxStyle(HomeworkBoxStyle(colors: [.blue, .orange, .green]))
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
