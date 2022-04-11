//
//  LandmarkCell.swift
//  MVP+UIKit
//
//  Created by tomoyo_kageyama on 2022/04/06.
//

import UIKit

final class LandmarkCell: UITableViewCell {
    private let landmarkImage: UIImage
    private let landmarkName: String
    private let starImageView: UIImageView
    private let starImageWidth = CGFloat(20)
    private let starImageHeight = CGFloat(20)
    
    init(landmark: Landmark){
        landmarkImage = landmark.image
        landmarkName = landmark.name
        
        let starImage = UIImage(systemName: "star.fill")
        starImageView = UIImageView(image: starImage)
        starImageView.tintColor = .yellow
        starImageView.isHidden = !landmark.isFavorite
        
        super.init(style: .default, reuseIdentifier: nil)
        addSubview(starImageView)
        accessoryType = .none
        selectionStyle = .default
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        imageView?.image = landmarkImage
        accessoryType = .none
        textLabel?.text = landmarkName
        starImageView.frame = CGRect(x: frame.width - starImageWidth - 10,
                                     y: frame.height / 2 - starImageHeight / 2,
                                     width: starImageWidth,
                                     height: starImageHeight)
        super.layoutSubviews()
    }
}
