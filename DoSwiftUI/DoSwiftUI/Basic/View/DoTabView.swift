//
//  DoTabView.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/27.
//

import SwiftUI

struct DoTabView: View {
    var body: some View {
        ExampleContainerView("TabView") {
            
//            doNormal
//
//            doHashable
//
//            doSelection
//
//            doTabViewStyle
//
//            doIndexViewStyle
            
            doCustomPageIndex
            
//            doCustomTabView
            
//            doCreateWithArray
        }
    }
    
    var doNormal: some View {
        VExampleView("default use", height: 200) {
            
            TabView{
                PageView(text: "View A", color: .orange)
                    .tabItem {
                        Text("A")
                    }
                
                PageView(text: "View B", color: .green)
                    .tabItem {
                        Text("B")
                    }
            }
        }
    }
    
    @State private var selectedIndex: Int = 2
    var doSelection: some View {
        VExampleView("selection", height: 200) {
            
            /*:
             TabView可以使用`selection`来记录哪个item被选中，通过头文件我们知道，它是`Binding<SelectionValue>`类型的，而`SelectionValue`又必须是遵守`Hashable`协议。
             
             ``` swift
             struct TabView<SelectionValue, Content> : View where SelectionValue : Hashable, Content : View {

                 public init(selection: Binding<SelectionValue>?, @ViewBuilder content: () -> Content)
             }
             ```
             
             */
            TabView(selection: $selectedIndex) {
                
                PageView(text: "View A", color: .orange)
                    .tabItem(1) {
                        Text("A")
                    }
                PageView(text: "View B", color: .green)
                    .tabItem(2) {
                        Text("B")
                    }
            }
        }
    }
    
    enum TabItemOption: Hashable {
        case one
        case two
        case three
    }
    
    @State private var selectionOption: TabItemOption = .three
    
    var doHashable: some View {
        VExampleView("Hashable", height: 200) {
            
            TabView(selection: $selectionOption) {
                PageView(text: "View A", color: .orange)
                    .tabItem(TabItemOption.one) {
                        Text("A")
                    }
                PageView(text: "View B", color: .green)
                    .tabItem(TabItemOption.two) {
                        Text("B")
                    }
                PageView(text: "View C", color: .pink)
                    .tabItem(TabItemOption.three) {
                        Text("C")
                    }
            }
        }
    }
    
    @State private var pageOption: TabItemOption = .two
    
    var doTabViewStyle: some View {
        VExampleView("TabViewStyle", version: "2.0", height: 200) {
            /*:
             在SwiftUI1.0的时候并没有`TabViewStyle`，它是在iOS14.0之后添加的，很迷的一点是，提供了一个iOS13.0下的`DefaultTabViewStyle`，协议比具体的结构体要晚，这是怎么做到的？
             
             ```swift
             @available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
             public protocol TabViewStyle {}

             @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 7.0, *)
             public struct DefaultTabViewStyle : TabViewStyle {}
             
             @available(iOS 14.0, tvOS 14.0, watchOS 7.0, *)
             public struct PageTabViewStyle : TabViewStyle {}
             ```
             
             先不管这个如何配置版本的，在iOS14.0之后，增加了一个`PageTabViewStyle`，使用这个我们可以创建分页效果。
             具体的效果如下图所示。
             
             // todo 图片
             
             但是目前为我们提供可以用来自定义的内容不是很多，只有一个决定是都显示指示索引的`indexDisplayMode`。
             */
            
            TabView(selection: $pageOption) {
                PageView(text: "A", color: .orange)
                    .tag(TabItemOption.one)
                PageView(text: "B", color: .green)
                    .tag(TabItemOption.two)
                PageView(text: "C", color: .pink)
                    .tag(TabItemOption.three)
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
    
    var doIndexViewStyle: some View {
        
        VExampleView("indexViewStyle", version:"2.0", height: 200) {
            /*:
             `IndexViewStyle`也是iOS14.0之后新增加的，主要用来作为`IndexView`的索引指示，但是我找遍了文档也没有找到IndexView这个类型。目前遵守这个协议的只有一个`PageIndexViewStyle`，通过它可以修改索引的底部展示样式。与TabViewStyle一样，其他具体更多的内容系统并没有提供。
             */
            TabView() {
                PageView(text: "A", color: .orange)
                PageView(text: "B", color: .green)
                PageView(text: "C", color: .pink)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }

    var doCustomPageIndex: some View {
        VExampleView("custom page index", version:"2.0", height: 200) {
            /*:
             TabView的`PageTabViewStyle`可以为我们提供分页效果，但是并没有提供隐藏pageControl控件的方法，
             另外，通过`.onAppear`会发现其Appear以及Disappear并不是想象中的效果。
             */
            TabView() {
                PageView(text: "A", color: .orange)
                PageView(text: "B", color: .green)
                PageView(text: "C", color: .pink)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
        }
    }
    
    var doCustomTabView: some View {
        VExampleView("custom TabView", height: 200) {
            /*:
             实现一个具有中国产品风格的TabView
             */
            TabView(selection: $selectedIndex) {
                PageView(text: "A", color: .orange)
                    .tabItem(TabItemOption.one) {
                        Text("A")
                    }
                PageView(text: "B", color: .green)
                    .tabItem(TabItemOption.two) {
                        Text("B")
                    }
                PageView(text: "C", color: .pink)
                    .tabItem(TabItemOption.three) {
                        Text("C")
                    }
            }
            .overlay(CustomTabView(), alignment: .bottom)
        }
    }
    
    struct CustomTabView: View {
//        @Binding var selectedIndex: Hashable
        // 点击
        var body: some View{
            Color.red
                .edgesIgnoringSafeArea(.bottom)
                .frame(height: 50)// 83: 49
                .overlay(
                    HStack{
                        Button("a") {
                            
                        }
                        Button("b") {
                            
                        }
                        Button("c") {
                            
                        }
                    }
                )
        }
    }
    
    let pages : [PageView] = [
        PageView(text: "Orange", color: .orange, index: 0),
        PageView(text: "Pink", color: .pink, index: 1),
        PageView(text: "Green", color: .green, index: 2)
    ]
    
    @State private var arraySelectedIndex: Int = 0
    
    var doCreateWithArray: some View {
        VExampleView("array", height: 200) {
            /*:
             使用Array创建的TabView的时候，必须设置tag，用来体现唯一性
             */
            TabView(selection: $arraySelectedIndex) {
                ForEach(pages) { page in
                    page
                        .tabItem(page.index) {
                            Text(page.text)
                        }
                }
            }
        }
    }
}


struct PageView: View {
    var text: String
    var color: Color
    var index: Int = 0
    
    var body: some View{
        color
            .overlay(
                Text(text)
                    .foregroundColor(.white)
                    .font(.system(size: 20))
            )
            .onAppear {
                print("appear \(text)")
            }
            .onDisappear {
                print("disappear \(text)")
            }
    }
}

extension PageView: Identifiable {
    var id: UUID {
        UUID()
    }
}

extension PageView: Hashable {
    
}

extension View {
    /*:
     同时设置tag以及tabItem的展示内容
     */
    func tabItem<T,V>(_ tag: T, @ViewBuilder _ label: () -> V) -> some View where T: Hashable, V : View{
        self.tabItem(label)
            .tag(tag)
    }
}
struct DoTabView_Previews: PreviewProvider {
    static var previews: some View {
        DoTabView()
    }
}
