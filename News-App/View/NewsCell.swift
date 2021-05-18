//
//  NewsCell.swift
//  News-App
//
//  Created by Edo Lorenza on 18/05/21.
//

import UIKit

class NewsCell: UITableViewCell{
    //MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "News One Its Good"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    private func setupView(){
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
    }
}
