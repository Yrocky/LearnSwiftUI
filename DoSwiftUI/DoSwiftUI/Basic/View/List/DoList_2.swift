//
//  DoList_2.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/25.
//

import SwiftUI

struct DoList_2: View {
    var body: some View {
        
        ExampleContainterView("List") {
         
            doSomeViewModifer
            
            doListStyle
        }
    }
    
    @State private var sliderValue = 0.28
    
    @State private var topInset : CGFloat = 0
    @State private var leadingInset : CGFloat = 0
    @State private var bottomInset : CGFloat = 0
    @State private var trailingInset : CGFloat = 0
    
    var doSomeViewModifer: some View {
        
        VStack{
            
            VExampleView("listRowBackground", height: 200) {
                /*:
                 通过`listRowBackground`可以对每个Cell设置背景显示样式，可以是任意的View。
                 */
                List{
                    ForEach(0..<10) { index in
                        Text("\(index)")
                            .listRowBackground(ListRowBackgroundView(index))
                    }
                }
            }
            
            VExampleView("listItemTint", height: 200) {
                /*:
                 `listItemTint`在iOS上只能作用于Label的icon上，
                 */
                
                List{
                    ForEach(0..<10) { index in
                        HStack{
                            
                            Image("icon_tecxture_\(index)")
                                .resizable()
                                .frame(width: 40, height: 40)
                            
                            VStack(alignment: .leading){
                                
                                Text("NO.\(index)")
                                    .font(.system(size: 17))
                                    .foregroundColor(.orange)
                                
                                Label {
                                    Text("this is \(index)")
                                        .foregroundColor(.gray)
                                } icon: {
                                    Image(systemName: "0\(index).circle.fill")
                                }
                                
                                Slider(value: $sliderValue)
                                
                                ProgressView(value: 0.2)
                            }
                            
                            Spacer()
                        }
                        .listItemTint(.purple)
                    }
                }
            }
            
            VExampleView("listRowInsets", height: 300) {
                
                /*:
                 通过修改`listRowInsets`，我们可以让List的Row向内或向外进行伸缩。
                 */
                List {
                    ForEach(0..<3) { index in
                        ItemView("NO.\(index)")
                            .listRowBackground(Color.green)
                            .listRowInsets(EdgeInsets(
                                            top: topInset,
                                            leading: leadingInset,
                                            bottom: bottomInset,
                                            trailing: trailingInset))
                    }
                }
                
                ItemEdgeInsetsSlider(title: "top", value: $topInset)
                
                ItemEdgeInsetsSlider(title: "leading", value: $leadingInset)
                
                ItemEdgeInsetsSlider(title: "bottom", value: $bottomInset)
                
                ItemEdgeInsetsSlider(title: "trailing", value: $trailingInset)
            }
        }
    }
    
    var doListStyle: some View {
        
        /*:
         swiftUI为List提供了内置的几种展示样式，通过调用`listStyle`，
         传递一个遵守`ListStyle`协议的实例，即可修改List的展示样式，目前内置的样式有：
         
         * DefaultListStyle
         * PlainListStyle
         * GroupedListStyle
         * EllipticalListStyle（WatchOS）
         * CarouselListStyle（WatchOS）
         * SidebarListStyle（2.0）
         * InsetListStyle（2.0）
         * InsetGroupedListStyle（2.0）

         */
        
        VStack{
            
            HScrollExampleView("DefaultListStyle", height: 200) {
                
                /*:
                 `DefaultListStyle`和`PlainListStyle`本质上是同一种样式，也是系统默认的样式。
                 */
                ListView()
                    .listStyle(DefaultListStyle())
                
                ListView(sectionCount: 3)
                    .listStyle(DefaultListStyle())
            }
            
            
            HScrollExampleView("PlainListStyle", height: 200) {
                
                ListView()
                    .listStyle(PlainListStyle())
                
                ListView(sectionCount: 3)
                    .listStyle(PlainListStyle())
            }
            
            
            HScrollExampleView("GroupedListStyle", height: 200) {
                
                /*:
                 `GroupedListStyle`是UITableView中GroupStyle的一个实现，
                 */
                ListView(sectionCount: 3)
                    .listStyle(GroupedListStyle())
                
                ListView()
                    .listStyle(PlainListStyle())
            }
            
            HScrollExampleView("SidebarListStyle", version: "2.0", height: 200) {
                
                /*:
                 `SidebarListStyle`这个样式与前面`DisclosureGroup&OutlineGroup`的有关系，
                 即使设置了footer，也不会显示。
                 并且与DisclosureGroup&OutlineGroup不同的是，
                 整个header都可以点击，通过点击以开启、关闭对应的Row。
                 */
                ListView(sectionCount: 3)
                    .listStyle(SidebarListStyle())
                
                ListView()
                    .listStyle(PlainListStyle())
            }
            
            HScrollExampleView("InsetListStyle", version: "2.0", height: 200) {
                /*:
                 `InsetListStyle`可以使List内的View向内缩，
                 这个和使用`listRowInsets`修改单个Row不同，header、footer都会内缩。
                 */
                ListView(sectionCount: 3)
                    .listStyle(InsetListStyle())
                
                ListView()
                    .listStyle(PlainListStyle())
            }
            
            HScrollExampleView("InsetGroupedListStyle", version: "2.0", height: 200) {
                
                /*:
                 `InsetGroupedListStyle`可以让我们创建的List拥有成组圆角，以及整体内缩。
                 */
                ListView(sectionCount: 3)
                    .listStyle(InsetGroupedListStyle())
                
                ListView()
                    .listStyle(PlainListStyle())
            }
        }
    }
    
    struct ItemView: View {
        
        let text: String
        
        init(_ text: String) {
            self.text = text
        }
        
        var body: some View {
            
            HStack(spacing: 0){
                
                Text(text)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .frame(height: 30)
                    .border(Color.gray)
                
                Spacer()
            }
            .border(Color.red)
        }
    }
    
    struct ListRowBackgroundView: View {
        
        var index: Int
        
        init(_ index: Int) {
            self.index = index
        }
        
        var body: some View {
            
            // Image
//            Image("icon_tecxture_\(index)")
            
            // Rectangle
            Rectangle()
                .fill(color)
        }
        
        var color: Color {
            [Color.red, Color.green, Color.orange,
             Color.purple, Color.blue, Color.pink
            ].randomElement()!
        }
    }
    
    
    struct ItemEdgeInsetsSlider: View {
        
        let title: String
        @Binding var value: CGFloat
        
        var body: some View{
            HStack{
                
                Text(title)
                    .font(.system(size: 16))
                    .frame(width: 60, alignment: .leading)
                
                Slider(value: $value, in: -10...20, step: 1)
                
                Text("\(value)")
                    .font(.system(size: 13))
                    .frame(width: 40)
            }
        }
    }
    
    struct ListView: View {
        
        let sectionCount: Int
        let rowCount: Int
        
        init(sectionCount: Int = 1, rowCount: Int = 5) {
            self.sectionCount = sectionCount
            self.rowCount = rowCount
        }
        
        var body: some View {
            
            List{
                
                ForEach(0..<sectionCount) { section in
                    
                    Section(header: Text("Header-\(section)"),
                            footer: Text("Footer-\(section)")) {
                        ForEach(0..<rowCount) { row in
                            Text("Cell {\(section),\(row)}")
                        }
                    }
                }
            }
            .frame(width: 300)
        }
    }
}

struct DoList_2_Previews: PreviewProvider {
    static var previews: some View {
        DoList_2()
    }
}
