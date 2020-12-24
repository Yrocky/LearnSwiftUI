//
//  DoAlignment.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/22.
//

import SwiftUI

struct DoAlignment: View {
    var body: some View {
        
        ExampleContainterView("Alignment"){
        
            doHorizontalAlignment
            
            doVerticalAlignment
            
            doAlignmentGuideWithVStack
            
            doAlignmentGuideWithHStack
            
            doCustomAlignment
        }
    }
    
    @State var horizontalAlignment = HorizontalAlignment.leading
    
    var doHorizontalAlignment: some View {
        
        /*:
         在我们使用过的*Stack中就支持alignment，只不过不同的类型使用的是不同的alignment，
         目前常用的有`VerticalAlignment`、`HorizontalAlignment`以及`Alignment`三种，
         其中前两者分别表示垂直和水平方向上的对齐方式，而最后的Alignment是由前两者组成的具备两个方向上的对齐方式。
         
         */
        VExampleView("在 VStack 中使用 aligment") {
            
            VStack(alignment: horizontalAlignment) {
                
                ItemView(color: .blue, width: 180)
                
                ItemView(color: .red, width: 80)
                
                ItemView(color: .green, width: 100)
            }
            .frame(width: 300)
            .onTapGesture {
                withAnimation {
                    self.horizontalAlignment.change()
                }
            }
        }
    }
    
    @State var verticalAlignment = VerticalAlignment.top

    var doVerticalAlignment: some View {
        
        VExampleView("在 HStack 中使用 aligment") {
            
            HStack(alignment: verticalAlignment){
                
                ItemView(color: .blue, height: 100)
                
                ItemView(color: .red, height: 60)
                
                ItemView(color: .green, height: 80)
            }
            .frame(width: 300)
            .onTapGesture {
                withAnimation {
                    self.verticalAlignment.change()
                }
            }
        }
    }
    
    @State var usageAlignmentGuideVStack = true
    
    var doAlignmentGuideWithVStack: some View {
        
        /*:
         swiftUI为我们提供了`alignmentGuide`，让我们可以自定义对齐方式，
         我们可以使用`ViewDimensions`进行自定义的计算，并返回结果交给系统来决定对齐方式。
         
         ```swift
         func alignmentGuide(_ g: HorizontalAlignment, computeValue: @escaping (ViewDimensions) -> CGFloat) -> some View
         
         func alignmentGuide(_ g: VerticalAlignment, computeValue: @escaping (ViewDimensions) -> CGFloat) -> some View
         ```
         
         通过ViewDimensions我们可以获取到View的`width`、`height`，以及使用下标获取指定位置处的偏移量：
         
         ```swift
         public subscript(guide: HorizontalAlignment) -> CGFloat { get }
         
         public subscript(guide: VerticalAlignment) -> CGFloat { get }
         ```
         
         */
        VExampleView("在 VStack 中使用 alignmentGuide 修改偏移量") {
            
            VStack(alignment: .leading){
                
                ItemView(color: .red, width: 120)
                
                ItemView(color: .gray, width: 70)
                    .alignmentGuide(.leading) { dimension in
                        
                        /*:
                         通过width、height获取到当前View的尺寸，
                         这一点很好理解，因为上面我们有主动设置frame，
                         如果没有主动设置，则会使用内容撑起来的尺寸，
                         比如Text中根据文本内容、字号等决定的尺寸。
                         */
                        let _ = dimension.width // 70
                        let _ = dimension.height // 30
                        
                        /*:
                         而根据下标获取对应偏移量其实也是很直观的。
                         比如`dimension[HorizontalAlignment.trailing]`，
                         获取的其实是该View在水平方向上`trailing`距离起始点的偏移量。
                         这里以常用坐标系下iPhone为例，左上角为(0,0)，
                         由于该View的宽度为70，所以水平方向上trailing距离起点的值为70（View的width）。
                         */
                        let fsdsd = dimension[HorizontalAlignment.trailing]// 70
                        let sdfsd = dimension[HorizontalAlignment.leading]// 0
                        let sd = dimension[HorizontalAlignment.center]// 35
                        let sdf = dimension[VerticalAlignment.top]// 0
                        let sdfs = dimension[VerticalAlignment.bottom]// 30
                        let sdfse = dimension[VerticalAlignment.center]// 15
                        
                        /*:
                         根据上面获取尺寸、偏移量的知识点，我们就可以通过修改偏移量，来自定义对齐方式了。
                         `alignmentGuide(:,:)`这个modifer的第一个参数用来指明要修改的是何种`对齐标线`，
                         第二个参数是一个函数，返回一个CGFloat，swiftUI会根据这个值来决定`对齐标线上的偏移量`。
                         
                         需要注意的是，针对具体的对齐标线，偏移量还是有`正负之分`的，
                         以所有同组的View中最leading的那个为起始点，
                         其余的View根据隐式、显式设定的对齐偏移来决定对齐方式。
                         比如第一个View使用的是隐式的对齐，其偏移量为0，
                         第二、三、四个View使用的都是显式对齐，偏移量分别为10、-10、20。
                         在该情况，第四个View的leading就是基准线，
                         其余View依次向右偏移20（20-0）、10（20-10）、30（20--10）。
                         */
                        return self.usageAlignmentGuideVStack ? 10 : 0
                    }
                
                ItemView(color: .green, width: 100)
                    .alignmentGuide(.leading) { dimension in
                        return self.usageAlignmentGuideVStack ? -10 : 0
                    }
                
                ItemView(color: .orange, width: 70)
                    .alignmentGuide(.leading) { dimension in
                        return self.usageAlignmentGuideVStack ? 20 : 0
                    }
            }
            .frame(width: 300, alignment: .leading)
            .onTapGesture {
                withAnimation {
                    self.usageAlignmentGuideVStack.toggle()
                }
            }
        }
    }
    
    @State var usageAlignmentGuideWithHStack = false
    
    var doAlignmentGuideWithHStack: some View {
        
        VExampleView("在 HStack 中使用 alignmentGuide 修改偏移量") {
            
            HStack(alignment: .top){
                /*:
                 同样在这个例子中，第二个View在垂直方向上的偏移最多，以他为基准线，
                 第一个View需要向下偏移20（20-0），
                 第三个View需要向下偏移40（20--20），
                 第四个View需要向下偏移10（20-10）。
                 */
                ItemView(color: .red, height: 80)
                
                ItemView(color: .gray, height: 50)
                    .alignmentGuide(.top) { dimension in
                        return self.usageAlignmentGuideWithHStack ? 20 : 0
                    }
                
                ItemView(color: .green, height: 110)
                    .alignmentGuide(.top) { dimension in
                        return self.usageAlignmentGuideWithHStack ? -20 : 0
                    }
                
                ItemView(color: .orange, height: 20)
                    .alignmentGuide(.top) { dimension in
                        return self.usageAlignmentGuideWithHStack ? 10 : 0
                    }
            }
            .frame(width: 300, alignment: .center)
            .onTapGesture {
                withAnimation {
                    self.usageAlignmentGuideWithHStack.toggle()
                }
            }
        }
    }
    
    struct ItemView: View {
        
        var color = Color.clear
        
        var width : CGFloat = 0
        var height: CGFloat = 0
        
        init(
            color: Color = .clear,
            width: CGFloat = 30,
            height: CGFloat = 30
        ) {
            self.color = color
            self.width = width
            self.height = height
        }
        
        var body: some View {
            Rectangle()
                .fill(color.opacity(0.2))
                .frame(width: width, height: height)
                .cornerRadius(4)
        }
    }
    var cardItems = [
        CardItem(color: .red, width: 80),
        CardItem(color: .gray, width: 30),
        CardItem(color: .green, width: 60),
        CardItem(color: .pink, width: 40),
        CardItem(color: .orange, width: 70),
        CardItem(color: .blue, width: 20),
        CardItem(color: .black, width: 50),
        CardItem(color: .red, width: 0)
    ]
    
    var doCustomAlignment: some View {
        
        VExampleView("自定义 alignmentGuide") {
            
            ZStack(alignment: .center){
                
                Rectangle()
                    .fill(Color.red.opacity(0.6))
                    .frame(width: 1)
                
                ScrollView{
                    
                    cardContainerView
                        .frame(width: 300, alignment: .center)
                        .padding()
                }
                .frame(height: 150, alignment: .center)
            }
        }
    }
    
    var cardContainerView: some View {
        
        VStack(alignment: .center){
            
            ForEach(cardItems.indices, id:\.self) { index in
                CardView(
                    cardItem: cardItems[index],
                    direction: (index % 2 == 0 ? .left : .right))
            }
        }
    }
    
    enum Direction{
        case left
        case right
        
        var text: String{
            switch self {
            case .left: return "Left"
            case .right: return "Right"
            }
        }
        
        func offset(with value: CGFloat) -> CGFloat {
            switch self {
            case .left: return 0
            case .right: return value * 2
            }
        }
    }
    
    struct CardItem: Identifiable {
        
        var id = UUID()
        var color: Color
        var width: CGFloat
        
        init(color: Color, width: CGFloat) {
            self.color = color.opacity(0.2)
            self.width = width
        }
    }
    
    struct CardView: View {
        
        var cardItem: CardItem
        var direction: Direction = .left
        
        var body: some View {
            
            Rectangle()
                .fill(cardItem.color)
                .cornerRadius(4)
                .frame(width: cardItem.width, height: 30)
                .alignmentGuide(.center, computeValue: { dimension in
                    let venterOffsetValue = dimension[HorizontalAlignment.center]
                    let offset = self.direction.offset(with: venterOffsetValue)
                    return offset
                })
        }
    }
}

extension HorizontalAlignment {
    
    mutating func change() {
        if self == .leading {
            self = .center
        } else if self == .center {
            self = .trailing
        } else {
            self = .leading
        }
    }
    
    func needChange(with other: HorizontalAlignment) -> Bool {
        self != other
    }
}

extension VerticalAlignment {
    
    mutating func change() {
        if self == .top {
            self = .center
        } else if self == .center {
            self = .bottom
        } else {
            self = .top
        }
    }
    
    func needChange(with other: VerticalAlignment) -> Bool {
        self != other
    }
}

struct DoAlignment_Previews: PreviewProvider {
    static var previews: some View {
        DoAlignment()
    }
}
