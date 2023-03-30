//
//  ContentView.swift
//  PassingClosure_RetainCycle_or_not
//
//  Created by pbrewczynski on 30/03/2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var firstView = true
    
    var body: some View {
        
        VStack {
            if firstView {
                FirstView(viewModel: .init())
            } else {
                SecondView(viewModel: .init())
            }
            Button("Toggle") {
                firstView.toggle()
            }
        }
    }
}

class ObservableObjectForFirstView: ObservableObject {
    init() {
        print("init ObservableObjectForFirstTabView")
    }
    
    var insideVariable = 8
    
    func funcThatWillBePassedAsClosureToSubViewFirstView(incomingValue: Int) {
        insideVariable = 9
    }
    
    deinit {
        print("deinig on ObservableObjectForFirstTabView")
    }
}

struct FirstView: View {
    
    let viewModel: ObservableObjectForFirstView
    
    var body: some View {
        Text("Body of First Tab")
        SubviewForFirstView(receivedClosure: viewModel.funcThatWillBePassedAsClosureToSubViewFirstView)
    }
}


struct SubviewForFirstView: View {
    let receivedClosure: (Int) -> ()
    var body: some View {
        Text("SubviewForFirstView")
    }
}

class ObservableObjectForSecondView: ObservableObject {
    init() {
        print("init ObservableObjectForSecondTabView")
    }
    
    var insideVariableThatMightBeUsedToCaptureSelf = 8
    func funcThatWillBePassedAsClosureToSubViewSecondView() {
       insideVariableThatMightBeUsedToCaptureSelf = 9
    }
    
    deinit {
        print("deinig on ObservableObjectForSecondTabView")
    }
}

struct SecondView: View {
    let viewModel: ObservableObjectForSecondView
    var body: some View {
        Text("Body of Second Tab")
        SubviewForSecondView(receivedClosure: viewModel.funcThatWillBePassedAsClosureToSubViewSecondView)
    }
}

struct SubviewForSecondView: View {
    let receivedClosure: () -> ()
    var body: some View {
        Text("SubviewForSecondView")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
