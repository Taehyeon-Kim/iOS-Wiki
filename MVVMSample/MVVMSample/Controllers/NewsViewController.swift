//
//  NewsViewController.swift
//  MVVMSample
//
//  Created by taehy.k on 2021/07/30.
//

import UIKit

class NewsViewController: UIViewController {
    
    // MARK: - Properties
    private var articleListVM: ArticleListViewModel!
    
    // MARK: - IBOutlets
    @IBOutlet private var tableView: UITableView!

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Configure
    private func setup() {
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=e9b514c39c5f456db8ed4ecb693b0040")!
        NewsService().getArticles(url: url) {
            [weak self] (articles) in
            
            if let articles = articles {
                self?.articleListVM = ArticleListViewModel(articles: articles)
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - TableView Delegate, DataSource
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return articleListVM == nil ? 0 : articleListVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articleListVM.numberOfRowSections(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticleTableViewCell = tableView.cell(cellForRowAt: indexPath)
        let articleVM = articleListVM.articleAtIndex(indexPath.row)
        cell.configure(articleVM)
        return cell
    }
}
