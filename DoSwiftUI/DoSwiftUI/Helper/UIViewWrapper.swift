//
//  UIViewWrapper.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/20.
//

import SwiftUI

class CustomUIView: UIView {
    deinit {
        print("CustomUIView deinit")
    }
//    init(text: String) {
//        super.init(frame: .zero)
//        let label =  UILabel()
//        label.text = text
//        label.textColor = .purple
//        label.frame = CGRect(
//            origin: .zero,
//            size: CGSize(width: 80, height: 30)
//        )
//        label.backgroundColor = UIColor.white
//        addSubview(label)
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("CustomUIView init")
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func modif(isOn: Bool) {
        backgroundColor = isOn ? .orange : .green
    }
}

protocol YourUIViewDelegate {

    func oop() -> Void
}

class YourUIView: UIView {
    
    var delegate: YourUIViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        let button = UIButton()
        button.addTarget(
            self,
            action: #selector(onButton),
            for: .touchUpInside
        )
        button.setTitle("Commit", for: .normal)
        addSubview(button)
        button.frame = CGRect(
            origin: .zero,
            size: CGSize(width: 100, height: 30)
        )
    }
    
    @objc func onButton() {
        delegate?.oop()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func modif(color: UIColor) {
        backgroundColor = color
    }
}

struct UIViewWrapperExample: View {
    @State
    private var loading: Bool = false
    
    var body: some View {
        
        VStack{
            Button("Toggle") {
                self.loading.toggle()
            }
            
            UIViewWrapper(CustomUIView()) {
                $0.modif(isOn: loading)
            }
            .frame(width: 100, height: 100)
            .cornerRadius(10)
            .overlay(
                UIViewWrapper(UIActivityIndicatorView()) {
                    if self.loading {
                        $0.startAnimating()
                    } else {
                        $0.stopAnimating()
                    }
                }
            )
            
            YourUIViewWrap() {
                self.loading.toggle()
            }
            .frame(width: 100, height: 80)
            
            UIViewWrapper(YourUIView()) {
                (uiView, context) in
                uiView.modif(color: self.loading ? .orange : .blue)
//                uiView.delegate = context.coordinator
            }
            .frame(width: 100, height: 80)
        }
    }
}

struct UIViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        UIViewWrapperExample()
    }
}

struct YourUIViewWrap: UIViewRepresentable {
    
    var handler: () -> Void
    
    typealias UIViewType = YourUIView

    func makeUIView(context: Context) -> UIViewType {
        let uiview = YourUIView()
        uiview.delegate = context.coordinator
        return uiview
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        context.coordinator.handler = handler
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, YourUIViewDelegate {
        
        var handler: (() -> Void)?
        
        @objc func oop() {
            handler?()
        }
    }
}

/*:
 可以将UIKit中的视图进行wrap，但是无法优雅的处理delegate、block等事件回调
 */
struct UIViewWrapper<Wrapped: UIView>: UIViewRepresentable {
    
    var makeView: () -> Wrapped
    var update: (Wrapped, Context) -> Void
    
    init(_ makeView: @escaping @autoclosure () -> Wrapped,
         updater update: @escaping (Wrapped, Context) -> Void) {
        self.makeView = makeView
        self.update = update
    }
    
    func makeUIView(context: Context) -> Wrapped {
        makeView()
    }
    
    func updateUIView(_ uiView: Wrapped, context: Context) {
        update(uiView, context)
    }
}

extension UIViewWrapper {
    
    init(_ makeView: @escaping @autoclosure () -> Wrapped,
         updater update: @escaping (Wrapped) -> Void) {
        self.makeView = makeView
        self.update = { view, _ in update(view) }
    }
    
    init(_ makeView: @escaping @autoclosure () -> Wrapped) {
        self.makeView = makeView
        self.update = { _, _ in }
    }
}
