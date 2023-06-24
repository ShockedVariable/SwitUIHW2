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
                usersView()
            }
            .navigationTitle("User Responses")
            .onAppear {
//                view_model.getTypicode()
                view_model.getTypicodeUsingAsyncAwait()
                view_model.addPost()
            }
        }
    }
    
    private func usersView() -> some View {
        ForEach(Array(view_model.users.keys).sorted(), id: \.self) { t in
            NavigationLink {
                if let test = view_model.users[t] {
                    postsView(test)
                        .navigationTitle("User \(t)")
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color(hue: 0.619, saturation: 0.982, brightness: 0.98, opacity: 0.15))
                        .frame(width: 125)
                    Text("User \(t)")
                }
            }
        }
    }
    
    private func postsView(_ arr: [Typicode]) -> some View {
        List(arr) { t in
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
                                .padding()
                                .italic()
                        }
                    }
                    .padding()
                }
            } label: {
                HStack {
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
