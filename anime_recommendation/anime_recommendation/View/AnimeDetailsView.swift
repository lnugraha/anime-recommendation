//
//  AnimeDetailsView.swift
//  anime_recommendation
//
//  Created by Leo Nugraha on 2021/8/30.
//

import Foundation
import UIKit

struct MainInfo {
    var title: String
    var type: String
    var episode: Int
    var start_date: String
    var end_date: String
    var members: Int
    var score: Double
    var img_url: String
    var url: String
}

class AnimeDetailsView: UIViewController {

    var mainInformation = MainInfo(title: "", type: "", episode: 0, start_date: "N/A", end_date: "N/A", members: 0, score: 0.0, img_url: "", url: "")
    
    private lazy var imageIcon: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.black.cgColor
        image.load(urlStr: mainInformation.img_url)
        return image
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = bk_6Color
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Title"
        return label
    }()

    private lazy var titleContent: UILabel = {
        let label = UILabel()
        label.textColor = bkColor
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "\(String(describing: mainInformation.title))"
        label.textAlignment = .center
        return label
    }()

    private lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.textColor = bk_6Color
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Summary"
        return label
    }()
    
    private lazy var linkButton: UIButton = {
        let button = UIButton()
        button.tintColor = bkColor
//        button.setTitle("Check this out", for: .normal)
//        button.titleLabel!.font = UIFont.systemFont(ofSize: 20)
//        button.titleLabel?.textColor = bkColor
        button.setImage(UIImage(systemName: "link"), for: .normal)
//        button.titleLabel?.textAlignment = .left
        button.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc func linkButtonTapped() {
        guard let url = URL(string: mainInformation.url) else {
            return
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }

    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = bk_6Color
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Type"
        return label
    }()

    private lazy var typeContent: UILabel = {
        let label = UILabel()
        label.textColor = bkColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "\(String(describing: mainInformation.type))"
        return label
    }()

    private lazy var episodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = bk_6Color
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Episodes"
        return label
    }()

    private lazy var episodeContent: UILabel = {
        let label = UILabel()
        label.textColor = bkColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "\(String(describing: mainInformation.episode))"
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = bk_6Color
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Date"
        return label
    }()

    private lazy var dateContent: UILabel = {
        let label = UILabel()
        label.textColor = bkColor
        label.font = UIFont.systemFont(ofSize: 16)

        if mainInformation.episode == 1 {
            label.text = "\(String(describing: mainInformation.start_date))"
        } else {
            label.text = "\(String(describing: mainInformation.start_date)) - " + "\(String(describing: mainInformation.end_date))"
        }
        return label
    }()

    private lazy var membersLabel: UILabel = {
        let label = UILabel()
        label.textColor = bk_6Color
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Members"
        return label
    }()

    private lazy var membersContent: UILabel = {
        let label = UILabel()
        label.textColor = bkColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "\(String(describing: mainInformation.members))"
        return label
    }()

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = bk_6Color
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "Score"
        return label
    }()

    private lazy var scoreContent: UILabel = {
        let label = UILabel()
        label.textColor = bkColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "\(String(describing: mainInformation.score)) / 10.0"
        return label
    }()

    private func attachLabels() {

        let TWENTY_SPACING: CGFloat = 16.0; let FORTY_SPACING: CGFloat = 40
        let IMG_WIDTH: CGFloat = 160

        self.view.addSubview(imageIcon)

        self.view.addSubview(titleLabel); self.view.addSubview(titleContent)
        self.view.addSubview(typeLabel); self.view.addSubview(typeContent)
        self.view.addSubview(linkButton)
        self.view.addSubview(episodeLabel); self.view.addSubview(episodeContent)
        self.view.addSubview(dateLabel); self.view.addSubview(dateContent)
        self.view.addSubview(membersLabel); self.view.addSubview(membersContent)
        self.view.addSubview(scoreLabel); self.view.addSubview(scoreContent)

        imageIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageIcon.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20),
            imageIcon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            imageIcon.widthAnchor.constraint(equalToConstant: IMG_WIDTH),
            imageIcon.heightAnchor.constraint(equalToConstant: 4*IMG_WIDTH/3)
        ])

        titleContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleContent.bottomAnchor.constraint(equalTo: self.imageIcon.topAnchor, constant: -10),
            titleContent.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            titleContent.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            titleContent.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            titleContent.heightAnchor.constraint(equalToConstant: 50)
        ])

        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: self.imageIcon.bottomAnchor, constant: TWENTY_SPACING),
            typeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: FORTY_SPACING),
            typeLabel.widthAnchor.constraint(equalToConstant: 200),
            typeLabel.heightAnchor.constraint(equalToConstant: 22)
        ])

        typeContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            typeContent.topAnchor.constraint(equalTo: self.imageIcon.bottomAnchor, constant: TWENTY_SPACING),
            typeContent.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -TWENTY_SPACING),
            typeContent.widthAnchor.constraint(equalToConstant: 200),
            typeContent.heightAnchor.constraint(equalToConstant: 22)
        ])

        episodeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episodeLabel.topAnchor.constraint(equalTo: self.typeLabel.bottomAnchor, constant: TWENTY_SPACING),
            episodeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: FORTY_SPACING),
            episodeLabel.widthAnchor.constraint(equalToConstant: 100),
            episodeLabel.heightAnchor.constraint(equalToConstant: 22)
        ])

        episodeContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            episodeContent.topAnchor.constraint(equalTo: self.typeLabel.bottomAnchor, constant: TWENTY_SPACING),
            episodeContent.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -TWENTY_SPACING),
            episodeContent.widthAnchor.constraint(equalToConstant: 200),
            episodeContent.heightAnchor.constraint(equalToConstant: 22)
        ])

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: self.episodeLabel.bottomAnchor, constant: TWENTY_SPACING),
            dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: FORTY_SPACING),
            dateLabel.widthAnchor.constraint(equalToConstant: 100),
            dateLabel.heightAnchor.constraint(equalToConstant: 22)
        ])

        dateContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateContent.topAnchor.constraint(equalTo: self.episodeLabel.bottomAnchor, constant: TWENTY_SPACING),
            dateContent.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -TWENTY_SPACING),
            dateContent.widthAnchor.constraint(equalToConstant: 200),
            dateContent.heightAnchor.constraint(equalToConstant: 22)
        ])

        membersLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            membersLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: TWENTY_SPACING),
            membersLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: FORTY_SPACING),
            membersLabel.widthAnchor.constraint(equalToConstant: 100),
            membersLabel.heightAnchor.constraint(equalToConstant: 22)
        ])

        membersContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            membersContent.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: TWENTY_SPACING),
            membersContent.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -TWENTY_SPACING),
            membersContent.widthAnchor.constraint(equalToConstant: 200),
            membersContent.heightAnchor.constraint(equalToConstant: 22)
        ])

        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: self.membersLabel.bottomAnchor, constant: TWENTY_SPACING),
            scoreLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: FORTY_SPACING),
            scoreLabel.widthAnchor.constraint(equalToConstant: 100),
            scoreLabel.heightAnchor.constraint(equalToConstant: 22)
        ])

        scoreContent.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreContent.topAnchor.constraint(equalTo: self.membersLabel.bottomAnchor, constant: TWENTY_SPACING),
            scoreContent.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -TWENTY_SPACING),
            scoreContent.widthAnchor.constraint(equalToConstant: 200),
            scoreContent.heightAnchor.constraint(equalToConstant: 22)
        ])

        self.view.addSubview(linkLabel); self.view.addSubview(linkButton)
        linkLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            linkLabel.topAnchor.constraint(equalTo: self.scoreLabel.bottomAnchor, constant: TWENTY_SPACING),
            linkLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: FORTY_SPACING),
            linkLabel.widthAnchor.constraint(equalToConstant: 100),
            linkLabel.heightAnchor.constraint(equalToConstant: 22)
        ])

        linkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            linkButton.topAnchor.constraint(equalTo: self.scoreLabel.bottomAnchor, constant: TWENTY_SPACING),
            linkButton.leadingAnchor.constraint(equalTo: self.scoreLabel.trailingAnchor, constant: 10),
            linkButton.widthAnchor.constraint(equalToConstant: 32),
            linkButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = gyColor
        attachLabels()
        
    }
    
}
