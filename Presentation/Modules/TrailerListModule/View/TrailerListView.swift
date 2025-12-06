//
//  TrailerListView.swift
//  MovieApp
//
//  Created by VladOS on 07.08.2025.
//

import UIKit

protocol TrailerListViewProtocol: AnyObject {
    func showVideos(_ videos: [TrailerVideoCellViewModel])
}

class TrailerListView: UIViewController {
    
    var presenter: TrailerListPresenterProtocol!
    private var videos: [TrailerVideoCellViewModel] = []
    
    private lazy var sectionLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .appWhite
        $0.textAlignment = .center
        $0.text = "Trailer List"
        return $0
    }(UILabel())
    
    private lazy var topBackButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.heightAnchor.constraint(equalToConstant: 25).isActive = true
        $0.widthAnchor.constraint(equalToConstant: 25).isActive = true
        $0.setBackgroundImage(.leftChevron, for: .normal)
        return $0
    }(UIButton(primaryAction: backButtonAction))
    
    private lazy var backButtonAction = UIAction { [weak self] _ in
        guard let self = self,
              let tabBarVC = self.tabBarController as? TabBarView else { return }
        tabBarVC.selectedIndex = 0
        tabBarVC.setTabBarButtonsHidden(false)
        print("TabBar появился")
    }
    
    private lazy var videoTableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.register(TrailerVideoCell.self, forCellReuseIdentifier: TrailerVideoCell.reuseId)
        return $0
    }(UITableView())
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.applyGradient(topColor: .appBGTop, bottomColor: .appBGBottom)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topBackButton)
        view.addSubview(sectionLabel)
        view.addSubview(videoTableView)
        setupConstraints()
        presenter.loadTrendingVideos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (tabBarController as? TabBarView)?.setTabBarButtonsHidden(true)
    }
 
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            sectionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sectionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            topBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            topBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            videoTableView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 20),
            videoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            videoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            videoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension TrailerListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrailerVideoCell.reuseId,for: indexPath) as? TrailerVideoCell else {
            return UITableViewCell()
        }
        
        cell.configureTrailerMovieVideoCell(with: videos[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension TrailerListView: TrailerListViewProtocol {
    
    func showVideos(_ videos: [TrailerVideoCellViewModel]) {
        self.videos = videos
        videoTableView.reloadData()
    }
}

extension TrailerListView: TrailerVideoCellDelegate  {
    
    func didTapTrailerListButton(in cell: TrailerVideoCell) {
        guard let indexPath = videoTableView.indexPath(for: cell) else { return }
        
        let videoVM = videos[indexPath.row]
        presenter.didTapTrailerListButton(videoVM: videoVM)
    }
}
