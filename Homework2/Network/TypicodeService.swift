//
//  TypicodeService.swift
//  Homework2
//
//  Created by Anthony Nuon-Prak on 6/22/23.
//

import Foundation
import Combine

class TypicodeService {
    var cancel_label = Set<AnyCancellable>()
    let url_string = "https://jsonplaceholder.typicode.com/posts"
    
    func fetchContacts() -> Future<[Typicode], Error> {
        return Future { [weak self] promise in
            guard let self = self else { return }
            guard let url = URL(string: url_string) else { return }
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map{$0.data}
                .decode(type: [Typicode].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { completion in
                    switch completion {
                        case .finished:
                            break
                        case .failure(let err):
                            promise(.failure(err))
                    }
                } receiveValue: { response in
                    promise(.success(response))
                }
                .store(in: &self.cancel_label)
        }
    }
}
