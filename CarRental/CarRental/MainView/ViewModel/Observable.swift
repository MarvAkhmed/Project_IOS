//
//  Observable.swift
//  CarRental
//
//  Created by marwa awwad mohamed awwad on 25/03/2024.
//

import Foundation

class Observable<T> {
    
    var value: T? {
        didSet {
            DispatchQueue.main.async{
                self.listener?(self.value)
            }
        }
    }
    
    init(_ value: T?) {
        self.value = value
    }
    
    private var listener: ((T?) -> Void)?
    func bind(_ listener: @escaping ((T?) -> Void)) {
         listener(value)
        self.listener = listener
    }
    
}
 
