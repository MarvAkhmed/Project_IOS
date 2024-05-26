//
//  MainViewModel.swift
//  CarRental
//
//  Created by marwa awwad mohamed awwad on 24/03/2024.
//

import UIKit

class MainViewModel {
    
    var isLoading : Observable<Bool> = Observable(false)
    var dataSource: Cars?
    var cellDataSource: Observable<[MainTableCellViewModel]> = Observable([])
    var filteredDataSource: Observable<[MainTableCellViewModel]> = Observable([])
    var isSearching: Bool = false
    var searchText: String = ""
    
    //retain the data back to the view controller
    func numberOfSections() -> Int {
        if isSearching {
            return filteredDataSource.value?.count ?? 0
        }else {
            return dataSource?.count ?? 0
        }
    }
    func numberOfRows(in section: Int) -> Int {
        if isSearching {
            return filteredDataSource.value?.count ?? 0
        }else {
            return cellDataSource.value?.count ?? 0
        }
    }
    
    func fetchData() {
        if isLoading.value ?? true{
            return
        }
        isLoading.value = true
        APICaller.getCars { [weak self] result in
            self?.isLoading.value = false
            switch result {
            case .success(let data):
                print(data.count)
                self?.dataSource = data
                self?.mapCellData()
            case .failure(let error):
                print("Error\(error.localizedDescription)")
            }
        }
    }
    
    func mapCellData() {
        self.cellDataSource.value = self.dataSource?.compactMap({MainTableCellViewModel(car: $0)})
    }
    func filterCars(_ searchText: String) {
        if !searchText.isEmpty {
            
            dataSource = dataSource?.filter({ car in
                car.model.rawValue.lowercased().contains(searchText.lowercased())
            })
        }
        print("datasource: \(dataSource?.count)")
    }
}
