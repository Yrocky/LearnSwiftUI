//
//  DoAnimation.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/18.
//

import SwiftUI

struct DoAnimation: View {
    
    @State private var titleVisible = true
    @State private var transitionFlag = true
    
    var body: some View {
        
        ExampleContainterView("Animation"){
            
            doWithAnimation_1
            
            doWithAnimation_2
            
            doWithAnimation_3
            
            doWithTransaction
            
            doTransition_1
        }
    }
    
    var doWithAnimation_1: some View {
        
        /*:
         在swiftUI中，有两个关于动画的函数：`withAnimation`以及`withTransaction`，
         使用前者包裹的内容将具备动画效果，比如下面在block中改变了titleVisible变量的值，
         某些与该变量有关系的View的显示隐藏将会具备动画效果。
         
         在withAnimation函数中，还可以使用`Animation`类型的实例，来指定具体的动画效果，这个将会在后面讲解。
         另外View有一个关于动画的modifer：`.animation(:)`，
         它接收的也是一个Animation，这里暂时使用系统内置的`easeIn`等实例。
         
         通过下面的例子能发现，使用withAnimation包裹的转换引起的动画等级比较高，
         具体到对应的子View再单独设置了效果也没有用
         */
        VExampleView("在 withAnimation 触发 State 的改变") {
            
            if titleVisible {
                Text("Hello world~")
//                    .animation(.easeIn(duration: 1.2))
            }
            
            Button(action: {
                withAnimation(.easeInOut(duration: 1)) {
                    self.titleVisible.toggle()
                }
            }, label: {
                Text("1 Tap me and then show or hide label")
            })
            
            if !titleVisible {
                Text("Bye world!")
                    //: 没有作用
                    .animation(.easeInOut(duration: 5))
            }
        }
    }
    
    var doWithAnimation_2: some View {

        VExampleView("只使用 animation 不会有动画效果") {
            /*:
             在这个例子中，我们在`titleVisible`发生改变的时候不包裹动画，
             只在View中使用`animation(:)`，会发现，并没有预想中的动画效果出现。
             */
            if titleVisible {
                Text("Hello world~")
                    .animation(.easeInOut)
            }
            
            Button(action: {
                self.titleVisible.toggle()
            }, label: {
                Text("Tap me ,No animation")
            })
            
            if !titleVisible {
                Text("Bye world!")
                    .animation(.easeInOut)
            }
        }
    }
    
    
    var doWithAnimation_3: some View {
        
        VExampleView("Binding 使用 animation") {
            /*:
             在这个例子中，我们使用另一种动画方式，在将状态绑定到Toggle的时候，
             为其添加一个`animation`，这样在状态发生变化的时候就会执行一个隐式的动画。
             */
            if titleVisible {
                Text("Hello world~")
            }
            
            Toggle(isOn: $titleVisible.animation(), label: {
                Text("3 Tap me and then show or hide label")
            })
            
            if !titleVisible {
                Text("Bye world!")
            }
        }
    }
    
    var doWithTransaction: some View {

        VExampleView("在 withTransaction 内触发 State 的改变") {
            
            /*:
             在这个例子中，我们在`titleVisible`发生改变的时候不包裹动画，
             只在View中使用`animation(:)`，会发现，并没有预想中的动画效果出现。
             */
            if titleVisible {
                Text("Hello world~")
            }
            
            Button(action: {
                withTransaction(Transaction(animation: .easeInOut(duration: 2))) {
                    self.titleVisible.toggle()
                }
            }, label: {
                Text("4 Tap me and then show or hide label")
            })
            
            if !titleVisible {
                Text("Bye world!")
            }
        }
    }
    
    var doTransition_1: some View {
        
        /*:
         在上面显示与隐藏`Text("Hello world~")`、`Text("Bye world!")`的时候，
         使用的是系统默认的渐隐渐现，不过我们可以通过`transition(:)`来改变View的出现与隐藏方式。
         目前系统有`move`、`slide`、`scale`、`offset`、`opacity`这几个效果，
         另外还可以通过`combined`来组合以上这几个效果。
         
         不论是单一效果还是组合效果，它们都是对称的，出现的方向和消失的方向是相反的。
         比如，消失的效果是缩放到0.5，那么再次出现则会从0.5到正常尺寸。
         当然swiftUI也允许我们使用不对称的效果，比如消失的效果是缩放到0.5，
         而出现则是移动位移，使用`.asymmetric(:,:)`指明出现、隐藏的效果即可。
         */
        VExampleView("系统内置的 transition 类型", height: 180) {
            
            Toggle(isOn: $transitionFlag.animation(), label: {
                Text("Tap me and then show or hide label")
            })
            
            VStack{
                
                HStack{
                    if transitionFlag {
                        Group{
                            
                            Text("move(top)")
                                .transition(.move(edge: .top))
                            
                            Text("scale(1.2)")
                                .transition(.scale(scale: 1.2))
                            
                            Text("offset({10,10})")
                                .transition(.offset(x: 10, y: 10))
                        }
                        .padding(4)
                        .background(Color.orange)
                        .cornerRadius(4)
                    }
                }
                HStack{
                    if transitionFlag {
                        Group{
                            
                            Text("slide")
                                .transition(.slide)
                            
                            Text("opacity")
                                .transition(.opacity)
                        }
                        .padding(4)
                        .background(Color.orange)
                        .cornerRadius(4)
                    }
                }
                
                if transitionFlag {
                    
                    Group{
                        
                        Text("combined - opacity & slide(0.8)")
                            .transition(AnyTransition.opacity.combined(with: .scale(scale: 0.8)))
                        
                        Text("asymmetric - scale(0.5) & offset(-10)")
                            .transition(.asymmetric(
                                            insertion: .scale(scale: 0.5),
                                            removal: .offset(x: -10))
                            )
                    }
                    .padding(4)
                    .background(Color.orange)
                    .cornerRadius(4)
                }
            }
        }
    }
}

struct DoAnimation_Previews: PreviewProvider {
    static var previews: some View {
        DoAnimation()
    }
}
