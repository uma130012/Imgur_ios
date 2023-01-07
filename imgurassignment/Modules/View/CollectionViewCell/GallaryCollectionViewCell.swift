//
//  GallaryCollectionViewCell.swift
//  imgurassignment
//
//  Created by Uma on 24/12/22.
//

import UIKit
import AVKit
import Kingfisher

class GallaryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateAndTimeLabel: UILabel!
    @IBOutlet weak var contentImageView: AnimatedImageView!
    @IBOutlet weak var imageCountLabel: UILabel!
    @IBOutlet weak var playBtn: UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //    MARK:- Configure cell data
    
    var gallaryData:GallaryData?{
        didSet{
            if gallaryData?.is_album == true{
                imageCountLabel.text = gallaryData?.images?.count.description
                if let album = gallaryData?.images?.first, let type = album.type,let link = album.link{
                    mediaSetup(type: type, link:link)
                }
            }else{
                imageCountLabel.text = ""
                if let type = gallaryData?.type,let link = gallaryData?.link{
                    mediaSetup(type: type, link: link)
                }
            }
            titleLabel.text = gallaryData?.title
            dateAndTimeLabel.text = gallaryData?.datetime?.timeStampToTime()
        }
    }
    
    //    MARK:- Download IMAGE || GIF
    
    private func downloadImageAndGif(_ url : String){
        playBtn.isHidden = true
        contentImageView.kf.indicatorType = .activity
        if let imageUrl = URL(string: url){
            contentImageView.kf.setImage(with:imageUrl ,options: [.processor(DefaultImageProcessor.default)])
        }
    }
   
    //    MARK:- Download video thumbnail
    
    private func downloadVideoThumbnail(_ url:String){
        contentImageView.kf.indicatorType = .activity
        if let videoUrl = URL(string: url){
            let provider = AVAssetImageDataProvider(assetURL: videoUrl, seconds: 15.0 )
            contentImageView.kf.setImage(with:provider)
            playBtn.isHidden = false
        }
    }
    
    //    MARK:- Setup media type data like image/video/gif
    
    private func mediaSetup(type:String,link:String){
        if type == "video/mp4"{
            downloadVideoThumbnail(link)
        }else{
            downloadImageAndGif(link)
        }
    }
}


