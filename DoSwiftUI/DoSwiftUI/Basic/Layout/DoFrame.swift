//
//  DoFrame.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/18.
//

import SwiftUI

struct DoFrame: View {
    
    var body: some View {
        
        ExampleContainerView("frame"){
            
//            doBasic
//
//            doSetupAlignment
//
//            doFrameInVStack
            
            doFrameInHStack
            
//            doMinIdealMaxFrame
//
//            doFrameVSSpacer
        }
    }
    
    var doBasic: some View {
        
        HExampleView("固定宽高，固定宽，固定高") {
            /*:
             可以设置具体的宽高，如果不设置默认使用系统提供的大小
             */
            
            Text("Fix width and height, ddddddddddddd")
                .background(Color.red)
                .frame(width: 50, height: 50)
                .background(Color.green)
            
            Text("Just fix width, ddddddddddddd")
                .background(Color.red)
                .frame(width: 50)
                .background(Color.green)
            
            Text("Just fix height, ddddddddddddd")
                .background(Color.red)
                .frame(height: 50)
                .background(Color.green)
        }
    }
    
    @State private var frameAlignment = Alignment.center
    
    var doSetupAlignment: some View {
        
        VExampleView("设置 alignment，点击色块转换 alignment") {
            
            /*:
             在设置frame的时候还有第三个参数：`alignment`，
             通过设置这个，可以决定View在给定的尺寸中的位置，
             一共有9个位置，下面一一列举一下，绿色是设置的固定尺寸，红色是Text文本的尺寸。
             */
            Text("Hello world~")
                .background(Color.red)
                .frame(width:200, height: 100, alignment: frameAlignment)
                .background(Color.green)
        }
        .onTapGesture {
            withAnimation {
                frameAlignment.change()
            }
        }
    }
    
    var doFrameInVStack: some View {
        
        VExampleView("VStack") {
            
            VStack(spacing: 5){
                
                // minWidth分别设置小于设计宽度、大于实际宽度
                Text("ABC")
                    // 大于实际宽度，最终展示尺寸为设置的minWidth
                    .frame(minWidth: 130)
                    .background(Color.green)
                
                Text("ABC")
                    // 小于实际宽度，最终展示尺寸为实际宽度
                    .frame(minWidth: 10)
                    .background(Color.green)
                
                Text("ABC")
                    // 大于实际宽度，最终展示尺寸为设置的maxWidth
                    .frame(maxWidth: 130)
                    .background(Color.green)
                
                Text("ABC")
                    // 小于实际宽度，以设置的maxWidth为主
                    .frame(maxWidth: 10, maxHeight: 20)
                    .background(Color.green)
                
                Text("ABC")
                    //
                    .frame(minWidth: 10, maxWidth: 130)
                    .background(Color.green)
                
                Text("ABC")
                    // 当设置了minWidth、maxWidth之后，最终会以maxWidth为主，也就是说，maxWidth的优先级要高
                    .frame(minWidth: 130, idealWidth: 150, maxWidth: 200, alignment: .leading)
                    .background(Color.green)

                /*:
                 默认的，min、max都为nil，所以最终的尺寸就是根据View内容决定的，
                 当min、max有设置之后View的最终显示尺寸会与这个区间内有关，假如View在水平方向上的真实尺寸为value。
                 
                 * 设置了min，[min, nil)
                    * value =< min，最终展示为min
                    * value > min，最终展示为value
                 * 设置了max，(nil, max]
                    * value >= max，最终展示为max
                    * value < max， 最终展示为max
                 * 两者都设置，[min, max]
                    * 不论value为何止，最终展示都为max
                 */
                Text("ABC")
                    // 设置了max，就会在父View给定的尺寸中最大程度的使用空间
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.green)
                
                Text("ABC")
                    // 这样设置与`不设置一样的效果`
                    .frame(maxWidth: nil, alignment: .leading)
                    .background(Color.green)
            }
            .frame(width: 300)
            .background(Color.green.opacity(0.2))
        }
    }
    
    var doFrameInHStack: some View {
        
        VStack{
            
//            doAverageSize
//
//            doSetupMinWidthGreaterProposed
//
//            doSetupMinWidthLesserProposed
//
//            doSetupMaxWidthGreaterProposed
//
//            doSetupMaxWidthLesserProposed
            
            doSetupMin_MaxWidth
        }
    }
    
    var doAverageSize: some View {
        VExampleView("没有内容撑起的View，会均分父View的空间") {
            ContainerView(width: 300) {
                /*:
                 这三个View都没有具体内容撑起，所以会使用父View建议的尺寸，在这里就是均分父View的空间，每个的宽度都为100
                 */
                Color.red
                Color.green
                Color.orange
            }
        }
    }
    
    var doSetupMinWidthGreaterProposed: some View {
        VExampleView("设置minWidth，但是大于父View建议的尺寸，使用minWidth") {
            ContainerView(width: 300) {
                /*:
                 在使用父View建议尺寸的时候，如果对View没有水平、垂直方向上的限制，那么就会使用建议的大小，而如果有特殊限制，就要准守以下准则（以水平方向为例）：
                 * 如果设置了最小值（minWidth）
                     * minWidth小于父View建议的width，最终使用建议的width
                     * minWidth大于父View建议的width，最终使用minWidth
                 * 如果设置了最大值（maxWidth），
                     * maxWidth大于父View建议的width，最终使用建议的width
                     * maxWidth小于父View建议的width，最终使用maxWidth
                 
                 这个例子中，red设置了minWidth为120，大于父View建议的100，所以最终red的宽度为120，green与orange均分剩余的空间。
                 */
                Color.red.frame(minWidth: 120)
                Color.green
                Color.orange
            }
        }
    }
    
    var doSetupMinWidthLesserProposed: some View {
        VExampleView("设置minWidth，但是小于父View建议的尺寸，使用建议的值") {
            ContainerView(width: 300) {
                /*:
                 在这个例子中，red设置了minWidth，并且小于父View建议的100，所以最终red、green、orange的宽度一致，都为100
                 */
                Color.red.frame(minWidth: 80)
                Color.green
                Color.orange
            }
        }
    }
    
    var doSetupMaxWidthGreaterProposed: some View {
        VExampleView("设置maxWidth，并且大于父View建议的尺寸，使用建议的值") {
            ContainerView(width: 300) {
                /*:
                 这个情况下，父View给他们的空间分别是100，虽然最后结果三个View的宽度也都为100，但是其中原因与上面的均分并不一样。
                 在这里，red设置了maxWidth，但是值大于父View建议的100，这里使用父View建议的大小，
                 而green、orange都没有任何限制，所以就会均分剩余的空间。
                 */
                Color.red.frame(maxWidth: 120)
                Color.green
                Color.orange
            }
        }
    }
    
    var doSetupMaxWidthLesserProposed: some View {
        VExampleView("设置maxWidth，并且小于父View建议的尺寸，使用maxWidth") {
            ContainerView(width: 300) {
                /*:
                 如果修改red的maxWidth为80，由于小于父View建议的100，所以这里就不使用父View建议的大小，而会以maxWidth为准，
                 最终显示red为80、green为110、orange为110。
                 */
                Color.red.frame(maxWidth: 80)
                Color.green
                Color.orange
            }
        }
    }
    
    var doSetupMin_MaxWidth: some View {
        VExampleView("") {
            ContainerView(width: 300) {
                /*:
                 上面我们只是单独的View设置min或者max，这只是为了方便理解min、max与父View的proposed之间的关系，
                 如果多个View，并且分别会设置min、max，最后的视图布局又是如何呢？
                 
                 比如我们有下面两种布局，猜测一下最后red、green、orange的宽度为多少：
                 
                 ```swift
                 ContainerView(width: 300) {
                 
                     Color.red.frame(maxWidth: 120)
                     Color.green.frame(minWidth: 120, maxWidth: 200)
                     Color.orange
                 }
                 
                 ContainerView(width: 300) {
                 
                     Color.red.frame(maxWidth: 80)
                     Color.green.frame(minWidth: 150)
                     Color.orange.frame(minWidth: 50, maxWidth:80)
                 }
                 ```
                 
                 现在揭晓答案
                 
                 // todo，图片
                 
                 View其实是有一个灵活性的(`flexible`)，SwiftUI会根据View的灵活性优先顺序来进行布局。
                 View的灵活性可以通过其可能值的范围来表示，比如在水平方向上，一个View的宽度是固定值，那么它的灵活性为0；如果minWidth=10，那么它的灵活性为10~largerNumber；如果maxWidth=100，那么灵活性为0~100；如果minWidth=10，maxWidth=100，那么灵活性为100-10=90。总之就是，`View在某个方向上的可能值范围越大，它就越灵活`，SwiftUI就越会最后计算它。
                 
                 回到我们的例子上。
                 
                 第一个例子中三个View的宽度范围分别为`0~120`、`120~200`、`0~largerNumber`，green的灵活性最差，red次之，orange灵活性最高。
                 SwiftUI首先会计算green的大小，由于其minWidth（120）<父View建议的大小（100），所以green的宽度为120；
                 **由于green的大小已经确定，所以需要更新建议值**，新的建议值为90；
                 接着计算red的大小，由于其maxWidth（120）>父View建议的大小（90），所以会使用建议的大小，宽度为90；
                 red确定大小之后，需要更新建议的值，新值为(300-120-90)/1=90；
                 最后计算orange的大小，其没有设置min与max，所以会撑满剩余空间，等效使用建议打大小，宽度为90。
                 
                 第二个例子中，三个View的灵活性一次为orange（30）、red（80）、green（largerNumber）。
                 首先计算orange，它分别设置了minWidth（50）与maxWidth（80），而建议的值（100）大于maxWidth，所以这里会使用maxWidth，故orange为80；
                 这时候由于orange已经确定了大小，所以需要更新建议的值，为(300-80)/2=110；
                 接着计算red，由于它只设置了maxWidth（80），并且小于建议的值（110），所以这里会使用maxWidth，red为80；
                 这个时候red也确定了大小，所以需要再次更新建议的值，新值为(300-80-80)/1=140；
                 最后计算green，它只设置了minWidth（150），并且大于建议的值（140），所以这里会使用minWidth，green为150。
                 
                 最终计算的结果为orange（80）+red（80）+green（150）=310，大于父View指定的300的宽度，所以最终展示区域会超过父View。
                 */
                Color.red.frame(maxWidth: 120)// (0,120]
                Color.green.frame(minWidth: 120, maxWidth: 200)//[120,200]
                Color.orange//(0,+∞)
            }
            
            ContainerView(width: 300) {
                /*:
                 https://developer.apple.com/videos/play/wwdc2019/237/?time=812
                 https://www.objc.io/blog/2020/11/09/hstacks-child-ordering/
                 
                 如果我们有如下这样的一个布局，最终展示结果将会是子View超出父View区域，覆盖叔父View或者被叔父View所覆盖。
                 
                 这是为什么呢？

                 三个View的灵活性依次为orange（30）、red（80）、green（largerNumber）。
                 * 首先计算orange，它分别设置了minWidth（50）与maxWidth（80），而建议的值（100）大于maxWidth，所以这里会使用maxWidth，故orange为80；
                 * 接着计算red，由于它只设置了maxWidth（80），并且小于建议的值（100），所以这里会使用maxWidth，red为80；
                 * 最后计算green，它只设置了minWidth（150），并且大于建议的值（100），所以这里会使用minWidth，green为150。
                 
                 最终计算的结果为orange（80）+red（80）+green（150）=310，大于父View指定的300的宽度，所以最终展示区域会超过父View。
                 */
                Color.red.frame(maxWidth: 80)//(0,80] 80
                Color.green.frame(minWidth: 150)//[150,+∞) largerNumber
                Color.orange.frame(minWidth: 50, maxWidth:80)// [50,80] 30
            }
            
            ContainerView(width: 300) {
                /*:
                 首先计算orange，maxWidth（80）小于建议的大小（100），最终为80；
                 **这个时候由于orange已经确定，所以建议的大小需要重新计算**，为(300-80)/2=110；
                 接着计算green，其maxWidth（150）大于建议的大小（110），所以结果为建议的大小（110）；
                 最后计算red，其minWidth（100）小于建议的大小（110），所以使用建议的大小（110）；
                 
                 最终结果为red（110）、green（110）、orange（80）。
                 */
                Color.red.frame(minWidth: 100)//[100,+∞)
                Color.green.frame(maxWidth: 150)//(0,150]
                Color.orange.frame(minWidth: 50, maxWidth:80)// [50,80]
            }
            
            ContainerView(width: 300) {
                /*:
                 red-90、green-70、orange-30，建议值为100，
                 首先计算orange，∵maxWidth(80)<100，∴为80；
                 orange固定，建议值修改为110，
                 接着计算green，∵maxWidth(70)<110，∴为70；
                 最后计算red，∵maxWidth(90)<110，∴为90。
                 
                 */
                Color.red.frame(maxWidth: 90)//[100,+∞)
                Color.green.frame(maxWidth: 70)//(0,150]
                Color.orange.frame(minWidth: 50, maxWidth:80)// [50,80]
            }
        }
    }
    @State private var superViewWidth: CGFloat = 140.0
    @State private var flexSizeText: String = "flex size"
    
    var doMinIdealMaxFrame: some View {
        //: https://developer.apple.com/documentation/swiftui/view/frame(minwidth:idealwidth:maxwidth:minheight:idealheight:maxheight:alignment:)
        
        VExampleView("min、ideal、max 和 alignment") {
            /*:
             除了设置固定尺寸，还可以为View设置一个范围内，
             这样可以保证View的宽高不会无限增长或者缩小，
             这里以宽度为例，高度也是一样的，
             通过滑动下面的滑竿可以改变父View的宽度，
             通过输入框可以动态的改变我们的目标Text的宽度。
             */
            HStack{
                Text("Fix size")
                    .foregroundColor(.white)
                    .frame(width: 80, height: 30)
                    .background(Color.green)
                
                Text(flexSizeText)
                    .foregroundColor(.white)
                    /*:
                     
                     我们设置宽度的范围为`30-100`，也就是说，`minWidth`为30，`maxWidth`为100。
                     可能你会注意到我们设置了一个`idealWidth`，这个属性字面意思上理解是`理想的宽度`，
                     但，什么是理想的值呢？
                     
                     > Always specify at least one size characteristic when calling this method. Pass nil or leave out a characteristic to indicate that the frame should adopt this view’s sizing behavior, constrained by the other non-nil arguments.
                     
                     The size proposed to this view is the size proposed to the frame, limited by any constraints specified, and with any ideal dimensions specified replacing any corresponding unspecified dimensions in the proposal.

                     If no minimum or maximum constraint is specified in a given dimension, the frame adopts the sizing behavior of its child in that dimension. If both constraints are specified in a dimension, the frame unconditionally adopts the size proposed for it, clamped to the constraints. Otherwise, the size of the frame in either dimension is:
                     如果在给定的尺寸中没有指定最小(minWidth、Height)或最大(maxWidth、Height)约束，则最终的frame会根据子View的尺寸来决定。如果在一个维度(width、height)中指定了这两个约束(minimum、maximum)，那么SwiftUI会使用所设置的数值来决定View的尺寸。
                     框架无条件地采用为其所提议的尺寸，并夹紧在约束中。否则，帧的大小在任何一个维度都是

                     * If a minimum constraint is specified and the size proposed for the frame by the parent is less than the size of this view, the proposed size, clamped to that minimum.
                     * 如果指定了minWidth、Height，并且View的真实尺寸(width、height)小于父View建议的尺寸，那就会使用这个最小值

                     * If a maximum constraint is specified and the size proposed for the frame by the parent is greater than the size of this view, the proposed size, clamped to that maximum.
                     * 如果指定了最大值，并且真实的尺寸大于父View建议的尺寸，就会使用最大值

                     * Otherwise, the size of this view.
                     
                     */
                    .frame(idealWidth: 80)
                    .background(Color.green)
            }
            .frame(width: superViewWidth, height: 100)
            .background(Color.orange)
            
            Slider(value: $superViewWidth, in: 10...300)
                .padding()
                .accentColor(.orange)
            
            TextField("输入文字", text: $flexSizeText)
        }
    }
    
    var doFrameVSSpacer: some View {
        VExampleView("frame vs Spacer") {
         
            /*:
             
             */
            HStack{
                Text("Rule of the party")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.pink)
                
                Image(systemName: "info.circle.fill")
            }
            
            HStack{
                Text("Rule of the party")
                    .background(Color.green)
                
                Spacer()
                
                Image(systemName: "info.circle.fill")
            }
        }
    }
    
    struct ContainerView<Content>: View where Content: View {
        private var width: CGFloat
        private var content: Content
        init(width: CGFloat = 300, @ViewBuilder content: () -> Content) {
            self.width = width
            self.content = content()
        }
        var body: some View{
            
            HStack(spacing: 0){
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
                
                HStack(spacing: 0){
                    Group{
                        content
                    }
                    .measure()
                }
                .frame(width:width, height: 40)
                .border(Color.gray)
                
                Circle()
                    .fill(Color.blue)
                    .frame(width: 20, height: 20)
            }
        }
    }
}

struct AlbumView: View {
    var body: some View{

        VStack{
            
            ZStack(alignment: .bottomLeading) {
                
                Image("icon_tecxture_13")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
                
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 50, height: 30)
                    .foregroundColor(.gray)
                    .clipped()
                    .overlay(
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                    )
                    .offset(CGSize(width: 0, height: 10))
            }
            
            Text("Jay.Chow")
                .font(.system(size: 14, design: Font.Design.rounded))
                .frame(maxWidth: 80, alignment: .leading)
        }
    }
}

extension Alignment {
    
    mutating func change() {
        if self == .topLeading {
            self = .top
        } else if self == .top {
            self = .topTrailing
        } else if self == .topTrailing {
            self = .leading
        } else if self == .leading {
            self = .center
        } else if self == .center {
            self = .trailing
        } else if self == .trailing {
            self = .bottomLeading
        } else if self == .bottomLeading {
            self = .bottom
        } else if self == .bottom {
            self = .bottomTrailing
        } else if self == .bottomTrailing {
            self = .topLeading
        }
    }
}

extension View {
    func measure() -> some View {
        overlay(viewWidth)
    }
    
    private var viewWidth: some View {
        GeometryReader{ proxy in
            Text("\(Int(proxy.size.width))")
        }
    }
}
struct DoFrame_Previews: PreviewProvider {
    static var previews: some View {
        DoFrame()
    }
}

struct WechatCell: View {
    var body: some View {
        HStack {
            Image("icon")
            VStack {
                HStack{
                    Text("name")
                    Spacer()
                    Text("time")
                }
                Text("last chat message")
            }
        }
    }
}
/*:
 
 Q:
 1. 你觉得 SwiftUI 这门技术怎么样？
 2. SwiftUI 的优势和劣势在哪？
 3. 你觉得 SwiftUI 的前景怎么样？
 
 A:
 最近在系统的学习SwiftUI，看到话题就来说下使用感受。
 
 我觉得第一个问题可以改一下，“SwiftUI这门用于构建声明式布局的UI框架怎么样？”，这么描述一下就可以将它与UIKit、AppKit的不同体现出来了。
 
 我是做iOS移动端开发的，常用的构建界面框架就是系统的UIKit。在UIKit中，数据与视图其实是没有关系，但又有关系的。没有关系是说数据驱动不了视图的构建，视图的构建也不是特别依赖数据，有关系是指视图上承载的内容是由数据提供的，而数据也可以影响视图的显示形式。这就导致一个问题，**数据的变动没有办法实时的在视图上体现出来**。在之前使用过很多种响应式框架（RAC、RxSwift等等），它们都有对UI部分的拓展，用来将数据与视图进行绑定，实时的将数据渲染到视图上。做过前端的同学都知道Vue这种框架拯救了多少头发，在我看来SwiftUI之于iOS开发就相当于Vue之于Web开发，所不同的是SwiftUI是官方提供的框架，一款基于多种编译器优化、语言特性、DSL等等，及其轻量的布局框架。
 
 将视图抽离成“视图”，使得我们构建界面的时候可以更便捷、高效。
 
 一个简单的使用SwiftUI构建微信会话cell如下：
 
 ```swift
 struct ConversationView: View {
     var body: some View {
         HStack {
             Image("icon")
             VStack {
                 HStack{
                     Text("name")
                     Spacer()
                     Text("time")
                 }
                 Text("last chat message")
             }
         }
     }
 }
 ```
 通过这些具有`描述性质`的组件，我们知道这里需要放一个图片、那里是一个文本、他们需要水平排列、他们之间有间隔等等。没有了在UIKit中编写UITableViewCell的方式，没有继承，我们可以把它当做一个视图来使用，在任何地方使用它。并且在业务变得复杂的时候，也可以拆分成更小的视图，小视图组成大视图，这一点与UIKit没有区别，但是在SwiftUI中没有了继承的包袱，小视图也更加的轻量。
 
 当然了，便捷的背后少不了SwiftUI中的`布局`，SwiftUI中的布局也是描述性的，但这种描述性与Auto Layout中的描述性还不一样。借鉴CSS中优秀的布局经验，SwiftUI中的的视图依托于自身内容撑起的尺寸，在各种修饰性的布局描述下，最终展现出预期的效果，这一点上会比Auto Layout更高效。
 
 贯穿视图与数据之间的桥梁是SwiftUI中的`Data Flow`，具体就是那几种描述数据的类型（State、Binding等等），秉承`Single Source of Trut`的核心思路，数据可以被安全的渲染到视图上。在SwiftUI中，数据可以说是与视图同等重要的角色，这也是我们开发中最重要的部分，无论是请求返回还是数据库查询，数据除了是商业层面上的核心竞争力，也是我们研发层中最头疼的部分。SwiftUI结合同为系统框架的Combine来处理数据，将数据的流向、转换更具备响应式。
 
 这么久使用SwiftUI下来的感受是，**它并不是一个完善的框架**，其标榜的是UI框架，但是与UIKit对比起来就差了些意思。先不说思路的转变，比如UITableView、UICollectionView在SwiftUI中转换成List、Lazy*Grid这些，单说Lazy*Grid还是在2.0版本才添加的功能。一个我们最常用的ScrollView中offset的监听，就需要自己实现逻辑，这只是使用过程中的一点不便。还有很多在UIKit中存在，但是在SwiftUI中不存在的组件，这些东西要不然需要通过`UIViewRepresentable`桥接，要不就需要自己实现。遇到比较复杂的功能，使用纯SwiftUI定制化起来太麻烦，不如直接使用UIKit实现，然后桥接到SwiftUI上。另外很多人反馈的有些视图有bug，我至今还没有遇到。作为一个横空出世的框架，SwiftUI的文档能力并不是很详尽，很多内容很简单，但却需要不停的推敲、实验、验证，可能是因为自己英文理解能力太低吧。作为SwiftUI中调试很重要的一个功能，`Preview`也有很多bug，时不时的会导致编译器卡顿，预览报错。
 
 如果站在2015年我看待Swift的时间点上，我会极力纠正自己，让自己一定要去了解Swift，而不是忽视它。虽然Swift语法一年一变，一开始只能用来写demo，并且去年写的demo，今年就可能编译不通过。但是在当时，Swift被称为是iOS开发的未来，而站在2021年的时间点上，这个未来已经来了。各个大厂都开始逐步使用Swift来替换OC的代码逻辑，有的产品直接Pure Swift开发，ABI稳定，社区、官方百花齐放，这些在当时都是可以预见的。当然这也是个相辅相成的结果，官方稳定更新，社区有热情，官方接收社区的建议继续更新，社区继续热情，最终造就了Swift的今天。SwiftUI就像当年的Swift，Swift要革OC的命，现在SwiftUI也要革UIKit的命。
 
 当年Swift只是一个翻译OC的语言，现在它已经成长为具有自身特点的语言，是那种回不了OC的特点，目前SwiftUI正处在逐步替换UIKit的进程中，但是与Swift不同，SwiftUI仅仅是一个UI框架，而Swift则是一个完备的编程语言。总结一句话，我个人对SwiftUI持有观望、学习的态度。
 
 最后我想说的是，往往新出来一门技术，狂热者会为了体现其与众不同疯狂的贬低现有技术来拔高它，而看衰者则会以各种理由来否定它。一门技术的出现也不是偶然，一门技术的背后有很多东西是我们不了解的，去学习了解它，再疯狂，再看衰也不迟。
*/
