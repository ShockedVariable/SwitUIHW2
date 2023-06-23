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
                Text("Typicode Responses")
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
                ZStack {
                    LinearGradient(colors: [.yellow, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                    VStack {
                        Text("Words of Encouragment")
                            .font(.system(.title3).bold())
                        ZStack {
                            RoundedRectangle(cornerRadius: 17)
                                .foregroundColor(.gray.opacity(0.35))
                                .frame(width: .infinity, height: 150)
                            Text(t.body)
                                .multilineTextAlignment(.center)
                                .italic()
                            
                        }
                        
                    }
                    .padding()
                }
            } label: {
                HStack {
                    Text("\(t.id).")
                        .fontWeight(.medium)
                    
                    Text(t.title)
                        
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
