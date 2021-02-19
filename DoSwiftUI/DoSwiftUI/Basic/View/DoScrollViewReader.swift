//
//  DoScrollViewReader.swift
//  DoSwiftUI
//
//  Created by rocky on 2020/12/28.
//

import SwiftUI

struct DoScrollViewReader: View {
    
    var body: some View {
        
        ExampleContainerView("ScrollViewReader", version:"2.0") {
            
            doBasic
            
            doWithList
            
            doWithListSection
        }
    }
    
    var doBasic: some View {
        
        VExampleView("basic") {
         
            ScrollView(.horizontal) {
                
                ScrollViewReader{ proxy in
                    
                    HStack{
                    
                        ForEach(0..<30) { id in
                            
                            ItemView(id: "\(id)")
                                .frame(width: 50, height: 50)
                                .id(id)
                        }
                    }
                    
                    Button("SctollTo 5") {
                        withAnimation {
                            
                            proxy.scrollTo(5)
                        }
                    }
                }
            }
        }
    }
    
    var doWithList: some View {
        VExampleView("List", height: 200) {
         
            ScrollViewReader{ proxy in
                
                Button("ScrollTo Top") {
                    withAnimation {
                    
                        proxy.scrollTo(1)
                    }
                }
                List{
                    ForEach(1..<20) { value in
                        ItemView(id: "\(value)")
                            .id(value)
                    }
                }
            }
        }
    }
    
    let datas: [Int] = [1,2,3,4]
    
    var doWithListSection: some View {
        
        VExampleView("List Section", height: 300) {
        
            ScrollViewReader { proxy in
                
                ZStack(alignment: .trailing){
                    
                    ListContrainerView(sections: datas)
                    
                    ListSectionIndexView(
                        sections: datas,
                        proxy: proxy
                    )
                }
            }
        }
    }
    
    struct ListContrainerView: View {
        let sections: [Int]
        
        var body: some View{
            List{
                ForEach(sections, id:\.self) { sectionIndex in
                    
                    Section(
                        header: Text("\(sectionIndex)")
                    ) {
                        ForEach(1..<10) { rowIndex in
                            ItemView(id: "\(sectionIndex)-\(rowIndex)")
                                .frame(width: 150)
                        }
                    }
                    .id(sectionIndex)
                }
            }
        }
    }
    
    struct ListSectionIndexView: View {
        
        let sections: [Int]
        let proxy: ScrollViewProxy
        
        var body: some View {
            VStack{
                ForEach(sections, id: \.self) { index in
                    ItemView(id: "\(index)", color: .gray)
                        .frame(width: 30, height: 30, alignment: .center)
                        .onTapGesture {
                            proxy.scrollTo(index, anchor: .top)
                        }
                }
            }
            .padding(.vertical, 4)
            .frame(minWidth: 40)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.white)
                    .shadow(radius: 2)
            )
        }
    }
    
    struct ItemView: View {
        var id: String
        var color: Color = .pink
        
        var body: some View {
            RoundedRectangle(cornerRadius: 10)
                .fill(color)
                .overlay(
                    Text(id)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                )
                .shadow(radius: 2)
        }
    }
}

struct DoScrollViewReader_Previews: PreviewProvider {
    static var previews: some View {
        DoScrollViewReader()
    }
}
