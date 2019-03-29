//
//  DetailCollectionViewCell.swift
//  WonupltAssignment
//
//  Created by Mani on 29/03/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {

    
    var detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "detailVIewImage")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    override func awakeFromNib() {
        setupViews()
    }

    private func setupViews() {
        setRoundedRect()
        contentView.addSubview(detailImageView)
        detailImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setRoundedRect() {
        layer.cornerRadius = 10.0
        clipsToBounds = true
    }
    

}
