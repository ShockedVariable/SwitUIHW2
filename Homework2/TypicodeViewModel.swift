//
//  TypicodeViewModel.swift
//  Homework2
//
//  Created by Anthony Nuon-Prak on 6/22/23.
//

import Foundation
import Combine

class TypicodeViewModel: ObservableObject {
    @Published var users = [Int: [Typicode]]()
    var cancel_label = Set<AnyCancellable>()
    let service = TypicodeService()
    
    private func parsePosts(_ typicode: [Typicode]) {
        for i in typicode {
            if let _ = self.users[i.userId] {
                self.users[i.userId]?.append(i)
            }
            else {
                self.users[i.userId] = [i]
            }
        }
    }
    
    @MainActor func getTypicodeUsingAsyncAwait() {
        Task {
            do {
                let posts: [Typicode] = try await service.fetchContactsUsingAsyncAwait()
                self.parsePosts(posts)
            }
            catch {
                if let error = error as? APIError {
                    print(error.description)
                }
                else {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getTypicode() {
        self.service.fetchContacts()
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let err):
                        print(err.localizedDescription)
                }
            } receiveValue: { [weak self] typicode in
                for i in typicode {
                    if let _ = self?.users[i.userId] {
                        self?.users[i.userId]?.append(i)
                    }
                    else {
                        self?.users[i.userId] = [i]
                    }
                }
            }
            .store(in: &cancel_label)
    }
}
