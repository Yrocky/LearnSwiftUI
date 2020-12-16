//
//  DoText.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/9.
//

import SwiftUI

struct DoText: View {
    
    @State var text = ""
    
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
            
            let longText = "Use this initializer to create a stepper that increments or decrements a binding to value by the step size you provide within the given bounds. By setting the bounds, you ensure that the value never goes below or above the lowest or highest value, respectively."
            /*:
             swiftUI为View拓展了一些关于文本显示的方法，分类叫做`Adjusting Text in a View`，
             让View具有了比如行数限制、行间距等。
             
             设置了最大行数之后，如果文本超出行数，将以`...`显示
             */
            VStack{
                //: 最大行数
                Text(longText)
                    .padding()
                    .frame(width: 300, height: 80)
                    .lineLimit(2)
                    .background(Color.orange)
                
                //: 省略的位置
                Text(longText)
                    .lineLimit(1)
                    .truncationMode(.head)
                    .background(Color.orange)
                
                
                //: 行间距
                Text(longText)
                    .lineLimit(2)
                    .lineSpacing(12)
                    .padding()
                    .background(Color.orange)
                
                HStack{
                    Text("This is long text will be fit")
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                    
                    TextField("Here is your", text:$text)
                }
            }
            
        }
    }
}

struct DoAttributedText: View {
    var body: some View{
        VStack{
            /*:
             在上面有提及到为Text设置下划线、行间距等属性，
             这些在UIKit中我们称作属性字符串，使用UIAttributedString来表示，
             但是在swiftUI中并没有一个专门的类型来展示属性字符串，
             可以使用的就是上面提到的几个modifer。
             
             通过观察开发文档会发现，这些方法除了是Text的拓展方法，有一部分也是View的拓展方法。
             
             为Text添加的拓展返回的是一个新的`Text`：
             
             ``` swift
             foregroundColor(:) -> Text
             font(:) -> Text
             
             fontWeight(:) -> Text
             bold() -> Text
             italic() -> Text
             strikethrough(active:, color:) -> Text
             underline(active:, color:) -> Text
             kerning(:) -> Text
             tracking(:) -> Text
             baselineOffset(:) -> Text
             ```
             
             以`foregroundColor()`和`font()`为例，
             View的拓展中也有这两个方法，
             只不过他们返回的是`some View`，而Text的拓展返回的是`Text`，
             这两个方法会对View中的Text统一作用，比如下面的VStack中的两个Text都具有同样的字体和颜色。
             */
            
            VStack{
                Text("AAA")
                Button(action: {}, label: {
                    Text("Button")
                })
            }
            .font(.system(size: 12))
            .foregroundColor(.blue)
            
            /*:
             
             在swift5.1版本中，swiftUI允许我们使用`+`来链接Text，比如下面这样：
             
             ```swift
             Text("aaa").foregroundColor(.red) + Text("bbb").foregroundColor(.green)
             ```
             */
            
            Text("aaa").foregroundColor(.red) + Text("bbb").foregroundColor(.green)
            
            /*:
             因此我们可以根据这样的特性，使用Text来生成`属性字符串View`，比如叫做`AttributedText`。
             */
        }
    }
    
    struct AttributedText: View {
        
        let attributeString: NSAttributedString
        
        init(_ attributeString: NSAttributedString) {
            self.attributeString = attributeString
        }
        
        var body: some View{
            var text = Text("")
            attributeString.enumerateAttributes(in: NSRange(location: 0, length: attributeString.string.count), options: []) { (attrs, range, _) in
                
                var t = Text(attributeString.attributedSubstring(from: range).string)
                
                if let color = attrs[NSAttributedString.Key.foregroundColor] as? UIColor {
                    t = t.foregroundColor(Color(color))
                }
                
                text = text + t
            }
            return text
        }
    }
}

struct DoText_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            DoText()
            DoAttributedText()
        }
    }
}
