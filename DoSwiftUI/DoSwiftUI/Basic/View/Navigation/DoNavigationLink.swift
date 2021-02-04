//
//  DoNavigationLink.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/27.
//

import SwiftUI

struct DoNavigationLink: View {
    var body: some View {
        ExampleContainerView("NavigationLink") {
            
            doBasic
            
            doActive
            
            doSelection
            
            doUseHashable
            
            doInNavigationView
        }
    }
    
    var doBasic: some View {
        VExampleView("基础用法") {

            /*:
             `NavigationLink`可以为我们提供一个类似于路由的View，
             它有两部分：`Label`、`Destination`构成，
             前者用来展示内容，后者用来表示交互之后的目的View。
             它主要在`NavigationView`中使用，配合着导航做路由跳转，
             因此在常规的地方（非NavigationView中），并不会达到我们预期的效果，
             另外，如果其所处的上层View已经在导航堆栈中，也是可以使用它进行导航路由的。
             */
            Text("When you tap ")
                .font(.system(size: 16))
                .foregroundColor(.orange)
            
            NavigationLink(
                "Show Detail",
                destination: Text("Detail")
            )
            
            Text("you will find it's doesn't work")
                .font(.system(size: 16))
                .foregroundColor(.orange)
        }
    }
    
    @State private var navigationLinkIsActive = false
    
    var doActive: some View {
        VExampleView("isActive") {
         
            /*:
             `NavigationLink`还有两个和活跃状态以及选中状态有关的api，
             我们将会在NavigationView中学习。
             
             如果我们使用`isActive`来创建NavigationLink，
             那么Destination将会在值为true的时候被展示出来。
             */
            NavigationLink(
                "Try to tap me ",
                destination: Text("Detail"),
                isActive: $navigationLinkIsActive
            )
            
            Toggle(isOn: $navigationLinkIsActive) {
                Text("Turn on this Toggle.")
            }
        }
    }
    
    @State private var currentNavigationLinkTag : Int? = nil
    
    var doSelection: some View {
        VExampleView("selection") {
        
            /*:
             使用`tag`、`selection`创建的NavigationLink，
             只会在两者相等的情况下展示Destination。
             */
            HStack{
            
                NavigationLink(
                    "Tag 1",
                    destination: Text("Detail - 1"),
                    tag: 1,
                    selection: $currentNavigationLinkTag
                )
                
                NavigationLink(
                    "Tag 2",
                    destination: Text("Detail - 2"),
                    tag: 2,
                    selection: $currentNavigationLinkTag
                )
                
                NavigationLink(
                    "Tag 3",
                    destination: Text("Detail - 3"),
                    tag: 3,
                    selection: $currentNavigationLinkTag
                )
            }
            
            Picker(selection: $currentNavigationLinkTag, label: Text("")) {
                ForEach(1..<4) { index in
                    Text("\(index)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    enum NavigationOption: Hashable {
        case a, b, c
    }
    
    @State private var selectedOption: NavigationOption? = nil
    
    var doUseHashable: some View {
        HExampleView("Use Hashable") {
            /*:
             使用一个枚举将需要导航的界面列举出来，我们知道selection参数使用的是`Binding<V:Hashable>?`，
             */
            NavigationLink(
                "goto View A",
                destination: Text("View A"),
                tag: NavigationOption.a,
                selection: $selectedOption
            )
            
            NavigationLink(
                "goto View B",
                destination: Text("View B"),
                tag: NavigationOption.b,
                selection: $selectedOption
            )
            
            NavigationLink(
                "goto View C",
                destination: Text("View C"),
                tag: NavigationOption.c,
                selection: $selectedOption
            )
        }
    }
    
    enum NavigationDestination: Hashable {
        case a
        case b
        case c
    }
    
    @State private var destination: NavigationDestination?
    
    var doManyButtonWithNavigationLink: some View {
        VExampleView("Many Button With Navigation Link") {
    
            /*:
             如果我们有多个Button，在点击的时候需要导航到下一个界面，我们并不会去写多个NavigationLink来完成导航，
             */
            
//            NavigationLink.init(destination: <#T##_#>, tag: <#T##Hashable#>, selection: <#T##Binding<Hashable?>#>, label: <#T##() -> _#>)
            
            Button("goto View A"){
                
            }
            
            Button("goto View B") {
                
            }
            
            Button("goto View C") {
                
            }
        }
    }
    
    func destinationView() -> some View {
    
        Text("")
    }
    
    @State private var showNavigationView = false
    
    var doInNavigationView: some View {
    
        VExampleView("in NavigationView") {
        
            /*:
             当在`NavigationView`中使用NavigationLink，才能发挥它的重要作用，
             swiftUI将导航的功能使用NavigationView来抽象，
             只要是其子View是NavigationLink就可以完成一次导航路由。
             */
            Text("tap me")
                .onTapGesture {
                    showNavigationView.toggle()
                }
                .sheet(isPresented: $showNavigationView) {
                    NavigationView{
                        
                        VStack(spacing: 50){
                        
                            Text("Just a Text")
                            
                            NavigationLink(
                                "Goto DoColor",
                                destination: DoColor()
                            )
                            
                            VStack{
                                
                                /*:
                                 在NavigationView内，上面不生效的`isActive`、`section`都将如期生效。
                                 */
                                Toggle(isOn: $navigationLinkIsActive) {
                                    Text("Tap me")
                                }
                                
                                NavigationLink(
                                    "Goto DoText",
                                    destination: DoText(),
                                    isActive: $navigationLinkIsActive
                                )

                                Button("Tap me") {
                                    if let _ = self.currentNavigationLinkTag {
                                        self.currentNavigationLinkTag = nil
                                    } else {
                                        self.currentNavigationLinkTag = 2
                                    }
                                }
                                NavigationLink(
                                    "Goto DoShape",
                                    destination: DoShape(),
                                    tag: 2,
                                    selection: $currentNavigationLinkTag
                                )
                            }
                            .padding()
                        }
                    }
                }
        }
    }
}

struct DoNavigationLink_Previews: PreviewProvider {
    static var previews: some View {
        DoNavigationLink()
    }
}
