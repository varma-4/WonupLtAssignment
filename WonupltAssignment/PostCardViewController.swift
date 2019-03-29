//
//  ViewController.swift
//  WonupltAssignment
//
//  Created by Mani on 28/03/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit
import SnapKit

protocol PostCardViewNavigationDelegate {
    func navigate()
}

class PostCardViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private let cellIdentifier = "PostCardCell"
    
    var customBarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Welcome!", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }
    
    // Setup Title for Navigation Bar
    private func setupNavBar() {
        edgesForExtendedLayout = []
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let rightBarButton = UIBarButtonItem(customView: customBarButton)
        navigationItem.rightBarButtonItems = [rightBarButton]
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(25)
        }
        collectionView.backgroundColor = .white
        collectionView.register(PostcardCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = false
    }


}

extension PostCardViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PostcardCollectionViewCell
        collectionCell?.delegate = self
        collectionCell?.backgroundColor = .clear
        collectionCell?.awakeFromNib()
        return collectionCell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 20
        let height = CGFloat(355)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }

}

extension PostCardViewController: PostCardViewNavigationDelegate {

    /// Navigate ViewControllet to Details ViewController
    func navigate() {
        let detailsViewController = DetailViewController()
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

