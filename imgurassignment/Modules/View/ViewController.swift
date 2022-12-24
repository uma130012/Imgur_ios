//
//  ViewController.swift
//  imgurassignment
//
//  Created by Uma on 24/12/22.
//

import UIKit

class ViewController: UIViewController {
//    MARK:- Outlets
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var viewModel: GallaryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel = GallaryViewModel(parentVC: self)
        self.collectionView.delegate = viewModel
        self.collectionView.dataSource = viewModel
        self.searchBar.delegate = viewModel
    }
    
//    MARK:- Interface Builder
    
    @IBAction func toggleBtnTapped(_ sender: Any) {
        if let toggle = viewModel?.changeToogle{
            viewModel?.changeToogle = !toggle
        }
    }
    
}

