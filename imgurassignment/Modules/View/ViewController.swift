//
//  ViewController.swift
//  imgurassignment
//
//  Created by Uma on 24/12/22.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
//    MARK:- Outlets
    @IBOutlet weak var toggleBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    let cache = ImageCache.default
    
    var viewModel: GallaryViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel = GallaryViewModel(parentVC: self)
        self.collectionView.delegate = viewModel
        self.collectionView.dataSource = viewModel
        self.searchBar.delegate = viewModel
        
        // Check memory clean up every 30 seconds.
        cache.memoryStorage.config.cleanInterval = 30
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
//    MARK:- Interface Builder
    
    @IBAction func toggleBtnTapped(_ sender: Any) {
        if let toggle = viewModel?.changeToogle{
            viewModel?.changeToogle = !toggle
        }
    }
    
}

