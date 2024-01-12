//
//  ProductScreenViewController.swift
//  mvvm_example
//
//  Created by Tanmay Chandra Nath on 12/01/24.
//

import UIKit

class ProductScreenViewController: UIViewController {
    
    var viewModel: ProductScreenViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProductScreenViewModel(apiHelper: ServiceManager())
    }
}
