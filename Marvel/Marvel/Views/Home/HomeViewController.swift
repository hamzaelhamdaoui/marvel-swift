//
//  HomeViewController.swift
//  Marvel
//
//  Created by AvantgardeIT on 18/4/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    var viewModel = HomeViewModel()

    override func viewDidLoad() {
        viewModel.fetchCharacters(start: 1, limit: 25)
    }
}
