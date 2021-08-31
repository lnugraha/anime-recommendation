//
//  AnimeDescriptionCell.swift
//  anime_recommendation
//
//  Created by Leo Nugraha on 2021/8/30.
//

import UIKit

class AnimeDescriptionCell: UITableViewCell {

    private lazy var labelCell: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.backgroundColor = gyColor
        return label
    }()
    
    private lazy var imageLogo: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 2
        image.layer.borderColor = bkColor.cgColor
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Anime Title Here"
        label.backgroundColor = gyColor
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = bkColor
        return label
    }()

    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score: 0/10"
        label.backgroundColor = gyColor
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = bkColor
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = bkColor
        
        addSubview(labelCell)
        labelCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            labelCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            labelCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            labelCell.heightAnchor.constraint(equalToConstant: 80)
        ])

        addSubview(imageLogo)
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageLogo.topAnchor.constraint(equalTo: labelCell.topAnchor, constant: 10),
            imageLogo.leadingAnchor.constraint(equalTo: labelCell.leadingAnchor, constant: 10),
            imageLogo.widthAnchor.constraint(equalToConstant: 60),
            imageLogo.heightAnchor.constraint(equalToConstant: 60)
        ])

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: labelCell.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: imageLogo.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: labelCell.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])

        addSubview(scoreLabel)
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scoreLabel.bottomAnchor.constraint(equalTo: labelCell.bottomAnchor, constant: -10),
            scoreLabel.leadingAnchor.constraint(equalTo: imageLogo.trailingAnchor, constant: 10),
            scoreLabel.trailingAnchor.constraint(equalTo: labelCell.trailingAnchor, constant: -10),
            scoreLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setCellProperties(logo: String, title: String, score: Double) {
        imageLogo.load(urlStr: logo)
        titleLabel.text = title
        scoreLabel.text = "Score: " + String(score) + "/10.0"
    }
    
}
