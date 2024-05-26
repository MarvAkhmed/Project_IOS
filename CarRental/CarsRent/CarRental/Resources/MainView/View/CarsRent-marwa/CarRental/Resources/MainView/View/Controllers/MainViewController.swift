//
//  ViewController.swift
//  CarRental
//
//  Created by marwa awwad mohamed awwad on 24/03/2024.
//

import UIKit
import Combine
import SwiftUI

class MainViewController: UIViewController {
    
    var cellDataSource: [MainTableCellModel] = []
    
    //MARK: - UI Elements
    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "slider.horizontal.3")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
        button.imageView?.tintColor = .black
        return button
    }()
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.delegate = self
        bar.placeholder = "Search"
        bar.tintColor = .black
        return bar
    }()
    lazy var tableView: UITableView = {
        let table = UITableView()
          table.rowHeight = 220
          table.dataSource = self
          table.delegate = self
          table.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
          table.layer.borderColor = CGColor(genericCMYKCyan: 2, magenta: 2, yellow: 2, black: 2, alpha: 2)
          table.backgroundColor = .clear
          return table
    }()
    
    //MARK: - View model refrence
    
        @ObservedObject var viewModel = MainViewModel()
        @State private var searchText: String = ""
        private var cancellables = Set<AnyCancellable>()


    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layouts()
        bindViewModel()
        viewModel.fetchData()
    }
    
    func bindViewModel() {
        viewModel.$dataSource
            .sink { [weak self] cars in
                self?.cellDataSource = cars
                    .map{MainTableCellModel (car: $0)
                    }
                self?.reloadTableView()
            }
            .store(in: &cancellables)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
