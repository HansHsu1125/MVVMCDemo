//
//  ContentCell.swift
//  TestSwiftPro
//
//  Created by Hans Hsu on 2020/7/23.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import UIKit

class ListCell : UITableViewCell {
    let titleLabel: UILabel = .init(frame: .zero)
    let contentLabel: UILabel = .init(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        contentLabel.text = nil
    }
}

//Private - api
private extension ListCell {
    func setupViews() {
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 17)
        contentLabel.textColor = .black
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentLabel)
    }
    
    func setupConstraints() {
        let titleAnchor1 = titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor , constant: 10)
        titleAnchor1.isActive = true
        let titleAnchor2 = titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 5)
        titleAnchor2.isActive = true
        let titleAnchor3 = titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor , constant: -10)
        titleAnchor3.isActive = true
        let titleAnchor4 = titleLabel.heightAnchor.constraint(equalToConstant: 25)
        titleAnchor4.isActive = true
        
        let contentAnchor1 = contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        contentAnchor1.isActive = true
        let contentAnchor2 = contentLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        contentAnchor2.isActive = true
        let contentAnchor3 = contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        contentAnchor3.isActive = true
        let contentAnchor4 = contentLabel.heightAnchor.constraint(equalToConstant: 40)
        contentAnchor4.priority = UILayoutPriority.init(999)
        contentAnchor4.isActive = true
        let contentAnchor5 = contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -10)
        contentAnchor5.isActive = true
    }
}

//Public - api
internal extension ListCell {
    func configure(info: ContentModel) {
        titleLabel.text = info.title
        contentLabel.text = info.content
    }
}
