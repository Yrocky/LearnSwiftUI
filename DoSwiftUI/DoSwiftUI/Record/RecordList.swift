//
//  RecordList.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/9.
//

import SwiftUI

struct RecordList: View {
    
    var body: some View {
        
        List{
            ForEach(0..<10) { _ in
                RecordItemView()
            }
        }
    }
}

struct RecordItemView: View {
    var  body: some View {
        Text("ssdsdsdfs")
            .padding()
            .background(
                Rectangle()
                    .fill(Color.blue)
                    .cornerRadius(10)
            )
    }
    
}

struct RecordList_Previews: PreviewProvider {
    static var previews: some View {
        RecordList()
    }
}
