//
//  ViewController.swift
//  News-App
//
//  Created by Edo Lorenza on 18/05/21.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Properties
    private let reuseIdentifier = "NewsCell"
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        return table
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Top News"
        navigationController?.navigationBar.prefersLargeTitles = true
        setupView()
        APICaller.shared.getTopNews { result in
            switch result{
            case .success(let response):
                print(response)
            case . failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Helpers
    private func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.fillSuperview()
    }
}


//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NewsCell
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

