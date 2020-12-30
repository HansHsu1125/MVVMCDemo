//
//  DetailViewController.swift
//  MVVMCDemoProject
//
//  Created by Hans Hsu on 2020/8/26.
//  Copyright © 2020 Hans Hsu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    let contentInfo: ContentModel
    let scrollView: UIScrollView = .init()
    let titleLabel: UILabel = .init()
    let contentLabel: UILabel = .init()
    
    init(contentInfo: ContentModel) {
        self.contentInfo = contentInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        setupConstraints()
        updateContentInfo(info: contentInfo)
    }
}

// For initial 
private extension DetailViewController {
    func setupSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.backgroundColor = .darkGray
        scrollView.layer.cornerRadius = 5.0
        scrollView.layer.masksToBounds = true
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(contentLabel)
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 18)
        contentLabel.textColor = .white
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        titleLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor , constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor , constant: -10).isActive = true
        titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor , constant:  10).isActive = true
        
        scrollView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor , constant:  10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor , constant: -10).isActive = true

        contentLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor , constant: 10).isActive = true
        contentLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor , constant: -20).isActive = true
        contentLabel.topAnchor.constraint(equalTo: scrollView.topAnchor , constant:  10).isActive = true
        contentLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor , constant:  -10).isActive = true
    }
    
    func updateContentInfo(info: ContentModel) {
        titleLabel.text = info.title
        contentLabel.text = info.content
    }
}
