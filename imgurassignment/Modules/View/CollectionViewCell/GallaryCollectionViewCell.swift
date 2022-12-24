//
//  GallaryCollectionViewCell.swift
//  imgurassignment
//
//  Created by Uma on 24/12/22.
//

import UIKit
import SDWebImage


class GallaryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var imageCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    func configureCellData(data:GallaryData){
        if data.is_album == true{
            imageCountLabel.text = data.images?.count.description
            if let album = data.images?.first{
                downloadImage(album.link)
            }
        }else{
            imageCountLabel.text = ""
            downloadImage(data.link)
        }
        titleLabel.text = data.title
        dateAndTimeLabel.text = data.datetime?.timeStampToTime()
    }
    
    func downloadImage(_ imageUrl : String?){
        if let image = imageUrl {
            self.contentImageView.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            self.contentImageView.sd_setImage(with:URL(string: image))
        }
    }
}


