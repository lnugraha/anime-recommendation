//
//  ViewController.swift
//  anime_recommendation
//
//  Created by Leo Nugraha on 2021/8/30.
//

import UIKit

class ViewController: UIViewController {

    var AnimeListArray = [AnimeProperties]()
    var loadingStatus = false
    
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

    let tb = UITableView(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = blColor

        adjustElementsPosition()
        adjustTablePositon()
    }

    private func adjustElementsPosition() {

        APIHandlers.getAnimeListFromPage(pageNumber: MIN_PAGE, completionHandler: { [weak self] result in
            switch result{
            case .success(let animeLists):
                self?.AnimeListArray.append(contentsOf: animeLists)
                DispatchQueue.main.async {
                    self?.tb.reloadData()
                }
            case .failure(let error):
                print("DEBUG: \(#function) \(#line) \(error)")
            }
        })

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

    // MARK: How many cells will be prepared in one batch
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AnimeListArray.count
    }

    // MARK: How each cell will be designed
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeDescriptionCell") as! AnimeDescriptionCell
        cell.setCellProperties(logo: AnimeListArray[indexPath.row].image_url!, title: AnimeListArray[indexPath.row].title, score: AnimeListArray[indexPath.row].score)
        return cell
    }

    // MARK: How each cell will interact and response after receiving inputs
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animeDetailsView = AnimeDetailsView()
        animeDetailsView.modalPresentationStyle = .formSheet
        let targetAnime = AnimeListArray[indexPath.row]
        animeDetailsView.mainInformation = MainInfo(title: targetAnime.title, type: targetAnime.type!, episode: targetAnime.episodes!, start_date: targetAnime.start_date!, end_date: targetAnime.end_date!, members: targetAnime.members!, score: targetAnime.score, img_url: targetAnime.image_url!, url: targetAnime.url!)
        present(animeDetailsView, animated: false, completion: nil)
    }

    func createSpinnerFooter() -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = view.center
        view.addSubview(spinner)
        spinner.startAnimating()
        return view
    }

    // MARK: Signal that more data need to be fetched
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        
        var index = AnimeListArray.count / 50
        if position > (self.tb.contentSize.height - CGFloat(BATCH_CAPACITY) - scrollView.frame.size.height) {
            print("DEBUG: Fetch More Data \(#function) \(#line)")
            self.tb.tableFooterView = createSpinnerFooter()

            if loadingStatus == false {
                loadingStatus = true
                index += 1
                APIHandlers.getAnimeListFromPage(pageNumber: index, completionHandler: { [weak self] result in
                    switch result{
                    case .success(let animeLists):
                        self?.AnimeListArray.append(contentsOf: animeLists)
                        DispatchQueue.main.async {
                            self?.tb.reloadData()
                        }
                    case .failure(let error):
                        print("DEBUG: \(#function) \(#line) \(error)")
                    }
                })

            } // end-if loadingStatus
            DispatchQueue.main.async {
                self.tb.tableFooterView = nil
                self.loadingStatus = false
            }
        } // end-if
    }

}
