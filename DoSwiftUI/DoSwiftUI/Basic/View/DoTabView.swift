//
//  DoTabView.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/27.
//

import SwiftUI

struct DoTabView: View {
    var body: some View {
        ExampleContainterView("TabView") {
            
            doNormal
            
            doHashable
            
            doSelection
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
                    .tabItem {
                        Text("A")
                    }
                    .tag(1)
                
                PageView(text: "View B", color: .green)
                    .tabItem {
                        Text("B")
                    }
                    .tag(2)
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
                    .tabItem {
                        Text("A")
                    }
                    .tag(TabItemOption.one)
                
                PageView(text: "View B", color: .green)
                    .tabItem {
                        Text("B")
                    }
                    .tag(TabItemOption.two)
                
                PageView(text: "View C", color: .pink)
                    .tabItem {
                        Text("C")
                    }
                    .tag(TabItemOption.three)
            }
        }
    }
    
    struct PageView: View {
        var text: String
        var color: Color
        
        var body: some View{
            color
                .overlay(
                    Text(text)
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                )
        }
    }
}

struct DoTabView_Previews: PreviewProvider {
    static var previews: some View {
        DoTabView()
    }
}
