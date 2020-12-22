//
//  DoGroup.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/18.
//

import SwiftUI

struct DoGroup: View {
    
    var body: some View {
        
        doBasic
        
        doDiffWithStack
        
        doGroupWithOptional
        
        doGroupWithSwitch
    }
    
    var doBasic: some View {
        VStack{
            /*:
             使用Group可以将View分成组，但是他有最大15个的限制，
             和各种Stack不同，Group并没有特殊的显示逻辑，仅仅是将View成组。
             */
            Group{
                Text("Hello, World!")
                Text("Hello, World!")
            }
            .font(.system(size: 19))
            .foregroundColor(.blue)
            .border(Color.orange, width: 1)
            .padding()
            .border(Color.gray, width: 1)
            
            /*:
             任意类型的View都可以被添加到Group中
             */
            Group{
                Text("Hello, World!")
                Label(
                    title: { Text("This is a circle icon loaded by sf-symbols") },
                    icon: { Image(systemName: "42.circle").foregroundColor(.green) })
            }
            .font(.system(size: 29))
            .foregroundColor(.red)
            .border(Color.gray, width: 1)
        }
    }
    
    var doDiffWithStack: some View {
        
        VStack{
            /*:
             作用在Group上的modifer会依次作用到内部的View，
             并且在视图层次结构中也并不会存在Group所对应的视图。
             */
            Group{
                Text("Use")
                Text("Group")
                    .foregroundColor(.red)
                Text("to")
                Text("preview")
            }
            .foregroundColor(.blue)
            .font(.system(size: 19))
            .border(Color.green)
            .background(Color.orange)
            
            Divider()
            
            /*:
             `*Stack`类型的控件也不会在视图层级中有对应的视图，
             但是其添加的modifer也仅仅是作用在当前的Stack上，
             并不会依次作用到内部的View上。
             */
            VStack{
                Text("Use")
                Text("VStack")
                    .foregroundColor(.red)
                Text("to")
                Text("preview")
            }
            //: 但是某些modifer还是会作用到子View，比如这个`foregroundColor`
            .foregroundColor(.blue)
            .font(.system(size: 19))
            .border(Color.green)
            .background(Color.orange)
        }
    }
    
    @State var someOptionalValueMaybeNull :Int?
    
    var doGroupWithOptional: some View {
        
        HStack{
            /*:
             在使用一些可选类型来构建UI的时候，我们可能只需要在`为非nil的分支`中返回一个View，比如下面这样：
             ```swift
             var someOptionalValueMaybeNull :Int?
             
             var body: some View {
             
                 if let value = someOptionalValueMaybeNull {
                     return Text("this text maybe show \(value)")
                             .foregroundColor(.red)
                 }
             
                 // 这里还需要返回一个View，不然会编译报错，
                 return EmptyView()// 作为一个临时解决方案，可以返回`EmptyView()`
             }
             ```
             但我们有时候并不知道在`nil情况`下返回何种View，并不能很好的完成界面逻辑，
             作为一个临时解决方案，可以返回`EmptyView()`，
             但如果在所有这样的场景下都这么处理会比较冗余，扰乱业务逻辑。
             
             还好swiftUI中提供的Group可以完成这个任务，在Group中，
             我们可以使用if-else、switch等简单的逻辑。
             在这个实例中，我们在else分支中没有返回任何View，Group内部会默认为我们返回一个`EmptyView`。
             
             > 由于Group有一个使用`ViewBuilder`的初始化方法，所以会在没有任何View返回的时候，使用EmptyView作为默认返回值，所以内部支持if-else、switch等逻辑。
             */
            
            Group{
                if let value = someOptionalValueMaybeNull {
                    Text("this text maybe show \(value)")
                        .foregroundColor(.red)
                }
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(4)
            .font(.system(size: 20))
            
            Button(action: {
                if self.someOptionalValueMaybeNull != nil {
                    self.someOptionalValueMaybeNull = nil
                } else {
                    someOptionalValueMaybeNull = 10
                }
            }, label: {
                Text("Tap me!")
            })
        }
        .padding()
    }

    enum Language {
        case swift
        case objc
        
        mutating func toggle() {
            switch self {
            case .swift:
                self = .objc
            case .objc:
                self = .swift
            }
        }
    }
    
    @State var usedLanauage: Language = .swift
    
    var doGroupWithSwitch: some View {
        
        HStack(spacing: 10) {
            
            Text("You used language is:")
            /*:
             同样的，在Group中也可以使用`switch-case`语法，
             */
            Group{
                switch usedLanauage {
                case .swift: Text("Swift")
                case .objc: Text("Objective-C")
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .font(.system(size: 18))
            .foregroundColor(.purple)
            .cornerRadius(4)
            
            Button(action: {
                self.usedLanauage.toggle()
            }, label: {
                Text("Change")
            })
        }
    }
    
    @State var counter = 5
    
    var doGroupWithWhile: some View {
        
        HStack(spacing: 10) {
            
            Group{

                /*:
                 不过在Group中并不支持`while`语法，这是因为在支持FunctionBuilder的结构体中，
                 需要实现对应语句的函数，比如if对应的函数为：`buildIf`，
                 else分支对应的函数为：`buildEither`等等，
                 很显然Group并没有实现while对应的函数。
                 */
//                while counter > 0 {
                    
                    Text("GCD")
                    
//                    counter -= 1
//                }
                // Closure containing control flow statement cannot be used with function builder 'ViewBuilder'
            }
            .font(.system(size:12))
            .foregroundColor(.green)
            .padding()
            .background(Color.gray.opacity(0.2))
        }
    }
}

struct DoGroup_Previews: PreviewProvider {
    static var previews: some View {
        DoGroup()
    }
}
