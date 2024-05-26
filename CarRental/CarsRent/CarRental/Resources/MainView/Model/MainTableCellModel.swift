//
//  MainTableCellViewModel.swift
//  CarRental
//
//  Created by marwa awwad mohamed awwad on 25/03/2024.
//

import Foundation

class MainTableCellViewModel {
    var avatar: String
    var color: Color
    var id: String
    var like: Bool
    var model: Model
    var price, rating: String
    
    init(car: Car) {
        self.avatar = car.avatar
        self.color = car.color
        self.id = car.id
        self.like = car.like
        self.model = car.model
        self.price = car.price
        self.rating = car.rating
    }
}
