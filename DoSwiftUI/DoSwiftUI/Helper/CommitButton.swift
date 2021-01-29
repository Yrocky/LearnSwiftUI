//
//  CommitButton.swift
//  DoSwiftUI
//
//  Created by rocky on 2021/1/22.
//

import SwiftUI

struct CommitButton<Content: View>: View {
    
    private let action: () -> ()
    private let content: Content
    private var isComplete: Bool
    
    @State private var isProgress: Bool
    
    init(isComplete: Bool, action: @escaping () -> (), @ViewBuilder label: () -> Content) {
        self.isComplete = isComplete
        self.action = action
        self.content = label()
        self._isProgress = State(initialValue: false)
    }
    
    var body: some View {
        Button {
            if !self.isProgress {
                self.action()
            }
            withAnimation {
                self.isProgress = true
            }
        } label: {
            VStack{
                
                if self.isProgress && !self.isComplete {
                    ProgressView()
                } else if self.isComplete {
                    Image(systemName: "checkmark")
                } else {
                    content
                }
            }
            .frame(
                maxWidth: unnormalState ? 50 : .infinity,
                maxHeight: unnormalState ? 50 : nil
            )
            .padding(.vertical, unnormalState ? 0 : 10)
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(unnormalState ? 25 : 10)
            .padding(10)
        }
    }
    
    var unnormalState: Bool {
        isComplete || isProgress
    }
}

struct CommintButtonExample: View {
    
    @State private var isComplete: Bool = false
    
    var body: some View{
        
        CommitButton(isComplete: isComplete) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isComplete = true
            }
        } label: {
            Text("Commit")
        }
    }
}

struct CommitButton_Previews: PreviewProvider {
    static var previews: some View {
        CommintButtonExample()
    }
}
