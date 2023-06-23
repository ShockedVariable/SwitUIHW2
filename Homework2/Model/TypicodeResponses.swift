//
//  TypicodeResponses.swift
//  Homework2
//
//  Created by Anthony Nuon-Prak on 6/22/23.
//

import Foundation

struct Typicode: Decodable, Identifiable {
    let user_id: Int
    let id: Int
    let title: String
    let body: String
}
