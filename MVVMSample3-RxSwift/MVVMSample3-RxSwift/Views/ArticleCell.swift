//
//  ArticleCell.swift
//  MVVMSample3-RxSwift
//
//  Created by taehy.k on 2021/08/03.
//

import UIKit

import RxSwift
import Kingfisher

class ArticleCell: UICollectionViewCell {
    // MARK: - Properties
    let disposedBag = DisposeBag()
    var viewModel = PublishSubject<ArticleViewModel>()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 60).isActive = true
        iv.backgroundColor = .secondarySystemBackground
        return iv
    }()
    
    lazy var titleLabel: UILabel =  {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    
    // MARK: - Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func subscribe() {
        viewModel.subscribe(onNext: { articleViewModel in
            if let urlString = articleViewModel.imageUrl {
                let url = URL(string: urlString)
                self.imageView.kf.setImage(with: url)
            }
            
            self.titleLabel.text = articleViewModel.title
            self.descriptionLabel.text = articleViewModel.description
        }).disposed(by: disposedBag)
    }
    
    // MARK: - Configure
    
    func configureUI() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
    }
}
