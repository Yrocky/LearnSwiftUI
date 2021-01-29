//
//  BlurImageView.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/29.
//

import SwiftUI


struct BlurImageView: View {
    
    @State private var innerIsBlur: Bool = true
    private var imageName: String
    private var isBlur: Binding<Bool>?
    
    init(imageName: String) {
        self.imageName = imageName
    }
    
    init(imageName: String, isBlur: Binding<Bool>) {
        self.imageName = imageName
        self.isBlur = isBlur
    }
    
    var body: some View{
        Inner(
            imageName: imageName,
            isBlur: isBlur ?? $innerIsBlur// 如果外部没有提供Binding，就使用内部的innerIsBlur生成的Binding
        )
    }
    
    
    struct Inner: View {
        
        private var imageName: String
        private var isBlur: Binding<Bool>
        
        init(
            imageName: String,
            isBlur: Binding<Bool>
        ) {
            self.imageName = imageName
            self.isBlur = isBlur
        }

        var body: some View {
            Image(imageName)
                .resizable()
                .frame(width: 320, height: 175, alignment: .center)
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .blur(radius: isBlur.wrappedValue ? 10 : 0)
                .shadow(radius: 3)
                .onTapGesture {
                    withAnimation {
                        self.isBlur.wrappedValue.toggle()
                    }
                }
        }
    }
}

struct DoBlurImageView: View {
    
    @State private var isBlur: Bool = false
    
    var body: some View{
        
        VStack(spacing: 20){
            
            BlurImageView(imageName: "gods")
            
            VStack{
                
                BlurImageView(imageName: "gods", isBlur: $isBlur)
                
                Text(isBlur ? "Blur" : "Normal")

                Button("Make Image \(!isBlur ? "Blur" : "Normal")") {
                    withAnimation {
                        isBlur.toggle()
                    }
                }
            }
            
        }
    }
}
//struct BlurImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        BlurImageView()
//    }
//}
