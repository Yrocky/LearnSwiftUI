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
                    Section(header: Text(i.name)) {
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

let examp : [DoExampleData] = [
    DoExampleData.init("Interface", items: [
        .Text, .Image, .Label, .TextField, .SecureField,
        .ProgressView, .Stepper, .Slider, .Toggle,
        .Picker, .TextEditor, .GroupBox, .Gradient,
        .ScrollView, .ActionSheet_Alert, .Empty,
        .OutlineGroup, .DisclosureGroup, .Section,
        .List, .List2, .Grid, .NavigationLink, .NavigationView
    ]),
    
    DoExampleData.init("Layout", items: [
        .Stack, .LazyStack, .Frame, .Group, .ForEach,
        .Alignment, .LayoutPriority, .FixedSize, .Anchor,
        .SafeArea, .Spacer, .GeometryReader, .Layout, .CoordinateSpace
    ]),
    
    DoExampleData.init("Shape", items: [
        .Fill, .Stroke, .Border, .StrokeBorder,
        .Color, .Shape, .CustomShape, .BackgroundOverlay
    ]),
    
    DoExampleData.init("Geature", items: [
        
    ]),
    
    DoExampleData.init("Animation", items: [
        .Animation
    ]),
    
    DoExampleData.init("Data Flow", items: [
        .State_Binding, .Environment, .Preference,
        .ObservedObject, .StateObject, .EnvironmentObject
    ]),
]

struct DoExampleData: Hashable, Identifiable {
    
    let id = UUID()
    var name : String
    var items: [DoExampleItem]? = nil
    
    init(_ name: String, items: [DoExampleItem]? = nil) {
        self.name = name
        self.items = items
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
    case NavigationLink, NavigationView
    
    // layout
    case Stack, LazyStack, Frame, Group, ForEach
    case Alignment, LayoutPriority, FixedSize, Anchor
    case SafeArea, Spacer, GeometryReader, Layout, CoordinateSpace
    
    // shape
    case Fill, Stroke, Border, StrokeBorder
    case Color, Shape, CustomShape, BackgroundOverlay
    
    // geature
    
    // animation
    case Animation
    
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
                case .NavigationView: DoNavigationView()
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
