//
//  NetworkConstants.swift
//  CarRental
//
//  Created by marwa awwad mohamed awwad on 24/03/2024.
//

import Foundation

class NetworkConstants {
    public static var shared: NetworkConstants = NetworkConstants()
    private init() {
    }
    public var carsSourceLink: String {
        get {
            return "https://mamaeifnod.pythonanywhere.com/"
        }
    }

}
