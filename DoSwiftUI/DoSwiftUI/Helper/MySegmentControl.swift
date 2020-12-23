//
//  MySegmentControl.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/23.
//

import SwiftUI

struct MySegmentControl: UIViewRepresentable {
   
    var titles: [String]
    @Binding var currentPage: Int
    
    // 初始化UIView
    func makeUIView(context: UIViewRepresentableContext<MySegmentControl>) -> UISegmentedControl {
        let segmentControl = UISegmentedControl(items: titles)
        segmentControl.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateCurrentPage(sender:)),
            for: .valueChanged
        )
        return segmentControl
    }
    
    // 更新UIView的一些状态，比如UIPageControl的currentPage，MapView的location等等
    func updateUIView(_ uiView: UISegmentedControl, context: UIViewRepresentableContext<MySegmentControl>) {
        
        uiView.selectedSegmentIndex = self.currentPage
    }
    
    // 用来连接UIView和SwiftUI的一个路由，主要是实现target-action或者delegate等事件
    func makeCoordinator() -> MySegmentControl.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var segmentView: MySegmentControl
        
        init(_ segmentView: MySegmentControl){
            self.segmentView = segmentView
        }
        
        @objc func updateCurrentPage(sender: UISegmentedControl) {
            self.segmentView.currentPage = sender.selectedSegmentIndex
        }
    }
}
