//
//  RootViewController.swift
//  MVVMSample3-RxSwift
//
//  Created by taehy.k on 2021/08/03.
//

import UIKit

import RxSwift
import RxRelay

class RootViewController: BaseViewController {
    
    // MARK: - Properties
    let disposedBag = DisposeBag()
    let viewModel: RootViewModel
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()
    
    private let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var articleViewModelObserver: Observable<[ArticleViewModel]> {
        return articleViewModel.asObservable()
    }
    
    // MARK: - Life Cycle
    /// 생성자로써 초기화해주는 이유는 의존성 주입, ViewModel에 대한 관심을 가지지 않겠다.
    init(rootViewModel: RootViewModel) {
        self.viewModel = rootViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        fetchArticles()
        subsribe()
    }
    
    // MARK: - Configure
    override func configureUI() {
        super.configureUI()
        
        title = viewModel.title
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
    }
    
    func configureCollectionView() {
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    // MARK: - Helpers
    private func fetchArticles() {
        viewModel.fetchNews().subscribe(onNext: { articleViewModel in
            self.articleViewModel.accept(articleViewModel)
        }).disposed(by: disposedBag)
    }
    
    private func subsribe() {
        articleViewModelObserver.subscribe(onNext: { _ in
            // collectionview reload()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }).disposed(by: disposedBag)
    }
}

extension RootViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articleViewModel.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArticleCell
        
        let articleViewModel = articleViewModel.value[indexPath.row]
        cell.viewModel.onNext(articleViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
