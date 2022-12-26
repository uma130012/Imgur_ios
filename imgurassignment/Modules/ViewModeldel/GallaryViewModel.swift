//
//  GallaryViewModel.swift
//  imgurassignment
//
//  Created by Uma on 24/12/22.
//

import UIKit

class GallaryViewModel: NSObject {
    
    //    MARK:- Properties
    
    var parentVC:ViewController?
    var gallaryData:[GallaryData] = []
    
    var changeToogle:Bool = false{
        didSet{
            parentVC?.toggleBtn.setTitle(changeToogle == true ? "Grid" : "List", for: .normal)
            reloadCollectionView()
        }
    }
    
    
    //    MARK:- Initialization
    
    init(parentVC: ViewController? = nil) {
        super.init()
        self.parentVC = parentVC
        
        self.parentVC?.searchBar.searchTextField.clearButtonMode = .never
        
        registerCollectionViewCell()

        self.gallaryAPI()
    }
    
    
    // MARK:- Register Collectionview Cell
    
    private func registerCollectionViewCell(){
        parentVC?.collectionView.register(UINib(nibName: GallaryCollectionViewCell.reuseID, bundle: nil), forCellWithReuseIdentifier: GallaryCollectionViewCell.reuseID)
    }
    
    // MARK:- fetch data from imgur for gallary by optional search query
    
    func gallaryAPI(query:String = ""){
        let url = query == "" ? API.gallary + "top/week/0" : API.gallary + "search/top/week/0?q=\(query)"
        parentVC?.collectionView.setEmptyView(title: "Data Fetching...", message: "Please wait for a while")
        NetworkManager.hitApi(url: url,httpMethodType: .get) { [weak self] (response : GallaryModel) in
            guard let weakSelf = self else { return }
            if let data = response.gallaryData{
                weakSelf.gallaryData = data
                weakSelf.reloadCollectionView()
            }
            if weakSelf.gallaryData.isEmpty{
                weakSelf.parentVC?.collectionView.setEmptyView(title: "No Data found", message: "Please search somthing else")
            }else{
                weakSelf.parentVC?.collectionView.restore()
            }
        } failure: { error in
            self.parentVC?.collectionView.setEmptyView(title: "Whooops", message: (error as AnyObject).localizedDescription ?? "Somthing went wrong")
            print(error)
        }
    }
    
    
    func reloadCollectionView(){
        DispatchQueue.main.async { [self] in
            parentVC?.collectionView.reloadData()
        }
    }
    
}

//MARK:- UICollectionViewDataSource

extension GallaryViewModel:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallaryData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GallaryCollectionViewCell.reuseID, for: indexPath) as! GallaryCollectionViewCell
        cell.configureCellData(data: gallaryData[indexPath.row])
        return cell
    }

}


//MARK:- UICollectionViewDelegate

extension GallaryViewModel:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

//MARK:- UICollectionViewDelegateFlowLayout

extension GallaryViewModel:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width:CGFloat = .zero
        if changeToogle == false{
            width = ((self.parentVC?.collectionView.frame.size.width ?? UIScreen.main.bounds.width) - 3) / 3.0
        }else{
            width = self.parentVC?.collectionView.frame.size.width ?? UIScreen.main.bounds.width
        }
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.5, left: 0, bottom: 1.5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension GallaryViewModel:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        parentVC?.searchBar.showsCancelButton = searchText != ""
        if (searchText == ""){
            gallaryAPI()
        }
    }
  
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.searchTextField.text = ""
        parentVC?.searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        gallaryAPI()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text,!text.isEmpty && text.count > 0{
            gallaryAPI(query: text)
        }
    }

}
