//
//  TypicodeViewModel.swift
//  Homework2
//
//  Created by Anthony Nuon-Prak on 6/22/23.
//

import Foundation
import Combine

class TypicodeViewModel: ObservableObject {
    @Published var typicodes = [Typicode]()
    var cancel_label = Set<AnyCancellable>()
    let service = TypicodeService()
    
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
                self?.typicodes = typicode
            }
            .store(in: &cancel_label)
    }
}
