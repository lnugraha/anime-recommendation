//
//  ViewController.swift
//  anime_recommendation
//
//  Created by Leo Nugraha on 2021/8/30.
//

import UIKit

class ViewController: UIViewController {

    var AnimeListArray = [AnimeProperties]()
    
    private lazy var topBanner: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 110))
        view.backgroundColor = blColor
        let label = UILabel()
        label.text = "Anime List"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = gyColor
        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])

        return view
    }()

    private lazy var bottomBanner: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 80))
        view.backgroundColor = blColor
        return view
    }()

    private lazy var nextButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 200, width: 200, height: 200))
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        button.tintColor = gyColor
        return button
    }()

    private let currentPageLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = String(GlobalDataAccess.shared.counter)
        label.textColor = gyColor
        return label
    }()

    @objc func nextButtonTapped() {
        if GlobalDataAccess.shared.counter == MAX_PAGE {
            GlobalDataAccess.shared.counter = MAX_PAGE
        } else {
            GlobalDataAccess.shared.counter += 1
            print(GlobalDataAccess.shared.counter)

            APIHandlers.getAnimeListFromPage(pageNumber: GlobalDataAccess.shared.counter, completionHandler: { result in
                switch result{
                case .success(let animeLists):
                    print("DEBUG: \(#function) \(#line) \(animeLists[0].title)")
                    print("DEBUG: \(#function) \(#line) \(animeLists.count)")
                case .failure(let error):
                    print("DEBUG: \(#function) \(#line) \(error)")
                }
            })

//            let viewController = ViewController()
//            viewController.modalPresentationStyle = .fullScreen
//            present(viewController, animated: false, completion: nil)
//            adjustTablePositon()
//            adjustElementsPosition()
        }
    }

    private lazy var prevButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.addTarget(self, action: #selector(prevButtonTapped), for: .touchUpInside)
        button.tintColor = gyColor
        return button
    }()

    @objc func prevButtonTapped() {
        if GlobalDataAccess.shared.counter != 1 {
            GlobalDataAccess.shared.counter -= 1
            print(GlobalDataAccess.shared.counter)

            APIHandlers.getAnimeListFromPage(pageNumber: GlobalDataAccess.shared.counter, completionHandler: { result in
                switch result{
                case .success(let animeLists):
                    print("DEBUG: \(#function) \(#line) \(animeLists[0].title)")
                    print("DEBUG: \(#function) \(#line) \(animeLists.count)")
                    self.AnimeListArray = animeLists
                case .failure(let error):
                    print("DEBUG: \(#function) \(#line) \(error)")
                }
            })

//            let viewController = ViewController()
//            viewController.modalPresentationStyle = .fullScreen
//            present(viewController, animated: false, completion: nil)
//            adjustTablePositon()
//            adjustElementsPosition()
        }
    }

    let tb = UITableView(frame: UIScreen.main.bounds)

//    override func viewWillAppear(_ animated: Bool) {
//        adjustTablePositon()
//        adjustElementsPosition()
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = blColor

        adjustElementsPosition()
        adjustTablePositon()

    }

    private func adjustElementsPosition() {
        print("Current counter: \(GlobalDataAccess.shared.counter)")

        if GlobalDataAccess.shared.counter == 1 {
            APIHandlers.getAnimeListFromPage(pageNumber: 1, completionHandler: { result in
                switch result{
                case .success(let animeLists):
                    print("DEBUG: \(#function) \(#line) \(animeLists[0].title)")
                    print("DEBUG: \(#function) \(#line) \(animeLists.count)")
                    let totalAnime = animeLists.count
                    for i in 0..<totalAnime {
                        let checkAnimeElement = animeLists[i]
                        self.AnimeListArray.append(checkAnimeElement)
                    }

                case .failure(let error):
                    print("DEBUG: \(#function) \(#line) \(error)")
                }
            })
        }

        print("AnimeList Array Debug: \(AnimeListArray.count) \(#function) \(#line)")
        
        self.view.addSubview(topBanner)
        topBanner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topBanner.topAnchor.constraint(equalTo: self.view.topAnchor),
            topBanner.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            topBanner.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            topBanner.heightAnchor.constraint(equalToConstant: 80)
        ])

        self.view.addSubview(bottomBanner)
        bottomBanner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomBanner.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            bottomBanner.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            bottomBanner.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            bottomBanner.heightAnchor.constraint(equalToConstant: 60)
        ])
/*
        if GlobalDataAccess.shared.counter != MAX_PAGE {
            self.bottomBanner.addSubview(nextButton)
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                nextButton.centerYAnchor.constraint(equalTo: self.bottomBanner.centerYAnchor),
                nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
                nextButton.widthAnchor.constraint(equalToConstant: 100),
                nextButton.heightAnchor.constraint(equalToConstant: 100)
            ])
        }

        if GlobalDataAccess.shared.counter != 1 {
            self.bottomBanner.addSubview(prevButton)
            prevButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                prevButton.centerYAnchor.constraint(equalTo: self.bottomBanner.centerYAnchor),
                prevButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
                prevButton.widthAnchor.constraint(equalToConstant: 100),
                prevButton.heightAnchor.constraint(equalToConstant: 100)
            ])
        }

        self.bottomBanner.addSubview(currentPageLabel)
        currentPageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentPageLabel.centerYAnchor.constraint(equalTo: self.bottomBanner.centerYAnchor),
            currentPageLabel.centerXAnchor.constraint(equalTo: self.bottomBanner.centerXAnchor),
            currentPageLabel.widthAnchor.constraint(equalToConstant: 30),
            currentPageLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
*/
    }
    
    private func adjustTablePositon() {
        self.view.addSubview(tb)
        self.tb.rowHeight = 90
        self.tb.layoutMargins = UIEdgeInsets.zero
        self.tb.separatorInset = UIEdgeInsets.zero
        self.tb.showsVerticalScrollIndicator = false
        self.tb.separatorStyle = .none
        self.tb.register(AnimeDescriptionCell.self, forCellReuseIdentifier: "AnimeDescriptionCell")
        self.tb.delegate = self
        self.tb.dataSource = self
        self.tb.tableFooterView = UIView(frame: .zero)
        tb.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tb.topAnchor.constraint(equalTo: self.topBanner.bottomAnchor),
            tb.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tb.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tb.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height - 140)
        ])
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AnimeListArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeDescriptionCell") as! AnimeDescriptionCell
        cell.setCellProperties(logo: AnimeListArray[indexPath.row].image_url!, title: AnimeListArray[indexPath.row].title, score: AnimeListArray[indexPath.row].score)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animeDetailsView = AnimeDetailsView()
        animeDetailsView.modalPresentationStyle = .formSheet
        let targetAnime = AnimeListArray[indexPath.row]
        animeDetailsView.mainInformation = MainInfo(title: targetAnime.title, type: targetAnime.type!, episode: targetAnime.episodes!, start_date: targetAnime.start_date!, end_date: targetAnime.end_date!, members: targetAnime.members!, score: targetAnime.score, img_url: targetAnime.image_url!, url: targetAnime.url!)
        present(animeDetailsView, animated: false, completion: nil)
    }

}
