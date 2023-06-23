//
//  ContentView.swift
//  Homework2
//
//  Created by Anthony Nuon-Prak on 6/22/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var view_model = TypicodeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Test")
                    .font(.system(.largeTitle).bold())
                typicodeView()
            }
            .onAppear {
                view_model.getTypicode()
            }
        }
    }
    
    private func typicodeView() -> some View {
        List(view_model.typicodes) { t in
            NavigationLink {
                Text(t.body)
            } label: {
                Text(t.title)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
