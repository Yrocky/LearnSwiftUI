//
//  ExampleView.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/24.
//

import SwiftUI

struct ExampleConfig {
    
    fileprivate var describe: String
    fileprivate var width: CGFloat
    fileprivate var height: CGFloat
    fileprivate var spacing: CGFloat
    
    init(_ describe: String = "Default", spacing: CGFloat = 10, width: CGFloat, height: CGFloat) {
        self.describe = describe
        self.width = max(300, width)
        self.height = max(40, height)
        self.spacing = spacing
    }
}

protocol ExampleViewAble {

    associatedtype Content = View

    var content: () -> Content { get set }

    var config: ExampleConfig { get set }

    init()
//    init(_ config: Example.Config, @ViewBuilder content: @escaping () -> Content)
}

extension ExampleViewAble where Self : View {
    
    init(
        _ config: ExampleConfig,
        @ViewBuilder content: @escaping () -> Content
    ){
        self.init()
        self.content = content
        self.config = config
    }
}

struct ExampleContainterView<Content>: View where Content: View {
    
    private var content: () -> Content
    private var config: ExampleConfig
    private var version: String = ""
    
    @inlinable public init(
        _ title: String = "Default",
        spacing: CGFloat = 10,
        width: CGFloat = .infinity,
        height: CGFloat = .infinity,
        version: String = "",
        @ViewBuilder content: @escaping () -> Content
    ){
        self.content = content
        self.config = ExampleConfig(title,spacing: spacing, width: width,height: height)
        self.version = version
    }
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                
                TitleView(config.describe, version: version)
                
                Spacer(minLength: 30)
                
                //: Invalid frame dimension (negative or non-finite).
                VStack(spacing: config.spacing, content:content)
                    .frame(width: config.width, height: config.height)
            }
        }
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
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 3)
                    .cornerRadius(4)
            }
        }
    }
}

struct VExampleView<Content>: View where Content: View {
    
    private var content: () -> Content
    private var config: ExampleConfig
    
    @inlinable public init(
        _ describe: String = "Default",spacing: CGFloat = 10, width: CGFloat = 300, height: CGFloat = .infinity,
        @ViewBuilder content: @escaping () -> Content
    ){
        self.content = content
        self.config = ExampleConfig(describe,spacing: spacing, width: width,height: height)
    }
    
    var body: some View {
        
        VStack{
            
            VStack(alignment: .center, spacing: config.spacing, content: content)
                .frame(width: config.width, height: config.height)
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

struct HExampleView<Content>: View where Content: View {
    
    private var content: () -> Content
    
    private var config: ExampleConfig
    
    @inlinable public init(
        _ describe: String = "Default", spacing: CGFloat = 10, width: CGFloat = 300, height: CGFloat = .infinity,
        @ViewBuilder content: @escaping () -> Content){
        self.content = content
        self.config = ExampleConfig(describe,spacing: spacing, width: width,height: height)
    }

    var body: some View {
        
        VStack(alignment: .center){
            
            HStack(alignment: .center, spacing: config.spacing, content: content)
                .frame(width: config.width, height: config.height)
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

struct VScrollExampleView<Content>: View where Content: View {
    
    private var content: () -> Content
    
    private var config: ExampleConfig
    
    @inlinable public init(
        _ describe: String = "Default",spacing: CGFloat = 10,  width: CGFloat = 300, height: CGFloat = .infinity,
        @ViewBuilder content: @escaping () -> Content){
        self.content = content
        self.config = ExampleConfig(describe,spacing: spacing, width: width,height: height)
    }

    var body: some View {
        
        VStack{
            
            ScrollView{
                    
                VStack(alignment: .leading, spacing: config.spacing, content: content)
                    .padding()
            }
            .frame(width: config.width, height: config.height)
            .border(Color.tintColor, width: 1)
            
            ExampleDescribeView(
                tintColor: .tintColor,
                describe: config.describe
            )
            .frame(maxWidth: config.width, minHeight: 20)
        }
    }
}

struct HScrollExampleView<Content>: View where Content: View {
    
    private var content: () -> Content
    
    private var config: ExampleConfig
    
    @inlinable public init(
        _ describe: String = "Default",spacing: CGFloat = 10,  width: CGFloat = 300, height: CGFloat = .infinity,
        @ViewBuilder content: @escaping () -> Content){
        self.content = content
        self.config = ExampleConfig(describe,spacing: spacing, width: width,height: height)
    }

    var body: some View {
        
        VStack(alignment: .center){
            
            ScrollView(.horizontal, showsIndicators: false){
                
                HStack(alignment: .center, spacing: config.spacing, content: content)
            }
            .frame(width: config.width, height: config.height)
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

fileprivate extension Color {
    
    static let tintColor: Color = {
        Color(red: 0.95, green: 0.95, blue: 0.95)
    }()
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
        .padding(.bottom, 10)
    }
}
