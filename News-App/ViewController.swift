//
//  ViewController.swift
//  News-App
//
//  Created by Edo Lorenza on 18/05/21.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    //MARK: - Properties
    private let reuseIdentifier = "NewsCell"
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        return table
    }()
    
    private var viewModels = [NewsTableViewCellViewModel]()
    private var articles = [Articles]()
    private var searchVC = UISearchController(searchResultsController: nil)
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Top News"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupView()
        setupSearchBar()
        fetchTopNews()
    }
   
    //MARK: - API
    private func fetchTopNews(){
        APICaller.shared.getTopNews { [weak self ] result in
            switch result{
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                     title: $0.title,
                     subtitle: $0.description ?? "",
                     imageURL: URL(string:$0.urlToImage ?? "")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case . failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Helpers
    private func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = view.frame.width / 3
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
    
    private func setupSearchBar(){
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
}


//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NewsCell
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        guard let url = URL(string: article.url)  else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        
        APICaller.shared.searchNews(with:text) { [weak self] result in
            switch result{
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(
                     title: $0.title,
                     subtitle: $0.description ?? "",
                     imageURL: URL(string:$0.urlToImage ?? "")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.searchVC.dismiss(animated: true)
                }
            case . failure(let error):
                print(error)
            }
        }
    }
}
