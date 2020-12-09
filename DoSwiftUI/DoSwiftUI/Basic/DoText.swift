//
//  DoText.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/9.
//

import SwiftUI

struct DoText: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            /*:
             `Text`除了前面讲的可以展示文本，其还可以实现UIKit中属性字符串的功能
             */
            
            /*:
             使用`textCase`将显示的文本在大小写之间切换，
             .uppercase，将文本全部转成大写
             .lowercase，将文本全部转成小写
             */
            HStack {
                Text("Hello").textCase(.uppercase)
                Text("Hello").textCase(.lowercase)
            }
            
            /*:
             `strikethrough`可以为Text中的文本提供默认的击穿效果（删除线），
             同时还可以使用变种方法来设置击穿线的颜色、作用与否，
             这里的active并不是一个Bind属性，也就是说这个不具备响应式的功能。
             */
            HStack{
                Text("World")
                    .strikethrough()
                Text("swiftUI")
                    .strikethrough(true, color: .orange)
            }
            
            /*:
             使用`underline`实现下划线，下划线的功能和特性与击穿线类似
             */
            HStack {
                Text("MMM")
                    .underline()
                Text("ABC")
                    .underline(true, color: .red)
            }
            
            /*:
             `kerning`用来设置文本的显示间距，而`tracking`也可以用来设置文本之间的间距，
             两者的区别是tracking是为字符串之间添加空格，而kerning是改变字符串的偏移量。
             
             如果对一个Text同时使用了这两个修饰符，结果将会是忽略掉kerning，而使用tracking。
             */
            HStack{
                Text("AAA").kerning(3)
                Text("AAA").kerning(-3)
                Text("BBB").tracking(3)
                Text("BBB").tracking(-3)
            }
            
            /*:
             `baselineOffset`可以用来调整文本的基线偏移量，
             正数向上偏移
             负数向下偏移
             */
            HStack(alignment: .top, spacing: 10) {
                
                Text("Hello")
                    .border(Color.red)
                Text("Hello")
                    .baselineOffset(10)
                    .border(Color.red)
                Text("World")
                    .baselineOffset(-6)
                    .border(Color.red)
            }
        }
    }
}

struct DoText_Previews: PreviewProvider {
    static var previews: some View {
        DoText()
    }
}
