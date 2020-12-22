//
//  DoFrame.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/18.
//

import SwiftUI

struct DoFrame: View {
    
    var body: some View {
        
        VStack{
            
            doBasic
            
            doSetupAlignment
            
            doMinIdealMaxFrame
        }
    }
    
    var doBasic: some View {
        
        HStack(alignment: .top, spacing:10) {
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
    
    @State var frameAlignment = Alignment.center
    
    var doSetupAlignment: some View {
        
        VStack(alignment: .center, spacing:10) {
            
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
        .frame(width: 400)
        .padding()
        .onTapGesture {
            withAnimation {
                frameAlignment.change()
            }
        }
    }
    
    @State var superViewWidth: CGFloat = 140.0
    @State var flexSizeText: String = "flex size"
    
    var doMinIdealMaxFrame: some View {
        //: https://developer.apple.com/documentation/swiftui/view/frame(minwidth:idealwidth:maxwidth:minheight:idealheight:maxheight:alignment:)
        VStack{
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

                     * If a minimum constraint is specified and the size proposed for the frame by the parent is less than the size of this view, the proposed size, clamped to that minimum.

                     * If a maximum constraint is specified and the size proposed for the frame by the parent is greater than the size of this view, the proposed size, clamped to that maximum.

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
        .padding()
        .border(Color.gray)
    }
}

extension Alignment {
    
    mutating func change(){
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
struct DoFrame_Previews: PreviewProvider {
    static var previews: some View {
        DoFrame()
    }
}
