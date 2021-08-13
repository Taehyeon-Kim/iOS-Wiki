//
//  ViewController.swift
//  DynamicSizingCell
//
//  Created by taehy.k on 2021/08/13.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {
    
    // MARK: - Properties
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        // Flow Layout 선언
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16)
        $0.setCollectionViewLayout(layout, animated: false)
        
        $0.backgroundColor = .systemBackground
        $0.showsHorizontalScrollIndicator = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    private var items: [String] = [
        "전체",
        "음악",
        "배구",
        "요리 프로그램",
        "관광지",
        "축구",
        "시각 예술",
        "반려동물",
        "최근에 업로드된 동영상",
        "실시간",
        "믹스",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(40)
        }
    }

}

// MARK: - CollectionView Delegate&DataSource
// Typealias 사용
typealias CollectionViewMethods = UICollectionViewDelegate & UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

extension ViewController: CollectionViewMethods {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(name: items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CollectionViewCell.fittingSize(availableHeight: 30, name: items[indexPath.item])
    }
}

// MARK: - Cell
final class CollectionViewCell: UICollectionViewCell {
    
    static func fittingSize(availableHeight: CGFloat, name: String?) -> CGSize {
        let cell = CollectionViewCell()
        cell.configure(name: name)
        
        let targetSize = CGSize(width: UIView.layoutFittingCompressedSize.width, height: availableHeight)
        return cell.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .required)
    }
    
    private let titleLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2
    }
    
    private func setupView() {
        backgroundColor = .darkGray
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(7.5)
        }
    }
    
    func configure(name: String?) {
        titleLabel.text = name
    }
    
}
