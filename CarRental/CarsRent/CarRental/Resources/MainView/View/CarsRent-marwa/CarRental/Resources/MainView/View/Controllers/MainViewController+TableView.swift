//
//  MainViewController+tableView.swift
//  CarRental
//
//  Created by marwa awwad mohamed awwad on 24/03/2024.
//

import UIKit
import SwiftUI

extension MainViewController {
    
    func layouts() {
        view.addSubview(tableView)
        view.addSubview(filterButton)
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.bottom.equalTo(tableView.snp.top).offset(0)
            make.left.equalToSuperview().inset(5)
            make.right.equalToSuperview().inset(40)
            make.height.equalTo(40)
        }
        
        filterButton.snp.makeConstraints { make in
            make.bottom.equalTo(tableView.snp.top).offset(-5)
            make.right.equalToSuperview().inset(4)
            make.left.equalTo(searchBar.snp.right).inset(-5)
            make.height.equalTo(30)
            make.width.equalTo(50)
            
        }
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 190, left: 5, bottom: 10, right: 5 ))
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else {
            fatalError("Failed to dequeue MainViewControllerCells.")
        }
        
        let cellModel = cellDataSource[indexPath.row]
        cell.configureCell(with: cellModel)
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCar = viewModel.filteredCars[indexPath.row]
        let detailViewModel = DetailViewModel(car: selectedCar)
        let detailView = DetailView(viewModel: detailViewModel)
        let controller = UIHostingController(rootView: detailView)
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
}


extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCars(with: searchText)
    }
}
