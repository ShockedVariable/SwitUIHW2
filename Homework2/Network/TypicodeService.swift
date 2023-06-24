//
//  TypicodeService.swift
//  Homework2
//
//  Created by Anthony Nuon-Prak on 6/22/23.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidUrl
    case invalidResponse
    case emptyData
    case serviceUnavailable
    case decodingError
    
    var description: String {
        switch self {
            case .invalidUrl:
                return "invalid url"
            case .invalidResponse:
                return "invalid response"
            case .emptyData:
                return "empty data"
            case .serviceUnavailable:
                return "service unavailable"
            case .decodingError:
                return "decoding error"
        }
    }
}

class TypicodeService {
    var cancel_label = Set<AnyCancellable>()
    let url_string = "https://jsonplaceholder.typicode.com/posts"
    
    func fetchContactsUsingAsyncAwait() async throws -> [Typicode] {
        guard let url = URL(string: url_string) else { throw APIError.invalidUrl }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let resp = response as? HTTPURLResponse, resp.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        return try JSONDecoder().decode([Typicode].self, from: data)
    }
    
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
