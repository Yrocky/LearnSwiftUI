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
            
//            doMonthView
//
//            doEqualWidthText
            
//            doAnchorPreference
            
            doAnchorWithOffset
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
             
             这样就完成了获取文本宽度、比较宽度得到最大值、容器监听到最大值并存储、将最大值。
             
             `preference`允许我们在View上设置一些数据，并且根据视图层次结构向上传递，某些上层的View如果对这些数据感兴趣，可以通过`onPreferenceChange`来获取。
             */
            VStack(spacing: 5){
                
                Group{
                    Text("Hi")
                    Text("I'm Rocky,")
                    Text("an iOS Enginner")
                    Text(".")
                }
                .padding(.horizontal, 5)
                .recordWidth()
                .frame(width: maxTextWidth)
                .font(.system(size: 20, design: .rounded))
                .foregroundColor(.white)
                .background(Color.pink)
                .cornerRadius(5)
            }
            .readMaxWidth {
                self.maxTextWidth = $0
            }
        }
    }
    
    var doAnchorPreference: some View {
        VExampleView("anchorPreference") {
            /*:
             上面我们通过`preference`拿到了所有子View中宽度最大的View，那么接下来我们通过来获取下所有子View的Anchor
             */
            VStack{
                
                Group {
                    NodeView(value: 1, color: .red)
                    NodeView(value: 2, color: .green)
                    Text("Hello world")
                        .padding()
                        .background(Color.green)
                        .cornerRadius(4)
                    NodeView(value: 3, color: .orange)
                    NodeView(value: 4, color: .purple)
                }
                .recordCenter()
            }
            .readAllCenter{ nodes in
                GeometryReader { proxy in
                    drawLine(proxy, nodes: nodes)
                }
            }
            
            HStack{
                Group {
                    NodeView(value: 1, color: .blue)
                    NodeView(value: 2, color: .blue)
                    NodeView(value: 3, color: .blue)
                    NodeView(value: 4, color: .blue)
                }
                .recordCenter()
            }
            .readAllCenter{ nodes in
                GeometryReader { proxy in
                    drawLine(proxy, nodes: nodes)
                }
            }
            
//            .backgroundPreferenceValue(NodeAnchorCenterKey.self) { preferences in
//                /*:
//                 通过 GeometryReader 拿到父View的尺寸，
//                 通过 preferences 拿到所有子View的center，
//                 然后我们开始子View之间的连接线。
//                 */
//                GeometryReader { proxy in
//                    drawLine(proxy, preferences: preferences)
//                }
//            }
        }
    }
    
    var doAnchorWithOffset: some View {
        VExampleView("Anchor with .offset", height: 140) {
            
            /*:
             在使用offset对View进行偏移之后，再实现View之间的连线会发现，结果并不是预期的那样。通过offset之后的效果很像对UIView的CALayer进行了偏移，而UIView本身并没有变动。这就要涉及到SwiftUI中布局了，在SwiftUI中，所有View的布局都是由父容器View（VStack、HStack）以及自身设置、子View撑起的尺寸来综合决定的，自身设置、子View撑起的尺寸决定大小，而父容器View决定如何对齐排列。但是offset打破了父容器View对View的对齐方式，它让原本对齐的View们在视觉上不再对齐。
             
             文档中对`offset()`的解释中有一句话：
             
             > Use `offset(_:)` to to shift the displayed contents by the amount specified in the `offset` parameter.
             
             其中用到了`the displayed contents`，展示的内容，并不是`the View`，并且接下来文档指出了
             
             > The original dimensions of the view aren't changed by offsetting the contents
             
             原始View的dimensions（尺寸）并不会发生改变，只字未提center是否会发生改变，但是通过测试我们已经可以肯定，原始View的center也不会发生改变，改变的仅仅是View中的展示内容。
             
             在SwiftUI中，除了offset之外，还有一个`position()`也可以修改View的位置，但与offset不同的是，position指定View在父View中的**绝对位置**，而offset是修改View
             在父View中的**相对位置**，所以很显然，他也不合适。
             
             */
//            HStack{
//                Group {
//                    NodeView(value: 1)
//                        .offset(y: 20)
//                    NodeView(value: 2)
//                    NodeView(value: 3)
//                        .offset(y: -20)
//                    NodeView(value: 4)
//                        .offset(y: -40)
//                }
//                .background(Color.pink)
//                .recordCenter()
//            }
//            .readAllCenter{ nodes in
//                GeometryReader { proxy in
//                    drawLine(proxy, nodes: nodes)
//                }
//            }
            
            HStack{
                Group {
                    NodeView(value: 1)
                        .recordCenter()
                        .offset(y: 20)
                    NodeView(value: 2)
                        .recordCenter()
                    NodeView(value: 3)
                        .recordCenter()
                        .offset(y: -20)
                    NodeView(value: 4)
                        .recordCenter()
                        .offset(y: -40)
                }
                .background(Color.pink)
//                .recordCenter()
            }
            .readAllCenter{ nodes in
                GeometryReader { proxy in
                    drawLine(proxy, nodes: nodes)
                }
            }
        }
    }
    func drawLine(_ proxy: GeometryProxy, nodes: [NodeAnchor]) -> some View {
        Path { path in
            path.move(to: proxy[nodes.first!.center])
            nodes.forEach { node in
                path.addLine(to: proxy[node.center])
            }
        }
        .stroke(Color.blue)
    }
    
    struct Line: Shape {
        let from: CGPoint
        let to: CGPoint
        
        func path(in rect: CGRect) -> Path {
            Path{ path in
                path.move(to: from)
                path.addLine(to: to)
            }
        }
    }
}

struct MaxTextWidthPreferenceKey: PreferenceKey {
    
    typealias Value = CGFloat
    static var defaultValue: Value = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct RecordWidth: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader{ proxy in
                    Color.clear
                        // 设置
                        .preference(
                            key: MaxTextWidthPreferenceKey.self,
                            value: proxy.size.width
                        )
                }
            )
    }
}

extension View {
    
    func recordWidth() -> some View {
        ModifiedContent(
            content: self,
            modifier: RecordWidth()
        )
    }
    
    func readMaxWidth(_ action: @escaping (CGFloat) -> Void) -> some View {
        // 读取
        self
        .onPreferenceChange(MaxTextWidthPreferenceKey.self) {
            action($0)
        }
    }
}

// MARK: NodeCenter

struct NodeView: View {
    
    let value: Int
    var color: Color = .blue
    
    var body: some View{
        Circle()
            .fill(color)
            .frame(width: 30, height: 30)
            .overlay(
                Text("\(value)")
                    .font(.system(size: 14))
                    .foregroundColor(.white)
            )
    }
}

struct NodeAnchor {

    let center: Anchor<CGPoint>
}

struct NodeAnchorCenterKey: PreferenceKey {
    
    static var defaultValue: [NodeAnchor] = []
    static func reduce(value: inout [NodeAnchor], nextValue: () -> [NodeAnchor]) {
        value.append(contentsOf: nextValue())
    }
}

extension View {
    func recordCenter() -> some View {
        self.anchorPreference(key: NodeAnchorCenterKey.self, value: .center) {
            [NodeAnchor(center: $0)]
        }
    }
    
    func readAllCenter<V: View>(_ preferences: @escaping ([NodeAnchor]) -> V) -> some View {
        /*:
         `backgroundPreferenceValue`允许我们为指定的View创建一个backgroundView，相反的`overlayPreferenceValue`则是为View创建一个overlayView。他们与`onPreferenceChange`的区别是，后者仅仅是用来监听设置的`preference`，而前两者则会根据监听到的`preference`来创建对应的View。
         */
        self.backgroundPreferenceValue(NodeAnchorCenterKey.self) {
            preferences($0)
        }
//        self.overlayPreferenceValue(NodeAnchorCenterKey.self) {
//            preferences($0)
//        }
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
