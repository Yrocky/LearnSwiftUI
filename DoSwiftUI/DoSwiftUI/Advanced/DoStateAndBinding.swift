//
//  DoStateAndBinding.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/18.
//

import SwiftUI
import Combine
import ToastUI

struct DoStateAndBinding: View {
    var body: some View {
        //: https://developer.apple.com/documentation/swiftui/state-and-data-flow
        //: property wrapper
        ExampleContainterView("State&Binding") {
            
//            doStaticValue
////
//            doState
////
//            doForm
//
//            doSingUpData
            
            doStructSingUpData
            
//            doBinding
//
//            doCustomBinding
        }
    }
    
    @State var text = "World"
    
    var doStaticValue: some View {
        
        VExampleView("Static value") {
            /*:
             我们可以像往常一样，在某些控件中使用变量来展示数据，
             */
            Text("Hello \(text)")
            
            Button("Modif") {
//                modifText()
                self.text = "世界"
            }
        }
    }
    
    @State private var email: String = ""
    
    var doState: some View {
        VExampleView("@State") {
            
            /*:
             当我们需要获取变量最新的状态（值）的时候，我们可以使用@State来标记变量。比如下面的TextField会改变email的值，Text会显示email最新的值，使用@State我们就完成了控件与变量之间的绑定。从前文我们知道State其实是一个`Property Wrappers`，它的projectedValue是一个`Binding类型`的数据，因此我们可以使用$email获得到一个Binding的变量，交给TextField进行初始化使用。
             */
            
            Text("Your email is: \(email)")

            HStack(spacing: 8){
                
                Image(systemName: "envelope")
                
                TextField("input email", text: $email)
            }
            
            InputView(icon:"envelope", placehold: "input email", text: $email)
        }
    }
    
    /*:
     基于精简逻辑的目的，我们将Image和TextField抽离成一个独立的View：InputView，在内部，同样是使用@State将控件和变量进行绑定。
     
     ```swift
     // in FatherView
     InputView(placehold: "input email", text: email)
     ```
     
     但是通过示例发现，父View并不能将email变量、Text控件与InputView中的text进行绑定，如果要实现父View与子View之间的数据绑定，我们需要使用@Binding来标记子View中的text，同时使用InputView的时候需要传递`$email`。
     
     ```swift
     
     // in FatherView
     InputView(placehold: "input email", text: $email)
     
     // in InputView
     struct InputView: View {
         
         //@State var text: String
         @Binding var text: String
        //...
     }
     ```
     */
    
    @State private var account: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
        
    var doForm: some View {
        VExampleView("Form") {
            
            /*:
             如果现在我们的界面需要使用三个InputView来做有任务，那么就需要有三个@State的变量来绑定数据。
             
             ```swift
             
             @State private var account: String = ""
             @State private var password: String = ""
             @State private var confirmPassword: String = ""
             
             InputView(icon: "person", placehold: "account", text: $account)
             InputView(icon: "lock.square.stack", placehold: "password", text: $password)
             InputView(icon: "lock.square.stack", placehold: "confirm password", text: $confirmPassword)
             
             ```
             
             三个变量已经算比较多的了，如果变量继续增多，我们还继续添加变量，这将不是一个明智的方法。我们应该使用一个类型抽象这个场景下的数据，比如一个SingUpData的结构体
             */
            InputView(
                icon: "person",
                placehold: "account",
                text: $account
            )
            
            InputView(
                icon: "lock.square.stack",
                placehold: "password",
                text: $password
            )
            
            InputView(
                icon: "lock.square.stack",
                placehold: "confirm password",
                text: $confirmPassword
            )
            
            Button("Sing up") {
                
            }
            .disabled(account.count < 4 || password != confirmPassword || password.count < 8)
        }
    }
    
    @ObservedObject private var singUpData = SingUpData_cls()
    @State private var presentingToast: Bool = false
    
    var doSingUpData: some View {
        VExampleView("use SingUpData") {
            
//            Text("\(count, specifier: "%.2f")")
            
            InputView(
                icon: "person",
                placehold: "account",
                text: $singUpData.account
            )
            
            InputView(
                icon: "lock.square.stack",
                placehold: "password",
                text: $singUpData.password
            )
            
            InputView(
                icon: "lock.square.stack",
                placehold: "confirm password",
                text: $singUpData.confirmPassword
            )
            
            Button("Sing up") {
                // 调用接口
                self.presentingToast = true
            }
            .disabled(singUpData.isInvalid)
            .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
                print("Toast dismissed")
            } content: {
                ToastView("\(singUpData.account)-\(singUpData.password)")
                    .toastViewStyle(DefaultToastViewStyle())
            }
        }
    }
    
    @State private var singupData: SingUpData = SingUpData()
    var doStructSingUpData: some View {
        VExampleView("struct") {
            
            Text("singup:\($singupData.account.wrappedValue)、\($singupData.password.wrappedValue)、\($singupData.confirmPassword.wrappedValue)")
            
            InputView(
                icon: "person",
                placehold: "account",
                text: $singupData.account
            )
            
            InputView(
                icon: "lock.square.stack",
                placehold: "password",
                text: $singupData.password
            )
            
            InputView(
                icon: "lock.square.stack",
                placehold: "confirm password",
                text: $singupData.confirmPassword
            )
            
            Button("Commit") {
                // singup handle
            }
            .disabled($singupData.account.wrappedValue.count < 4 || $singupData.password.wrappedValue != $singupData.confirmPassword.wrappedValue || $singupData.password.wrappedValue.count == 0 )
        }
    }
    
    @State private var completionAmount: CGFloat = 0.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var doBinding: some View {
        VExampleView("@Binding") {
    
            Rectangle()
                .trim(from: 0, to: completionAmount)
                .stroke(Color.red, lineWidth: 2)
                .frame(width: 200, height: 200)
//                .rotationEffect(.degrees(-90))
                .onReceive(timer) { _ in
                    withAnimation {
                        guard self.completionAmount < 1 else { return }
                        self.completionAmount += 0.25
                    }
                }
            //https://swiftwithmajid.com/2020/04/08/binding-in-swiftui/?utm_campaign=%20SwiftUI%20Weekly&utm_medium=email&utm_source=Revue%20newsletter
            
            /*:
             数据绑定是一种连接数据提供者和使用者并对其进行同步的技术。
             */
            
        }
    }
    
    @State private var option_one = true
    @State private var option_two = false
    @State private var option_three = false
    
    var doCustomBinding: some View {
        VExampleView("custom Binding") {
            /*:
             使用自定义的Binding来实现一个checkbox控件，或者互斥的Toggle
             */
            let binging_one = Binding<Bool>(
                get: { return option_one },
                set: {
                    self.option_one = $0
                    if $0 {
                        self.option_two = false
                        self.option_three = false
                    }
                }
            )
            let binging_two = Binding<Bool>(
                get: { return option_two },
                set: {
                    self.option_two = $0
                    if $0 {
                        self.option_one = false
                        self.option_three = false
                    }
                }
            )
            let binging_three = Binding<Bool>(
                get: { return option_three },
                set: {
                    self.option_three = $0
                    if $0 {
                        self.option_one = false
                        self.option_two = false
                    }
                }
            )
            
            Toggle("Option one", isOn: binging_one)
            
            Toggle("Option two", isOn: binging_two)
            
            Toggle("Option three", isOn: binging_three)
        }
    }
    
    struct InputView: View {
        
        var icon: String
        var placehold: String
//        @State var text: String
        @Binding var text: String
        
        var body: some View {
            
            HStack(spacing: 8){
                
                Image(systemName: icon)
                
//                TextField(placehold, text: text)
                TextField(placehold, text: $text)
            }
            .padding()
        }
    }
    
    class SingUpData_cls: ObservableObject {
        
        @Published var account: String = ""
        @Published var password: String = ""
        @Published var confirmPassword: String = ""
        
        @Published var isInvalid: Bool = true
        
        private var canalleble : AnyCancellable?
        
        init() {
            
            self.canalleble = $account
                .eraseToAnyPublisher()
                .combineLatest($password, $confirmPassword) {
                    return $0.count < 4 || $1 != $2 || $1.count < 4
                }
                .assign(to: \.isInvalid, on: self)
        }
    }
    
    struct SingUpData {
        
        var account: String = ""
        var password: String = ""
        var confirmPassword: String = ""
        
//        var singUpButtonIsValid: AnyPublisher<Bool, Never>{
//            $account
//                .eraseToAnyPublisher()
//                .combineLatest($password, $confirmPassword) {
//                    return $0.count > 4 && $1 == $2 && $1.count > 8
//                }
//                .eraseToAnyPublisher()
//        }
        var disable: Bool {
            account.count < 4 || password != confirmPassword || password.count == 0
        }
    }
}

struct DoStateAndBinding_Previews: PreviewProvider {
    static var previews: some View {
        DoStateAndBinding()
    }
}
