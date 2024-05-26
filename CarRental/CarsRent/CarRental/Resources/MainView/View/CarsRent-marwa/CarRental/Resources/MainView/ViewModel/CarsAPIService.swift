//
//  CarsAPIService.swift
//  CarRental
//
//  Created by marwa awwad mohamed awwad on 26/05/2024.
//

import Combine
import Foundation

protocol APIService {
    func getCars() -> AnyPublisher<[Car], Error>
}
class CarsAPIService: APIService {
    private let urlString = URL(string: "https://mamaeifnod.pythonanywhere.com/")!
    
    func getCars() -> AnyPublisher<[Car], any Error> {
        URLSession.shared.dataTaskPublisher(for: urlString)
            .map{ $0.data }
            .decode(type: [Car].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
