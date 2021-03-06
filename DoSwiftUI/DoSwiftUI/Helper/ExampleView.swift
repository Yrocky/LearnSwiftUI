//
//  ExampleView.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/24.
//

import SwiftUI

// MARK: Environment

private struct ExampleViewWithKey: EnvironmentKey {
    static let defaultValue: CGFloat = 300
}

extension EnvironmentValues {
    var exampleViewWidth: CGFloat {
        get { self[ExampleViewWithKey.self] }
        set { self[ExampleViewWithKey.self] = newValue }
    }
}

struct ExampleConfig {
    
    fileprivate var describe: String
    fileprivate var width: CGFloat
    fileprivate var height: CGFloat?
    fileprivate var spacing: CGFloat
    fileprivate var version: String

    
    init(_ describe: String = "Default", version: String = "", spacing: CGFloat = 10, width: CGFloat = 300, height: CGFloat? = nil) {
        self.describe = describe
        self.width = max(300, width)
        self.height = max(40, height ?? 0)
        self.spacing = spacing
        self.version = version
    }
}

protocol ExampleViewAble: View {

    associatedtype Content = View
//
//    var content: () -> Content { get set }
//
//    var config: ExampleConfig { get set }

//    init(config: ExampleConfig, content: @escaping () -> Content)
    
    init(
        _ title: String,
        spacing: CGFloat,
        width: CGFloat,
        height: CGFloat,
        version: String,
        @ViewBuilder content: @escaping () -> Content
    )
}

extension ExampleViewAble {
    
    init(
        title: String = "",
        spacing: CGFloat = 10,
        width: CGFloat = .infinity,
        height: CGFloat = .infinity,
        version: String = "",
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(title, spacing: spacing, width: width, height: height, version: version, content: content)
    }
    
//    init(_ config: ExampleConfig, @ViewBuilder content: @escaping () -> Content) {
//        self.init(config: config, content: content)
//    }
}

struct ExampleContainerView<Content>: View where Content: View {
    
    private var content: () -> Content
    private var config: ExampleConfig
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @inlinable public init(
        _ title: String = "Default",
        spacing: CGFloat = 10,
        width: CGFloat = .infinity,
        height: CGFloat = .infinity,
        version: String = "",
        @ViewBuilder content: @escaping () -> Content
    ){
        self.content = content
        self.config = ExampleConfig(
            title,
            version: version,
            spacing: spacing,
            width: width,
            height: height
        )
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                
                TitleView(config.describe, version: config.version)
                
                Spacer(minLength: 30)
                
                //: Invalid frame dimension (negative or non-finite).
                VStack(spacing: config.spacing, content:content)
//                    .frame(width: config.width)
            }
        }
        .navigationBarHidden(true)
        .lazyPop()
//        .navigationBarTitleDisplayMode(.inline)
    }
    
    struct TitleView: View {
        
        var title: String
        var version: String
        
        init(_ title: String, version: String = "") {
            self.title = title
            self.version = version
        }
        
        var body: some View {
            
            ZStack(alignment: .bottom) {
                
                HStack{
                    
                    Text(title)
                        .font(.largeTitle)
                    
                    ExampleVersionView(version)
                }
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 3)
                    .cornerRadius(4)
            }
        }
    }
}

struct VExampleView<Content>: View where Content: View {
    
    @Environment(\.exampleViewWidth)
    private var exampleViewWidth: CGFloat
    
    private var content: () -> Content
    private var config: ExampleConfig
    
    @inlinable public init(
        _ describe: String = "Default",
        version: String = "",
        spacing: CGFloat = 10,
        height: CGFloat = .infinity,
        @ViewBuilder content: @escaping () -> Content
    ){
        self.content = content
        self.config = ExampleConfig(
            describe,
            version: version,
            spacing: spacing,
            height: height
        )
    }
    
    var body: some View {
        
        ExampleInnerView(config.version) {
            
            VStack{
                
                VStack(alignment: .center, spacing: config.spacing, content: content)
                    .frame(width: exampleViewWidth, height: config.height)
                    .padding()
                    .environment(\.exampleViewWidth, 300)
                    .border(Color.tintColor, width: 1)
                
                ExampleDescribeView(
                    tintColor: .tintColor,
                    describe: config.describe
                )
                .frame(maxWidth: config.width, minHeight: 20)
            }
        }
    }
}

struct HExampleView<Content>: View where Content: View {
    
    @Environment(\.exampleViewWidth)
    private var exampleViewWidth: CGFloat

    private var content: () -> Content
    
    private var config: ExampleConfig
    
    @inlinable public init(
        _ describe: String = "Default",
        version: String = "",
        spacing: CGFloat = 10,
        height: CGFloat = .infinity,
        @ViewBuilder content: @escaping () -> Content
    ){
        self.content = content
        self.config = ExampleConfig(
            describe,
            version: version,
            spacing: spacing,
            height: height
        )
    }

    var body: some View {
        
        ExampleInnerView(config.version) {
            
            VStack(alignment: .center){
                
                HStack(alignment: .center, spacing: config.spacing, content: content)
                    .frame(width: exampleViewWidth, height: config.height)
                    .padding()
                    .border(Color.tintColor, width: 1)
                
                ExampleDescribeView(
                    tintColor: .tintColor,
                    describe: config.describe
                )
                .frame(maxWidth: config.width, minHeight: 20)
            }
        }
    }
}

struct VScrollExampleView<Content>: View where Content: View {
    
    @Environment(\.exampleViewWidth)
    private var exampleViewWidth: CGFloat
    
    private var content: () -> Content
    
    private var config: ExampleConfig
    
    @inlinable public init(
        _ describe: String = "Default",
        version: String = "",
        spacing: CGFloat = 10,
        height: CGFloat = .infinity,
        @ViewBuilder content: @escaping () -> Content
    ){
        self.content = content
        self.config = ExampleConfig(
            describe,
            version: version,
            spacing: spacing,
            height: height
        )
    }

    var body: some View {
        
        ExampleInnerView(config.version) {
            
            VStack{
                
                ScrollView(showsIndicators: false){
                    
                    VStack(alignment: .leading, spacing: config.spacing, content: content)
                        .padding()
                }
                .frame(width: exampleViewWidth, height: config.height)
                .border(Color.tintColor, width: 1)
                
                ExampleDescribeView(
                    tintColor: .tintColor,
                    describe: config.describe
                )
                .frame(maxWidth: config.width, minHeight: 20)
            }
        }
    }
}

struct HScrollExampleView<Content>: View where Content: View {
    
    @Environment(\.exampleViewWidth)
    private var exampleViewWidth: CGFloat
    
    private var content: () -> Content
    
    private var config: ExampleConfig
    
    @inlinable public init(
        _ describe: String = "Default",
        version: String = "",
        spacing: CGFloat = 10,
        height: CGFloat = .infinity,
        @ViewBuilder content: @escaping () -> Content
    ){
        self.content = content
        self.config = ExampleConfig(
            describe,
            version: version,
            spacing: spacing,
            height: height
        )
    }

    var body: some View {
        
        ExampleInnerView(config.version) {
            
            VStack(alignment: .center){
                
                ScrollView(.horizontal, showsIndicators: false){
                    
                    HStack(alignment: .center, spacing: config.spacing, content: content)
                }
                .frame(width: exampleViewWidth, height: config.height)
                .padding()
                .border(Color.tintColor, width: 1)
                
                ExampleDescribeView(
                    tintColor: .tintColor,
                    describe: config.describe
                )
                .frame(maxWidth: config.width, minHeight: 20)
            }
        }
    }
}

fileprivate struct ExampleInnerView<Content>: View where Content: View {
    
    private var content: () -> Content
    fileprivate var version: String
    
    init(
        _ version: String = "",
         @ViewBuilder content: @escaping () -> Content
    ) {
        self.version = version
        self.content = content
    }
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            content()
                .padding()
//                .background(
//                    Text("@Y_rocky")
//                        .font(.system(size: 14))
//                        .rotationEffect(Angle(degrees: 15))
//                        .foregroundColor(Color.gray.opacity(0.1))
//                )
            
            ExampleVersionView(version)
        }
        .takeScreenhot()
    }
}

fileprivate struct ExampleDescribeView: View{
    
    var tintColor: Color
    var describe: String
    
    var body: some View {
        HStack(spacing: 5){

            Rectangle()
                .fill(tintColor)
                .frame(width: 30, height: 1)
            
            Text(describe)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            Rectangle()
                .fill(tintColor)
                .frame(width: 30, height: 1)
        }
    }
}

fileprivate struct ExampleVersionView: View {
    
    let version: String
    init(_ version: String = "") {
        self.version = version
    }

    var body: some View {
        
        Group{
            if version.count > 0 {
                Text(version)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                    .foregroundColor(.white)
                    .font(.system(size: 17))
                    .background(Color.red)
                    .frame(height: 20)
                    .cornerRadius(10)
            }
        }
    }
}

fileprivate extension Color {
    
    static let darkBackgroundColor: Color = Color(red:0.14, green:0.15, blue:0.19)
    static let normalBackgroundColor: Color = Color(red:0.83, green:0.87, blue:0.89)
    
    static let themeColor: Color = Color(red:0.08, green:0.52, blue:0.82)
    
    static let mainColor: Color = Color(red:0.56, green:0.64, blue:0.75)
    static let subColor: Color = Color(red:0.14, green:0.15, blue:0.19)
    
    static let tintColor: Color = Color(red: 0.95, green: 0.95, blue: 0.95)
}
