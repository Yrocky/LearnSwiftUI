//
//  ContentView.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/9.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
//            List(DoExampleItem.allCases) { item in
//                NavigationLink(
//                    item.rawValue,
//                    destination: item.body()
//                )
//            }
//
            List{
                ForEach(examp) { i in
                    Section(
                        header: DoExampleHeaderView(i)
                    ) {
                        ForEach(i.items ?? []) { j in
                            NavigationLink(
                                j.rawValue,
                                destination: j.body()
                            )
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationBarTitle("SwiftUI Course")
        }
    }
}

struct DoExampleHeaderView: View {
    
    let data: DoExampleData
    
    init(_ data: DoExampleData) {
        self.data = data
    }
    
    var body: some View{

        HStack{
         
            Image(systemName: data.icon)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(.blue)
                .aspectRatio(contentMode: .fit)
            
            Text(data.name)
                .font(.system(size: 18))
                .foregroundColor(.blue)
            
            Spacer()
        }
    }
}

let examp : [DoExampleData] = [
    DoExampleData("Interface",icon: "heart.text.square", items: [
        .Text, .Image, .Label, .TextField, .SecureField,
        .ProgressView, .Stepper, .Slider, .Toggle,
        .Picker, .TextEditor, .GroupBox, .Gradient,
        .ScrollView, .ActionSheet_Alert, .Empty,
        .OutlineGroup, .DisclosureGroup, .Section,
        .List, .List2, .Grid, .NavigationLink,
        .NavigationBarItem, .NavigationView, .Toolbar
    ]),
    
    DoExampleData("Layout",icon: "square.grid.3x1.below.line.grid.1x2", items: [
        .Stack, .LazyStack, .Frame, .Group, .ForEach,
        .Alignment, .LayoutPriority, .FixedSize, .Anchor,
        .SafeArea, .Spacer, .GeometryReader, .Layout, .CoordinateSpace
    ]),
    
    DoExampleData("Shape",icon: "circle.square", items: [
        .Fill, .Stroke, .Border, .StrokeBorder, .Color,
        .Path, .Shape, .CustomShape, .BackgroundOverlay
    ]),
    
    DoExampleData("Geature",icon: "hand.draw", items: [
        .BasicGesture, .ComposingGesture, .GestureViewModifer
    ]),
    
    DoExampleData("Animation",icon: "circle.grid.cross.left.fill", items: [
        .AnimationViewModifer, .Animation, .Transaction, .Animatable,
        .VectorArithmetic, .GeometryEffect
    ]),
    
    DoExampleData("Data Flow",icon: "bonjour", items: [
        .State_Binding, .Environment, .Preference,
        .ObservedObject, .StateObject, .EnvironmentObject
    ]),
]

struct DoExampleData: Hashable, Identifiable {
    
    let id = UUID()
    var name : String
    var icon : String
    var items: [DoExampleItem]? = nil
    
    init(_ name: String, icon: String = "", items: [DoExampleItem]? = nil) {
        self.name = name
        self.items = items
        self.icon = icon
    }
}

enum DoExampleItem: String, Identifiable, CaseIterable {
    
    // interface
    case Text, Image, Label, TextField, SecureField
    case ProgressView, Stepper, Slider, Toggle
    case Picker, TextEditor, GroupBox, Gradient
    case ScrollView, ActionSheet_Alert, Empty
    // list
    case OutlineGroup, DisclosureGroup, Section
    case List, List2
    
    case Grid
    case NavigationLink, NavigationBarItem, NavigationView
    case Toolbar
    
    // layout
    case Stack, LazyStack, Frame, Group, ForEach
    case Alignment, LayoutPriority, FixedSize, Anchor
    case SafeArea, Spacer, GeometryReader, Layout, CoordinateSpace
    
    // shape
    case Fill, Stroke, Border, StrokeBorder, Path
    case Color, Shape, CustomShape, BackgroundOverlay
    
    // geature
    case BasicGesture, ComposingGesture, GestureViewModifer
    
    // animation
    case AnimationViewModifer, Animation, Transaction, Animatable
    case VectorArithmetic, GeometryEffect
    
    // data flow
    case State_Binding, Environment, Preference
    case ObservedObject, StateObject, EnvironmentObject
    
    var id: String { self.rawValue }
}

extension DoExampleItem {
    
    func body() -> AnyView {
        
        AnyView(
            SwiftUI.Group{
                
                switch self {
                case .Text: DoText()
                case .Image: DoImage()
                case .Label: DoLabel()
                case .TextField: DoTextField()
                case .Stepper: DoStepper()
                case .Slider: DoSlider()
                case .Toggle: DoToggle()
                case .ProgressView: DoProgressView()
                case .SecureField: DoSecureField()
                case .Picker: DoPicker()
                case .TextEditor: DoTextEditor()
                case .GroupBox: DoGroupBox()
                case .Gradient: DoGradient()
                case .ScrollView: DoScrollView()
                case .ActionSheet_Alert: DoActionSheetAlert()
                case .Empty: DoEmpty()
                case .OutlineGroup: DoOutlineGroup()
                case .DisclosureGroup: DoDisclosureGroup()
                case .Section: DoSection()
                case .List: DoList()
                case .List2: DoList_2()
                case .Grid: DoGrid()
                case .NavigationLink: DoNavigationLink()
                case .NavigationBarItem: DoNavigationBarItem()
                case .NavigationView: DoNavigationView()
                case .Toolbar: DoToolbar()
                case .Stack: DoStack()
                case .LazyStack: DoLazyStack()
                case .Frame: DoFrame()
                case .Group: DoGroup()
                case .ForEach: DoForEach()
                case .Alignment: DoAlignment()
                case .LayoutPriority: DoLayoutPriority()
                case .FixedSize: DoFixedSize()
                case .Anchor: DoAnchor()
                case .SafeArea: DoSafeArea()
                case .Spacer: DoSpacer()
                case .GeometryReader: DoGeometryReader()
                case .Layout: DoLayout()
                case .CoordinateSpace: DoCoordinateSpace()
                case .Fill: DoFill()
                case .Stroke: DoStroke()
                case .Border: DoBorder()
                case .StrokeBorder: DoStrokeBorder()
                case .Path: DoPath()
                case .Color: DoColor()
                case .Shape: DoShape()
                case .CustomShape: DoCustomShape()
                case .BackgroundOverlay: DoBackgroundAndOverlay()
                case .Animation: DoAnimation()
                case .State_Binding: DoStateAndBinding()
                case .Environment: DoEnvironment()
                case .Preference: DoPreference()
                case .ObservedObject: DoObservedObject()
                case .StateObject: DoStateObject()
                case .EnvironmentObject: DoEnvironmentObject()
                case .BasicGesture: DoBasicGesture()
                case .ComposingGesture: DoComposingGesture()
                case .GestureViewModifer: DoGestureViewModifer()
                case .Transaction: DoTransaction()
                case .Animatable: DoAnimatable()
                case .VectorArithmetic: DoVectorArithmetic()
                case .GeometryEffect: DoGeometryEffect()
                case .AnimationViewModifer: DoAnimationViewModifer()
                default: EmptyView()
                }
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
