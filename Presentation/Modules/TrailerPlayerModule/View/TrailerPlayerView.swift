//
//  TrailerPlayerView.swift
//  MovieApp
//
//  Created by VladOS on 24.08.2025.
//

import UIKit
import YouTubeiOSPlayerHelper

protocol TrailerPlayerViewProtocol: AnyObject {
    func loadVideo(with key: String)
    func setTitle(_ text: String)
    func showVideoList(_ videos: [TrailerPlayerCellViewModel])
}

class TrailerPlayerView: UIViewController {
    
    var presenter: TrailerPlayerPresenterProtocol!
    var tvPresenter: TVTrailerPlayerPresenterProtocol!
    
    private let playerView = YTPlayerView()
    private var trailerVideoVM: [TrailerPlayerCellViewModel] = []
    private var currentVideoKey: String?
    
    private lazy var collectionView: UICollectionView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(TrailerThumbCell.self, forCellWithReuseIdentifier: TrailerThumbCell.reuseId)
        $0.backgroundColor = .clear
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: createLayout()))
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),heightDimension: .absolute(130))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .absolute(130))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,subitems: [item])
            group.interItemSpacing = .fixed(20)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 12
            return section
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBarWithBackButton(title: title, backAction: #selector(didTapBack))
        view.backgroundColor = .black
        setupPlayerView()
        setupCollection()
        presenter.viewDidLoad()
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupPlayerView() {
        view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 9.0/16.0) // 16:9
        ])
    }
    
    private func setupCollection() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension TrailerPlayerView: TrailerPlayerViewProtocol {
    
    func setTitle(_ text: String) {
        navigationItem.title = text
    }
    
    func loadVideo(with key: String) {
        currentVideoKey = key
        playerView.load(withVideoId: key, playerVars: ["playsinline": 1, "autoplay": 1, "modestbranding": 1, "rel": 0])
        // выделить выбранную миниатюру, если она есть
        if let index = trailerVideoVM.firstIndex(where: { $0.videoKey == key }) {
            let indexPath = IndexPath(item: index, section: 0)
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
    func showVideoList(_ videos: [TrailerPlayerCellViewModel]) {
        print("videos count:", videos.count)
        self.trailerVideoVM = videos
        collectionView.reloadData()
        // выделить текущее видео (если совпадает)
        if let key = currentVideoKey,
           let index = videos.firstIndex(where: { $0.videoKey == key }) {
            let indexPath = IndexPath(item: index, section: 0)
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
        }
    }
    
}

// MARK: - Collection data source & delegate
extension TrailerPlayerView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        trailerVideoVM.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrailerThumbCell.reuseId, for: indexPath) as? TrailerThumbCell else {
            return UICollectionViewCell()
        }
        let videoVM = trailerVideoVM[indexPath.item]
        cell.configureVideoCell(with: videoVM)
        cell.layer.borderWidth = (videoVM.videoKey == currentVideoKey) ? 2 : 0
        cell.layer.borderColor = UIColor.systemBlue.cgColor
        cell.layer.cornerRadius = 5
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previousKey = currentVideoKey
        presenter.didSelectVideo(at: indexPath.item)
        
        // найти индекс предыдущего видео и обновить ячейку
        if let prevKey = previousKey,
           let prevIndex = trailerVideoVM.firstIndex(where: { $0.videoKey == prevKey }) {
            let prevIndexPath = IndexPath(item: prevIndex, section: 0)
            collectionView.reloadItems(at: [prevIndexPath])
        }
        
        // обновить текущую ячейку
        collectionView.reloadItems(at: [indexPath])
    }
    
}
