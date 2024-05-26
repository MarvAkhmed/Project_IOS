//
//  MainViewModel.swift
//  CarRental
//
//  Created by marwa awwad mohamed awwad on 24/03/2024.
//

import UIKit
import Combine

class MainViewModel: ObservableObject {
    
    @Published var dataSource: [Car] = []
    @Published var filteredCars: [Car] = []
    
    private let carsAPIService: CarsAPIService
    private var cancellables = Set<AnyCancellable>()
    
    init(carsAPIService: CarsAPIService = CarsAPIService()) {
        self.carsAPIService = carsAPIService
    }
    
    func fetchData() {
        carsAPIService.getCars()
            .sink { completion in
                switch completion{
                case .finished:
                    print("success")
                case .failure(let error):
                    print("\(error.localizedDescription)")
                }
            } receiveValue: { [weak self] dataSource in
                self?.dataSource = dataSource
                self?.filteredCars = dataSource
            }
            .store(in: &cancellables)
    }
}

extension MainViewModel {
    func filterCars(with searchText: String) {
        if searchText.isEmpty {
            filteredCars = dataSource
        } else {
            filteredCars = dataSource.filter { $0.model.rawValue.localizedCaseInsensitiveContains(searchText) }
        }
    }
}










