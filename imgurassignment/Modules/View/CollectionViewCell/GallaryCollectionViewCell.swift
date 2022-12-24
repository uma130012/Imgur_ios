//
//  GallaryCollectionViewCell.swift
//  imgurassignment
//
//  Created by Uma on 24/12/22.
//

import UIKit

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
        }else{
            imageCountLabel.text = ""
        }
        print("image count",data.images?.count)
        titleLabel.text = data.title
        print("time stamp",data.datetime)
        dateAndTimeLabel.text = data.datetime?.timeStampToTime()
    }
}


extension UICollectionViewCell{
    static var reuseID:String{
       return String(describing: self)
    }
}

extension Int{
    func timeStampToTime() -> String{
        let epocTime = TimeInterval(self)
        let myDate = Date(timeIntervalSince1970: epocTime)
        let dateFormatter = DateFormatter()
       // dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "dd/MM/YY hh:mm a"
        let localTime = dateFormatter.string(from: myDate)
        
        print(localTime)
        return localTime
    }
}
