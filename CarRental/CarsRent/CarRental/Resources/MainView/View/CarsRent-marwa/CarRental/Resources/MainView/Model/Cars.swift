//
//  Cars.swift
//  CarRental
//
//  Created by marwa awwad mohamed awwad on 24/03/2024.
//

import Foundation

// MARK: - CarElement
struct Car: Codable {
    let avatar: String
    let color: Color
    let id: String
    let like: Bool
    let model: Model
    let price, rating: String
}

enum Color: String, Codable {
    case black = "black"
    case blue = "blue"
    case green = "green"
    case red = "red"
    case white = "white"
    case yellow = "yellow"
}

enum Model: String, Codable {
    case audiA4 = "Audi A4"
    case bentleyContinentalGT = "Bentley Continental GT"
    case cadillacEscalade = "Cadillac Escalade"
    case chrysler300 = "Chrysler 300"
    case ferrari488GTB = "Ferrari 488 GTB"
    case fordMustang = "Ford Mustang"
    case gmcSierra = "GMC Sierra"
    case hondaAccord = "Honda Accord"
    case hyundaiSonata = "Hyundai Sonata"
    case infinitiQ50 = "Infiniti Q50"
    case jaguarFType = "Jaguar F-Type"
    case jeepWrangler = "Jeep Wrangler"
    case kiaSportage = "Kia Sportage"
    case lamborghiniAventador = "Lamborghini Aventador"
    case landRoverRangeRover = "Land Rover Range Rover"
    case lexusRX = "Lexus RX"
    case lincolnNavigator = "Lincoln Navigator"
    case maseratiGhibli = "Maserati Ghibli"
    case mazdaCX5 = "Mazda CX-5"
    case mercedesBenzCClass = "Mercedes-Benz C-Class"
    case nissanAltima = "Nissan Altima"
    case porsche911 = "Porsche 911"
    case rollsRoycePhantom = "Rolls-Royce Phantom"
    case subaruOutback = "Subaru Outback"
    case teslaModel3 = "Tesla Model 3"
    case toyotaCamry = "Toyota Camry"
    case volkswagenGolf = "Volkswagen Golf"
    case volvoXC60 = "Volvo XC60"
}

typealias Cars = [Car]
