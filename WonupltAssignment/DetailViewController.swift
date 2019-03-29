//
//  DetailViewController.swift
//  WonupltAssignment
//
//  Created by Mani on 29/03/19.
//  Copyright © 2019 Mani. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    private let cellIdentifier = "DetailCell"
    private var selectedIndexPath: (IndexPath?, Bool?)
    lazy var blackAndWhiteImage: UIImage? = {
        return #imageLiteral(resourceName: "detailVIewImage.png").noir
    }()
    var selectAll = false

    var selectedCardInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 86/255, green: 90/255, blue: 163/255, alpha: 1)
        return view
    }()

    var selectedInfoTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()

    lazy var selectAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select All", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.init(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        button.layer.cornerRadius = 18.0
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .light)
        button.addTarget(self, action: #selector(selectAllPressed), for: .touchUpInside)
        return button
    }()

    var customBarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pick a card", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "closeButton.pdf"), for: .normal)
        button.addTarget(self, action: #selector(closButtonAction), for: .touchUpInside)
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
        self.view.backgroundColor = .white
        setupCollectionView()
        setupSelectedCardInfo()
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
        let leftBarButton = UIBarButtonItem(customView: closeButton)
        navigationItem.leftBarButtonItems = [leftBarButton]
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 80/255, green: 90/255, blue: 163/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "Detailed View"

        // Initial setup for button for Large NavBar state since the the screen always has Large NavBar once it gets opened
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.addSubview(selectAllButton)
        selectAllButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(36)
            make.width.equalTo(90)
        }
    }

    private func setupCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        collectionView.backgroundColor = .white
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
    }

    @objc
    func closButtonAction() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    func selectAllPressed() {
        selectAll = true
        selectedIndexPath = (nil, nil)
        DispatchQueue.main.async {
            self.configureSelectedCardInfo()
            self.collectionView.reloadData()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        selectAllButton.removeFromSuperview()
    }

    private func setupSelectedCardInfo() {
        self.view.addSubview(selectedCardInfoView)
        selectedCardInfoView.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.bottom.left.right.equalToSuperview()
        }
        selectedCardInfoView.addSubview(selectedInfoTextLabel)
        selectedInfoTextLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
            make.width.greaterThanOrEqualTo(120)
        }
        configureSelectedCardInfo()
    }

    private func configureSelectedCardInfo() {
        if selectAll {
            selectedInfoTextLabel.text = "All cards selected"
        } else if selectedIndexPath.0 == nil {
            selectedInfoTextLabel.text = "No card selected"
        } else {
            guard let indexPath = selectedIndexPath.0 else { return }
            selectedInfoTextLabel.text = "Card number \(indexPath.row + 1) selected"
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Get current height of navigation bar when tableview/collectionview/scrollview did scroll
        guard let navBarHeight = navigationController?.navigationBar.frame.height else {
            return
        }

        //Compare with standard height of navigation bar.
        if navBarHeight > 44.0 {
            guard let navigationBar = self.navigationController?.navigationBar else { return }
            navigationBar.addSubview(selectAllButton)
            selectAllButton.snp.makeConstraints { make in
                make.right.equalToSuperview().inset(15)
                make.bottom.equalToSuperview().inset(12)
                make.height.equalTo(36)
                make.width.equalTo(90)
            }
        } else {
            selectAllButton.removeFromSuperview()
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? DetailCollectionViewCell
        var image: UIImage?
        if selectAll {
            image = blackAndWhiteImage
        } else if selectedIndexPath.0 == indexPath && selectedIndexPath.1 == true {
            image = blackAndWhiteImage
        } else {
            image = #imageLiteral(resourceName: "detailVIewImage")
        }
        DispatchQueue.main.async {
            cell?.detailImageView.image = image
        }
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 20
        let height = CGFloat(100)
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? DetailCollectionViewCell else { return }
        cell.makeImageBlackAndWhite()
        if selectedIndexPath.0 == nil {
            selectedIndexPath = (indexPath, true)
        } else {
            // remove filter
            selectedIndexPath = (selectedIndexPath.0, false)
            guard let indexPathPrevious = selectedIndexPath.0 else { return }
            DispatchQueue.main.async {
                self.collectionView.reloadItems(at: [indexPathPrevious])
                self.selectedIndexPath = (indexPath, true)
            }
        }
        // Change filter for selected image
        DispatchQueue.main.async {
            self.collectionView.reloadItems(at: [indexPath])
            self.configureSelectedCardInfo()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension UIImage {
    var noir: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
            let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
}

class TestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
}
