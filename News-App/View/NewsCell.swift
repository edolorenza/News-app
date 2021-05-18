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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "News One Its Good"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private let newsImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 6
        return iv
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
        addSubview(newsImage)
        newsImage.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        newsImage.setDimensions(height: frame.width/3, width: frame.width/3)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: newsImage.rightAnchor,right: rightAnchor, paddingTop: 8, paddingLeft: 4, paddingRight: 8)
        
        addSubview(subtitleLabel)
        subtitleLabel.anchor(top: titleLabel.bottomAnchor,left: newsImage.rightAnchor, bottom: bottomAnchor,right: rightAnchor, paddingTop: 4, paddingLeft: 4, paddingBottom: 4, paddingRight: 8)
        
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        newsImage.image = nil
    }
    
    func configure(with viewModel: NewsTableViewCellViewModel){
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        if let data = viewModel.imageData {
            newsImage.image = UIImage(data: data)
        }else if let url = viewModel.imageURL{
            URLSession.shared.dataTask(with: url){ [weak self] data, _, error in
                guard let data = data, error == nil else { return }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
