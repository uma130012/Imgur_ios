//
//  GallaryViewModel.swift
//  imgurassignment
//
//  Created by Uma on 24/12/22.
//

import UIKit

class GallaryViewModel: NSObject {

    var parentVC:ViewController?
    var gallaryData:[GallaryData] = []
    
    
    init(parentVC: ViewController? = nil) {
        super.init()
        self.parentVC = parentVC
        registerCollectionViewCell()
        self.gallaryAPI(query: "cats")
    }
    

// MARK:- Register Collectionview Cell
    
    private func registerCollectionViewCell(){
        parentVC?.collectionView.register(UINib(nibName: GallaryCollectionViewCell.reuseID, bundle: nil), forCellWithReuseIdentifier: GallaryCollectionViewCell.reuseID)
    }
    
// MARK:- fetch data from imgur for gallary by optional search query
    
    func gallaryAPI(query:String = ""){
        let url = query == "" ? API.gallary : API.gallary + "?q=\(query)"
        NetworkManager.hitApi(url: url,httpMethodType: .get) { [weak self] (response : GallaryModel) in
            guard let weakSelf = self else { return }
            print("response",response)
            if let data = response.gallaryData{
                weakSelf.gallaryData = data
                weakSelf.reloadCollectionView()
            }
        } failure: { error in
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
        let width = ((self.parentVC?.collectionView.frame.size.width ?? UIScreen.main.bounds.width) - 3) / 3.0
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
