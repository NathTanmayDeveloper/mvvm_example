//
//  ProductScreenViewController.swift
//  mvvm_example
//
//  Created by Tanmay Chandra Nath on 12/01/24.
//

import UIKit

class ProductScreenViewController: UIViewController {
    
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var refreshButton: UIButton!
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel: ProductScreenViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProductScreenViewModel(apiHelper: ServiceManager(), handler: eventHandler)
        tableView.dataSource = self
        fetchData()
        registerCells()
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        fetchData()
    }
    
    
    private func fetchData() {
        viewModel.getProducts()
    }
    
    private func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    // MARK: For Databinding
    func eventHandler(event: ApiCallEvents) {
        switch event {
            
        case .apiCallFinished:
            hideLoader()
        case .apiCallStarted:
            showLoader()
        case .gotError(let error):
            print(error)
            // Code to show custom error alert dialog
        case .showData:
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ProductScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = viewModel.products[indexPath.row].title
        return cell
    }
}

extension ProductScreenViewController {
    func showLoader() {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = false
            self.activityIndicatorView.startAnimating()
        }
        
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
        }
    }
}
