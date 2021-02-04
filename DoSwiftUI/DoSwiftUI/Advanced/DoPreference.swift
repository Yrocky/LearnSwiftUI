//
//  DoPreference.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/17.
//

import SwiftUI

struct DoPreference: View {
    
    @State private var activeIndex = 0
    @State private var rects = [CGRect.zero]
        
    var body: some View {
        
        ExampleContainerView("Preference") {
            
            doMonthView
            
            doEqualWidthText
            
            doTree
        }
    }
    
    var doMonthView: some View {
        
        VExampleView() {
            
            ZStack(alignment: .topLeading){
                
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.orange)
                    .border(Color.green, width: 2)
                    .frame(width: rects[activeIndex].size.width, height: rects[activeIndex].size.height)
                    .offset(x: rects[activeIndex].minX, y: rects[activeIndex].minY)
                    .animation(.easeInOut(duration: 0.25))
                
                VStack(alignment: .center){
                    MonthView(activeIndex: $activeIndex, month: "a", index: 0)
                    MonthView(activeIndex: $activeIndex, month: "aaaaaa", index: 1)
                    MonthView(activeIndex: $activeIndex, month: "aaa", index: 2)
                    MonthView(activeIndex: $activeIndex, month: "aaaaaaaaaa", index: 3)
                    MonthView(activeIndex: $activeIndex, month: "aaaaaa", index: 4)
                }
                .onPreferenceChange(MonthView.Key.self){ value in
                    self.rects.removeAll()
                    self.rects.append(contentsOf: value.map{$0.rect})
                }
            }
            .coordinateSpace(name: "container")
        }
    }
    
    @State private var maxTextWidth: CGFloat?
    
    var doEqualWidthText: some View {
        VExampleView("equal width") {
         
            /*:
             对于一组文本，我们期望所有的视图都与最长文本宽度一致。比如下面最长的文本为`is an iOS Enginner`，其余三个的宽度都需要和它一致，但是目前这样的效果是宽度参差不齐。
             
             ```swift
             Group{
                 
                 Text("Hi")
                 Text("I'm Rocky,")
                 Text("is an iOS Enginner")
                 Text(".")
             }
             .padding(.horizontal, 5)
             .font(.system(size: 20, design: .rounded))
             .foregroundColor(.white)
             .background(Color.pink)
             .cornerRadius(5)
             ```
             如果要让所有文本宽度和最大的一致，首先我们需要获取到文本的宽度，可以通过`background`+`GeometryReader`得到View的内容尺寸。这还不够，我们还需要知道所有文本的内容尺寸，并且比较出来一个最大的值，这就还需要用到`PreferenceKey`，通过它来记录、比较每一个文本的尺寸，最终获取到最大的值。
             
             我们创建一个`MaxTextWidthPreferenceKey`来记录比较各个文本的宽度。
             
             ```swift
             struct MaxTextWidthPreferenceKey: PreferenceKey {
                 
                 typealias Value = CGFloat
                 static var defaultValue: Value = 0
                 
                 static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
                     value = max(value, nextValue())
                 }
             }
             ```
             
             然后通过background、GeometryReader记录下每个文本的宽度，其中使用`Color.clear`返回一个不可见的View来记录，并且将Text包裹到中VStack，通过它的`onPreferenceChange`方法监听宽度的变化，将变化使用`maxTextWidth`这个变量来记录。具体实现如下：
             
             ```swift
             VStack{
                 Group{
                    ...
                 }
                 .frame(width: maxTextWidth)
                 .background(
                     GeometryReader{ proxy in
                         Color.clear
                             .preference(
                                 key: MaxTextWidthPreferenceKey.self,
                                 value: proxy.size.width
                             )
                     }
                 )
                 ...
             }
             .onPreferenceChange(MaxTextWidthPreferenceKey.self) {
                 self.maxTextWidth = $0
             }
             ```
             
             这样就完成了获取文本宽度、比较宽度得到最大值、容器监听到最大值并存储、将最大值
             */
            VStack(spacing: 5){
                
                Group{
                    Text("Hi")
                    Text("I'm Rocky,")
                    Text("an iOS Enginner")
                    Text(".")
                }
                .padding(.horizontal, 5)
                .background(
                    GeometryReader{ proxy in
                        Color.clear
                            .preference(
                                key: MaxTextWidthPreferenceKey.self,
                                value: proxy.size.width
                            )
                    }
                )
                .frame(width: maxTextWidth)
                .font(.system(size: 20, design: .rounded))
                .foregroundColor(.white)
                .background(Color.pink)
                .cornerRadius(5)
            }
            .onPreferenceChange(MaxTextWidthPreferenceKey.self) {
                self.maxTextWidth = $0
            }
        }
    }
    
    var doTree: some View {
        VExampleView("tree") {
            
        }
    }
    struct MaxTextWidthPreferenceKey: PreferenceKey {
        
        typealias Value = CGFloat
        static var defaultValue: Value = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = max(value, nextValue())
        }
    }
    
    struct Node {
        
    }
}

struct MonthView: View {
    
    @Binding var activeIndex: Int
    let month: String
    let index: Int
    
    var body: some View {
        Text(month)
            .padding()
            .font(.system(size: 20))
            .foregroundColor(.blue)
            .background(BackgroundView())
            .onTapGesture { self.activeIndex = self.index }
    }

    struct BackgroundView: View {
        
        var body: some View{
            GeometryReader{ proxy in
                Rectangle()
                    .fill(Color.clear)
                    .preference(
                        key: Key.self,
                        value: [Data(rect: proxy.frame(in: .named("container")))])
            }
        }
    }
    
    struct Data: Equatable {
        let rect: CGRect
    }
    
    struct Key: PreferenceKey {
        
        typealias Value = [Data]
        
        static var defaultValue: Value = []
        
        static func reduce(value: inout Value, nextValue: () -> Value) {
            value.append(contentsOf: nextValue())
        }
    }
}

struct DoPreference_Previews: PreviewProvider {
    static var previews: some View {
        DoPreference()
    }
}
