//
//  InfiniteListView.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/7.
//

import SwiftUI

struct ListData: Identifiable, Equatable {
    var id = UUID()
    var text: String
}

struct InfiniteListView: View {
    
    let list: [ListData]
    let isLoading: Bool = true
    let onScrolledAtBottom: () -> Void
    
    var body: some View {
        
        List{
            
            contentList
            
            if isLoading {
                
                loadingIndicator
            }
        }
    }
    
    private var contentList: some View {
        ForEach(list) { data in
            
            HStack{

                Text(data.text)
                    .onAppear {
                        if self.list.last == data {
                            self.onScrolledAtBottom()
                        }
                    }
            }
        }
    }
    
    private var loadingIndicator: some View {
        ProgressView("加载中...")
            .progressViewStyle(CircularProgressViewStyle())
    }
}

struct InfiniteListContainer: View {
    
    @ObservedObject var viewModel = InfiniteListViewModel()
    
    var body: some View{
        NavigationView{
            InfiniteListView(
                list: viewModel.dataList,
                onScrolledAtBottom: viewModel.fetchNextPage
            )
            .onAppear(perform: viewModel.fetchNextPage)
            .navigationTitle("InfiniteList")
        }
    }
}

class InfiniteListViewModel: ObservableObject {
    
    @Published var dataList = [ListData]()
    
    private var index: Int = 0
    var offset: Int = 30
    
    func fetchNextPage() {
        
        index += 1
        
        (((index - 1) * offset)..<(offset * index))
            .forEach({
                dataList.append(
                    ListData(text: "\($0)")
                )
            })
    }
}
