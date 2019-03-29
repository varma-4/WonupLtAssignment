//
//  PostcardCollectionViewCell.swift
//  WonupltAssignment
//
//  Created by Mani on 28/03/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit

class PostcardCollectionViewCell: UICollectionViewCell {

    var delegate: PostCardViewNavigationDelegate?
    
    var containerView = UIView()
    var isFlipped = false

    var tapLabelText: UILabel = {
        let label = UILabel()
        label.text = "Tap the white button to flip back to front."
        label.font = UIFont.systemFont(ofSize: 20, weight: .ultraLight)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    var flippedLabel: UILabel = {
        let label = UILabel()
        label.text = "The card is flipped."
        label.font = UIFont.systemFont(ofSize: 20, weight: .black)
        label.textColor = .white
        return label
    }()

    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 10.0
        label.clipsToBounds = true
        label.backgroundColor = twilightColor
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
    
    lazy var postCardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10.0
        imageView.image = #imageLiteral(resourceName: "PostCardImage")
        imageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickedOnImageView))
        tapGesture.numberOfTapsRequired = 1
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    var flippedView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10.0
        view.backgroundColor = grayColor
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
    
}

// MARK: - Cell Configuration Methods
extension PostcardCollectionViewCell {

    private func setupViews() {
        clipsToBounds = false
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        containerView.addSubview(flippedView)
        containerView.addSubview(postCardImageView)
        // Setup Constraints
        postCardImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        flippedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupFlippedView()

        contentView.addSubview(nameLabel)
        addTapButton(to: contentView, withColor: .red)
        // Setup Constraints
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(snp.bottom)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(40)
            make.width.equalTo(110)
        }
        setupIntialCustomization()
    }

    private func setupIntialCustomization() {
        // Intial Customization
        tapButton.backgroundColor = .red
        flippedView.alpha = 0.0
        postCardImageView.alpha = 1.0
        isFlipped = false
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

        addTapButton(to: flippedView, withColor: .white)
        tapLabelText.sizeToFit()
        verticalStackView.addArrangedSubview(flippedLabel)
        verticalStackView.addArrangedSubview(tapLabelText)
    }

    func addTapButton(to view: UIView, withColor color: UIColor) {
        view.addSubview(tapButton)
        tapButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.right.bottom.equalToSuperview().inset(20)
        }
        tapButton.backgroundColor = color
    }

}

// MARK: - Action & Animation Methods
extension PostcardCollectionViewCell {

    @objc
    func clickedOnTapButton() {
        flipCardAnimation()
    }

    @objc
    func clickedOnImageView() {
        delegate?.navigate()
    }

    /// This method flips the card using UIView transitions, flip direction will be decided based on the current flipped State
    func flipCardAnimation() {
        let transitionOptions: UIView.AnimationOptions = !isFlipped ? .transitionFlipFromLeft : .transitionFlipFromRight

        if !isFlipped {
            postCardImageView.alpha = 0.0
            flippedView.alpha = 1.0
            tapButton.backgroundColor = .white
        } else {
            postCardImageView.alpha = 1.0
            flippedView.alpha = 0.0
            tapButton.backgroundColor = .red
        }

        UIView.transition(with: self.containerView, duration: 0.5, options: transitionOptions, animations: nil, completion: nil)
        isFlipped = isFlipped ? false : true
    }

}
