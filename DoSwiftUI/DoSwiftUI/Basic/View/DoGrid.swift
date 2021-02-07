//
//  DoGrid.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/25.
//

import SwiftUI

struct DoGrid: View {
    var body: some View {
        ExampleContainerView("Grid", version: "2.0") {
         
//            doBasic
//
//            doAdaptive
            
            doGridItem
            
//            doInScrollView
//
//            doSection
//
//            doPinnedScrollableViews
        }
    }
    
    var doBasic: some View {
        VExampleView("基础用法") {
            /*:
             swiftUI在iOS14.0之后，
             终于提供了对应UIKit中UICollectionView的控件：
             `LazyVGrid`、`LazyHGrid`，这次一步到位，
             直接使用Lazy来标识该组件会对内部的View进行懒加载，
             为使行文流畅，除非特殊指明，下文以Grid来表示两者。
             
             Grid的创建要依赖于`GridItem`，GridItem是对每一个`子View尺寸`、
             每个子View之间的`间距`、`排列`的抽象，同时使用三种尺寸约束：
             * fixed，在LazyVGrid中作用的是`固定宽度`，在LazyHGrid中作用的是`固定高度`
             * flexible，可以设置最大值以及最小值，对应的Row会根据当前行或者当前列中剩余宽度、高度弹性的调整，
             * adaptive，
             
             GridItem会被以数组的形式，应用于Grid的初始化中，
             在LazyVGrid中数组个数表示`列数`，LazyHGrid中数组个数表示`行数`。
             
             */
            
            LazyVGrid(
                columns: [
                    .init(.fixed(60), spacing: 5, alignment: .leading),
                    .init(.flexible(), spacing: 5, alignment: .center),
                    .init(.fixed(60), spacing: 5, alignment: .center),
                    .init(.flexible(), spacing: 0, alignment: .trailing),
                ],
                alignment: .center,
                spacing: 10
            ) {
                ForEach(0..<16) { index in
                    
                    GridItemView("NO.\(index * index)")
                }
            }
        }
    }
    
    let words: [String] = [
        "Y","_","rocky","say",
        "Hello","World","to","uu",
        ",","and","then","send","you",
        "a","swift","UI","course","~",
        "hope","youu","will","like","it",".",
    ]
    var doAdaptive: some View {
        VExampleView("adaptive") {
            LazyVGrid(
                columns: [
                    .init(.adaptive(minimum: 40), spacing: 5, alignment: .center)
                ],
                alignment: .leading,
                spacing: 5
            ) {
                ForEach(words, id:\.self) { word in
                    
                    GridItemView(word)
                }
            }
        }
    }
    
    var doGridItem: some View {
        VExampleView("GridItem") {
         
            LazyVGrid(columns: [
                GridItem(.fixed(70))
            ]) {
                ForEach(words, id: \.self) {
                    GridItemView($0)
                }
            }
        }
    }
    
    var doSection: some View {
        HScrollExampleView("使用 Section 创建 Grid ") {
            /*:
             在Grid中，也是可以使用Section来构建界面
             */
            
            LazyHGrid(
                rows: [
                    .init(.fixed(50), spacing: 10, alignment: .center),
                    .init(.fixed(50), spacing: 10, alignment: .center)
                ],
                spacing: 10
            ) {
             
                ForEach(0..<3) { section in
                    Section(
                        header: Text("Header \(section)"),
                        footer: Text("Footer \(section)")) {
                        ForEach(0..<10) { item in
                            GridItemView("{\(section),\(item)}")
                        }
                    }
                }
            }
        }
    }
    
    var doInScrollView: some View {
        
        VExampleView("ScrollView", height: 200) {
            
            /*:
             当数据过多的时候，Grid难免会撑满屏幕，并且Grid自身并不会滑动，
             如果需要滑动，需要配合使用`ScrollView`，将Grid内嵌到ScrollView中。
             */
            ScrollView {
                LazyVGrid(
                    columns: [
                        .init(.fixed(50), spacing: 10, alignment: .center),
                        .init(.flexible(), spacing: 5, alignment: .center),
                        .init(.fixed(50), spacing: 10, alignment: .center),
                    ],
                    spacing: 10
                ) {
                 
                    ForEach(0..<3) { section in
                        Section(
                            header: Text("Header \(section)"),
                            footer: Text("Footer \(section)")) {
                            ForEach(0..<10) { item in
                                GridItemView("{\(section),\(item)}")
                            }
                        }
                    }
                }
            }
        }
    }
    var doPinnedScrollableViews: some View {
        VExampleView("PinnedScrollableViews", height: 200) {
            /*:
             在Grid初始化的时候，其实还是有一个参数我们一直没有使用：`pinnedViews`。
             通过这个参数，我们可以将header或者footer进行悬停，
             他是一个`PinnedScrollableViews`类型，
             系统为我们提供了两个内置的实例：`sectionHeaders`、`sectionFooters`。
             比较奇怪的是，swiftUI只允许我们选择一个来悬停，header或者footer。
             */
            ScrollView {
                LazyVGrid(
                    columns: [
                        .init(.fixed(50), spacing: 10, alignment: .center),
                        .init(.flexible(), spacing: 5, alignment: .center),
                        .init(.fixed(50), spacing: 10, alignment: .center),
                    ],
                    spacing: 10,
                    pinnedViews: .sectionHeaders
                ) {
                 
                    ForEach(0..<3) { section in
                        Section(
                            header: Text("Header \(section)"),
                            footer: Text("Footer \(section)")) {
                            ForEach(0..<10) { item in
                                GridItemView("{\(section),\(item)}")
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    struct GridItemView: View {
        
        let text: String
        
        init(_ text: String = "") {
            self.text = text
        }
        
        var body: some View {
            
//            GeometryReader{ proxy in
                Text(text)
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
                    .fontWeight(.light)
                    .padding(.all, 4)
                    .background(Color.orange.opacity(0.2))
//                    .frame(width: proxy.size.width)
                    .border(Color.orange)
//            }
        }
    }
}

struct DoGrid_Previews: PreviewProvider {
    static var previews: some View {
        DoGrid()
    }
}
