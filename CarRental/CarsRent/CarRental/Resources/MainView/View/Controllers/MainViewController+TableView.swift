//
//  MainViewController+tableView.swift
//  CarRental
//
//  Created by marwa awwad mohamed awwad on 24/03/2024.
//

import UIKit

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
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section )
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainViewControllerCells else {
            fatalError("Failed to dequeue MainViewControllerCells.")
        }
        
        if viewModel.isSearching {
            guard let filteredDataSource = viewModel.filteredDataSource.value else {
                return cell
            }
            guard indexPath.row < filteredDataSource.count else {
                return cell
            }
            cell.configureCell(with: filteredDataSource[indexPath.row])
        } else {
            
            guard indexPath.row < cellDataSource.count else {
                return cell
            }
            cell.configureCell(with: cellDataSource[indexPath.row])
            return cell
        }
     return cell
    }
}
extension MainViewController: UISearchBarDelegate {
    
    func updateAfterSearch(with filteredCars: (), searchText: String) {
        viewModel.filterCars(searchText)
        DispatchQueue.main.async {
            self.viewModel.filterCars(searchText)
            self.tableView.reloadData()
        }
        viewModel.mapCellData()
      
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty{
                let filteredCars: () = viewModel.filterCars(searchText)
                updateAfterSearch(with: filteredCars, searchText: searchText)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }else if searchText.isEmpty {

            DispatchQueue.main.async {
                self.viewModel.fetchData()
                self.tableView.reloadData()
            }
        }
    }
}
