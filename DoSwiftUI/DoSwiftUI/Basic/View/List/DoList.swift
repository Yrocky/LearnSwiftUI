//
//  DoList.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/25.
//

import SwiftUI

struct DoList: View {
    var body: some View {
        
        ExampleContainterView("List") {

            doWithViewBuilder_Static

            doWithViewBuilder_Dynamic

            doAppend_Delete_Move_Insert

            doWithRange

            doWithKeyPath

            doDiffForEach

            doDisclosureGroup_OutlineGroup
            
            doSection
            
            doSingleSelection

            doMutableSelection
        }
    }
    
    @State var sliderValue = 0.2
    
    var doWithViewBuilder_Static: some View {
        VExampleView("使用 ViewBuilder 构建静态列表", height: 200) {
            /*:
             swiftUI中的`List`比UIKit中的UITableView使用起来会简单的多，
             这是因为swiftUI为我们提供了很多种初始化方法，便于在多种场景下使用，
             其实List本质上使用的是`UpdateCoalescingTableView`，一个UITableView的私有子类，
             只不过swiftUI为根据我们提供的数据做了数据源和代理的事情。
             
             下面我们根据作用的划分来系统的了解下这些api，
             大体上可以分为4种类型：`ViewBuilder`、`Range`、`KeyPath`、`DisclosureGroup&OutlineGroup`，
             每个类型下的初始化方法，都有对应的两个和`selection`有关的初始化方法用于处理选中逻辑。
             
             最基础的就是直接使用`ViewBuilder`来初始化对应个数的List，可以使用任何的View，
             这种方法仅适用于构造静态的列表结构。
             
             ```swift
             init(@ViewBuilder content: () -> Content)
             ```
             
             通过该实例我们可以看到，任何的View被作为List的`RowContent`来显示之后，
             List会为他们设置一个`最小默认高度`，如果RowContent自身的高度大于默认数值，将使用自身高度。
             */
            List() {
                Group{
                    
                    Text("Apple")
                    Text("IBM")
                    Text("Google")
                }
                .foregroundColor(.orange)
                .font(.system(size: 15))
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(1..<10) { index in
                            HStack {
                                Image(systemName: "\(index).circle.fill")
                                    .foregroundColor(.green)
                                Text("\(index)")
                            }
                            .padding()
                            .border(Color.orange)
                        }
                    }
                }
                HStack{
                    Image(systemName: "bicycle")
                        .foregroundColor(.green)
                    Text("bicycle")
                }
                .frame(height: 80)
                
                Slider(value: $sliderValue) {
                    Text("Progress value")
                }
                
                LinearGradient(
                    gradient: Gradient(colors: [.green, .orange]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing)
                
                Color.orange
                    .frame(width: 100, height: 10)
                
                Rectangle()
                    .fill(Color.purple)
                    .border(Color.gray)
                
                Circle()
                    .fill(Color.blue)
            }
        }
    }
    
    @State var indexs = [0,1,2,3,4,5]
    
    var doWithViewBuilder_Dynamic: some View {
        
        VExampleView("使用 ViewBuilder 构建动态列表", height: 200) {
        
            /*:
             除了直接在ViewBuilder中创建View，还可以在ViewBuilder中使用ForEach来完成动态列表的构建。
             不过需要注意的是，ForEach的方法内应该是只返回一个View，
             因为List会根据其`根View的个数`来创建对应个数的Row。
             */
            List {
                ForEach(indexs, id: \.self) { index in
                    
                    HStack {
                        
                        InnerImage(index)
                        
                        Text("This is \(index)")
                    }
                }
            }
        }
    }
    
    var doAppend_Delete_Move_Insert: some View {
        VExampleView("append、delete、move、insert", height: 250) {
            
            /*:
             ForEach有一个拓展，使得其遵守了`DynamicViewContent`协议，
             该协议使ForEach具备了`delete`、`move`、`insert`的功能，
             而配合着List，我们可以完成以前UITableView中的delete、move、insert。
             
             ```swift
             func onDelete(perform action: ((IndexSet) -> Void)?) -> some DynamicViewContent
             
             func onMove(perform action: ((IndexSet, Int) -> Void)?) -> some DynamicViewContent

             // iOS14.0新添加
             func onInsert(of supportedContentTypes: [UTType], perform action: @escaping (Int, [NSItemProvider]) -> Void) -> some DynamicViewContent
             ```
             
             List需要配合一个`EditButton`才可以进入编辑状态，在编辑状态下，可以选中、移动等操作。
             
             具体是什么原因暂时还未知。
             */
            
            Text("向左滑动cell可以删除该数据")
                .font(.footnote)
            
            List{
                    
                ForEach(indexs, id: \.self) { index in
                    
                    HStack{
                     
                        if let _ = UIImage(named: "icon_tecxture_\(index)") {
                            InnerImage(index)
                        }
                        
                        Text("This is \(index)")
                    }
                }
                .onDelete { indexSet in
                    indexs.remove(atOffsets: indexSet)
                }
                .onMove { (indexset, index) in
                    indexs.move(fromOffsets: indexset, toOffset: index)
                }
                //: An array of UTI types that the dynamic view supports.
                .onInsert(of: [""]) { (index, itempro) in
                    
                }
            }
            
            HStack{
    
                EditButton()
                    .foregroundColor(.red)
                
                Button("Append index"){
                    
                    indexs.append(indexs.count)
                }
            }

            Text("Current indexs.count is:\(indexs.count)")
        }
    }
    var doWithRange: some View {
        
        VExampleView("使用 Range 初始化", height: 200) {
        
            /*:
             通过头文件我们可看出来，使用`Range`其实内部也是使用`ForEach`，ViewBuilder中构建每一Row的UI：RowContent，
             最终使用的RowContent默认会被使用HStack做水平布局进行展示。
             
             在前面ForEach部分我们知道它有三个泛型：`Data`、`ID`、`Content`，
             而在一个以Range为Data的ForEach中，Range的索引都是唯一的，所以可以直接使用Range来创建List。
             再次提及ForEach是因为List的基本数据构成集合，而在UITableView中我们会遍历集合来创建Cell，
             所以这个ForEach在List中是一个比较重要的部分，这一点在下面KeyPath中还会有所应用。
             
             ```swift
             
              init(_ data: Range<Int>, @ViewBuilder rowContent: @escaping (Int) -> RowContent)
              where Content == ForEach<Range<Int>, Int, HStack<RowContent>>, RowContent : View
             ```
             */
            List(1..<10) { index in
                
                InnerImage(index)
                    .cornerRadius(4)
                
                VStack(alignment: .leading) {
                    
                    Text("\(index) This is title")
                        .foregroundColor(.black)
                        .font(.system(size: 17))
                    
                    Text("detail title")
                        .foregroundColor(.gray)
                        .font(.system(size: 14))
                }
            }
        }
    }

    let citys = ["beijing", "shanghai", "suzhou", "wuhan", "chongqing"]
    
    struct Man: Identifiable {
        let id = UUID()
        var name: String
    }
    
    let mans = [
        Man(name: "Rocky"),Man(name: "Candy"),
        Man(name: "Cloud"),Man(name: "Dragon"),
    ]
    
    var doWithKeyPath: some View {
        /*:
         
         我们划分的`Range`和`KeyPath`本质上都是使用的`ForEach`，
         对于一些在ForEach中的ID不明确的集合，我们需要根据KeyPath来指明ID，
         这点在ForEach中使用`自定义类型`以及`String`进行遍历的时候已经有所提及。
         
         ```swift
         init(_ data: Data, id: KeyPath<Data.Element, ID>, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent)
         where Content == ForEach<Data, ID, HStack<RowContent>>, Data : RandomAccessCollection, ID : Hashable, RowContent : View
         
         init(_ data: Data, @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent)
         where Content == ForEach<Data, Data.Element.ID, HStack<RowContent>>, Data : RandomAccessCollection, RowContent : View, Data.Element : Identifiable
         ```
         */
        VStack{
            
            VExampleView("使用 KeyPath 初始化", height: 200) {
                List(citys, id: \.self) {
                    Text("\($0)")
                }
            }
            
            VExampleView("自定义类型的 KeyPath 初始化", height: 200) {
                
                List(mans) {
                    
                    Image(systemName: "figure.wave")
                        .foregroundColor(.green)
                    
                    Text("Hello ") + Text($0.name).foregroundColor(.orange)
                }
            }
        }
    }
    
    var doDiffForEach: some View {
        
        HScrollExampleView("在 ViewBuilder 中使用 ForEach 初始化，以及使用 ForEach 初始化的区别", height: 200) {
            /*:
             在上面的实例中，我们知道可以在ViewBuilder中使用ForEach来构建List，
             也可以使用基于ForEach的一系列init方法来构建，两者之间有没有什么区别呢?
             
             首先在大数据量的情况下，两者在真机（iPhone XS Max iOS 14.2）上没有什么差异，顺滑程度一致，
             并且由于List本身是基于UITableView构建的，所以也没有出现创建很多视图的情况。
             
             另外，在ViewBuilder中使用ForEach可以构建`多个动态列表`，甚至是`动态和静态混合`，
             而通过ForEach初始化的List`只能是一个动态的列表`。
             
             最后一点就是上面提到的，在ViewBuilder中使用ForEach，
             可以结合`DynamicViewContent`完成对列表的move、delete、insert操作，
             这是通过ForEach初始化的列表所不具备的。

             */
            
            List(0..<10) {// 10_0000
                Text("ForEach init - \($0)")
            }
            .frame(width: 300)
            
            List {// 10_0000
                
                ForEach(0..<10) {
                    Text("ViewBuilder ForEach - \($0)")
                }
                
                Text("*******")
                
                ForEach(0..<10) {
                    
                    InnerImage($0)
                }
            }
            .frame(width: 300)
        }
    }
    
    var doDisclosureGroup_OutlineGroup: some View {
        
        VExampleView("DisclosureGroup、OutlineGroup", version: "2.0", height: 200) {
            /*:
             在List的初始化中，有一种基于`DisclosureGroup`、`OutlineGroup`的方式，
             在前面我们已经知道这两者可以用来实现自递归的结构，比如tree、文件夹，
             结合List，递归效果会比单纯使用这两者更有层次感。
             */
            List(files, children: \.children) { data in
                Text("\(data.name) (\(data.children?.count ?? 0))")
            }
        }
    }
    
    var doSection: some View {
        VExampleView("Section", height: 200) {
            /*:
             在前面介绍`Section`的时候我们发现，这种视图结构正好可以用来构成List，
             通过实例我们发现，使用`List-ForEach-Section`结构构建的List，
             默认支持HeaderView悬停功能，这个暂时没有找到关闭的方法。
             */
            List {
                ForEach(0..<3) { section in
                    Section(
                        header: Text("Header-\(section)"),
                        footer: Text("Footer-\(section)")) {
                        
                        ForEach(0..<6) { row in
                            Text("Cell {\(section),\(row)}")
                        }
                    }
                }
            }
        }
    }
    
    @State var selections: Set<Int> = []
    @State var selection: Int?
    
    var doSingleSelection: some View {
        
        VExampleView("single Selection", height: 200) {
            /*:
             在前面我们提到几种初始化方法都对应有`selection`的变种初始化方法，
             通过selection我们可以记录选中的Row，关于选中的初始化方法有两个，
             分别记录单个选中以及记录多个选中：
             * selection: Binding<SelectionValue?>?
             * selection: Binding<Set<SelectionValue>>?
             
             前者只记录`选中的ID`，后者会使用`Set`来记录`所有选中的ID`，相当于单选和多选。
             
             需要注意的是，List的ViewBuilder中是`使用ID作为参数被block使用`的，
             但是其`selection却是保存的Row的索引`。
             这在Range<Int>的例子中很容易弄混淆，
             比如下面例子中，index依次是3-10的整数，而每当选中第一个Row，selection为0，而这时候的Index为3。
             
             */
            List(0..<10, selection: $selection) { index in
                
                InnerImage(index)
                    //: 要确保List是从0开始遍历的才能正确的标识出来选中与非选中
                    .border(index == selection ? Color.orange : Color.gray)
                
                Text("This is \(index)")
            }
            
            EditButton()
            
            Text("Your selected:\(selection?.description ?? "none")")
        }
    }
    
    var doMutableSelection: some View {
        
        VExampleView("mutable selection", height: 200) {
        
            List(0..<10, selection: $selections) {
                InnerImage($0)
                    .border(selections.contains($0) ? Color.orange : Color.gray)
            }

            EditButton()
            
            Text("Your selected:\(selections.description)")
        }
    }
    
    
    
    struct InnerImage: View {
        
        var index: Int
        
        init(_ index: Int) {
            self.index = index
        }
        
        var body: some View {
            Image("icon_tecxture_\(index)")
                .resizable()
                .frame(width: 40, height: 40)
        }
    }
    
    var files: [File] = [
        File("root",
            children: [
                File( "desktop",
                    children: [
                        File("swift"),
                        File("vue"),
                        File("js"),
                        File("objc")
                    ]
                ),
                File("doucment",
                    children: [
                        File("picture"),
                        File("video"),
                        File("markdown"),
                        File("zip")
                    ]
                )
            ]
        )
    ]
    
    struct File: Hashable, Identifiable {
        let id = UUID()
        var name: String
        var children: [File]? = nil
        
        init(_ name: String, children: [File]? = nil) {
            self.name = name
            self.children = children
        }
    }
}

struct DoList_Previews: PreviewProvider {
    static var previews: some View {
        DoList()
    }
}
