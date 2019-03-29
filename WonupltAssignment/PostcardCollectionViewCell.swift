//
//  PostcardCollectionViewCell.swift
//  WonupltAssignment
//
//  Created by Mani on 28/03/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit

class PostcardCollectionViewCell: UICollectionViewCell {
    
    var containerView = UIView()
    var isFlipped = false
    var cardViews : (frontView: UIImageView, backView: UIView)?
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 10.0
        label.clipsToBounds = true
        label.backgroundColor = UIColor(red: 86.0 / 255.0, green: 90.0 / 255.0, blue: 163.0 / 255.0, alpha: 1.0)
        return label
    }()
    
    lazy var tapButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(clickedOnTapButton), for: .touchUpInside)
        return button
    }()
    
    @objc
    func clickedOnTapButton() {
        flipCardAnimation()
    }
    
    var frontImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10.0
        imageView.image = #imageLiteral(resourceName: "PostCardImage")
        return imageView
    }()
    
    var flippedView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10.0
        view.backgroundColor = UIColor.init(red: 74/255, green: 74/255, blue: 74/255, alpha: 1)
        return view
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
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.addSubview(flippedView)
        containerView.addSubview(frontImageView)

        frontImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        flippedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupFlippedView()
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.bottom)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.width.equalTo(110)
        }
        clipsToBounds = false
        
        contentView.addSubview(tapButton)
        tapButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.right.bottom.equalToSuperview().inset(20)
        }
        tapButton.backgroundColor = .red
        flippedView.alpha = 0.0
        frontImageView.alpha = 1.0
        isFlipped = false
    }
    
    private func setRoundedRect() {
        layer.cornerRadius = 10.0
        clipsToBounds = true
    }
    
    private func setupFlippedView() {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 10
        flippedView.addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.centerY)
            make.left.right.equalToSuperview().inset(20)
            make.height.greaterThanOrEqualTo(58)
        }
        let flippedLabel = UILabel()
        flippedLabel.text = "The card is flipped."
        flippedLabel.font = UIFont.systemFont(ofSize: 20, weight: .black)
        flippedLabel.textColor = .white

        let tapLabelText = UILabel()
        tapLabelText.text = "Tap the white button to flip back to front."
        tapLabelText.font = UIFont.systemFont(ofSize: 20, weight: .ultraLight)
        tapLabelText.textColor = .white
        tapLabelText.numberOfLines = 0

        flippedView.addSubview(tapButton)
        tapButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.right.bottom.equalToSuperview().inset(20)
        }
        tapButton.backgroundColor = .white
        tapLabelText.sizeToFit()
        verticalStackView.addArrangedSubview(flippedLabel)
        verticalStackView.addArrangedSubview(tapLabelText)
    }
    
    func flipCardAnimation() {
        let transitionOptions: UIView.AnimationOptions = !isFlipped ? .transitionFlipFromLeft : .transitionFlipFromRight
        
        if !isFlipped {
            frontImageView.alpha = 0.0
            flippedView.alpha = 1.0
            tapButton.backgroundColor = .white
        } else {
            frontImageView.alpha = 1.0
            flippedView.alpha = 0.0
            tapButton.backgroundColor = .red
        }
        
        UIView.transition(with: self.containerView, duration: 0.5, options: transitionOptions, animations: nil, completion: { _ in
            
        })
        isFlipped = isFlipped ? false : true
    }
    
}
