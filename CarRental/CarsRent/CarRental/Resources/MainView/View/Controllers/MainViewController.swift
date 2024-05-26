//
//  ViewController.swift
//  CarRental
//
//  Created by marwa awwad mohamed awwad on 24/03/2024.
//

import UIKit
import JGProgressHUD

class MainViewController: UIViewController {
    
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
          table.register(MainViewControllerCells.self, forCellReuseIdentifier: "cell")
          table.layer.borderColor = CGColor(genericCMYKCyan: 2, magenta: 2, yellow: 2, black: 2, alpha: 2)
          table.backgroundColor = .clear
          return table
    }()
    
    //MARK: - View model refrence
    var viewModel: MainViewModel = MainViewModel()
    //MARK: - Variables
    var cellDataSource: [MainTableCellViewModel] = []

    
    //MARK: - Display view
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layouts()
        bindViewModel()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.fetchData()
    }
    
    //MARK: - HELPERS
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let isLoading = isLoading else { return }
            
            DispatchQueue.main.async {
                if isLoading {
                    self?.showIndicator()
                } else {
                    return
                }
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] cars in
            guard let self = self,
                  let cars = cars else {
                return
            }
            self.cellDataSource = cars
            self.reloadTableView()
            
        }
    }
    
    func observeFilteredDataSource() {
        viewModel.filteredDataSource.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    

    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    //MARK: -  loading Ui animation
    func showIndicator() {
        DispatchQueue.main.async {
            self.viewModel.isLoading.bind { [weak self] isLoading in
                guard let self = self, let isLoading = isLoading else {
                    return
                }
                if isLoading {
                    let hud = JGProgressHUD()
                    hud.indicatorView = JGProgressHUDPieIndicatorView()
                    hud.textLabel.text = "fetching data"
                    hud.detailTextLabel.text = "0%"
                    hud.show(in: self.view)
                    
                    var progress: Float = 0.0
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        progress += 1
                        hud.setProgress(progress, animated: true)
                        let value: Float = progress / 1.0
                        hud.detailTextLabel.text = "\(Int(value*100)) %"
                        if progress > 1.0 {
                            timer.invalidate()
                            
                            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                            hud.detailTextLabel.text = "Done"
                            hud.dismiss(afterDelay: 2 )
                        }
                    }
                }else {
                    let hud = JGProgressHUD()
                    hud.indicatorView = JGProgressHUDErrorIndicatorView()
                    hud.detailTextLabel.text = "check your internet connection"
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                        hud.setProgress(2, animated: true)
                        timer.invalidate()
                    }
                }
            }
        }
    }
}
