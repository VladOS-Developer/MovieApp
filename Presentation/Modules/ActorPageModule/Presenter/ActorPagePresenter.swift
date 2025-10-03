//
//  ActorPagePresenter.swift
//  MovieApp
//
//  Created by VladOS on 15.09.2025.
//

import UIKit

protocol ActorPagePresenterProtocol: AnyObject {
    func viewDidLoad()
    func didActorSelectTab(index: Int)
    func didSelectFilmographyMovie(_ movie: ActorMovieCellViewModel)
    
    init(view: ActorPageViewProtocol,
         router: ActorPageRouterProtocol,
         actorRepository: ActorRepositoryProtocol,
         movieCreditsRepository: MovieCreditsRepositoryProtocol,
         actorId: Int,
         actorTitle: String)
}

class ActorPagePresenter: ActorPagePresenterProtocol {
        
    private weak var view: ActorPageViewProtocol?
    private let router: ActorPageRouterProtocol
    
    private let actorRepository: ActorRepositoryProtocol
    private let movieCreditsRepository: MovieCreditsRepositoryProtocol
    
    private var actorId: Int
    private let actorTitle: String
    
    private var actorDetails: ActorDetails?
    private var actorMovies: [ActorMovie] = []
    private var actorImages: [ActorImages] = []
    
    private var sections: [ActorPageCollectionSection] = []
    
    required init(view: ActorPageViewProtocol,
                  router: ActorPageRouterProtocol,
                  actorRepository: ActorRepositoryProtocol,
                  movieCreditsRepository: MovieCreditsRepositoryProtocol,
                  actorId: Int,
                  actorTitle: String) {
        
        self.view = view
        self.actorTitle = actorTitle
        self.actorRepository = actorRepository
        self.movieCreditsRepository = movieCreditsRepository
        self.actorId = actorId
        self.router = router
    }
    
    func didSelectFilmographyMovie(_ movie: ActorMovieCellViewModel) {
        router.openMoviePage(movieId: movie.id, movieTitle: movie.title)
    }
    
    func viewDidLoad() {
        
        Task {
            do {
                // параллельная загрузка
                async let detailsTask = actorRepository.fetchActorDetails(by: actorId)
                async let moviesTask  = actorRepository.fetchActorMovies(by: actorId)
                async let imagesTask  = actorRepository.fetchActorImages(by: actorId)
                
                let (details, movies, images) = try await (detailsTask, moviesTask, imagesTask)
                
                self.actorDetails = details
                self.actorMovies = movies
                self.actorImages = images
                
                let initialSections = buildBaseSections(details: details, movies: movies)
                
                await MainActor.run {
                    self.sections = initialSections
                    self.view?.showActorSections(sections: initialSections)
                    self.view?.setTitle(self.actorTitle)
                    
                    self.didActorSelectTab(index: 0)
                }
                
            } catch {
                print("Ошибка загрузки данных актёра: \(error)")
            }
        }
    }
    
    private func buildBaseSections(details: ActorDetails, movies: [ActorMovie]) -> [ActorPageCollectionSection] {
        
        let headerVM = ActorHeaderCellViewModel(actorDetails: details, actorMovies: movies)
        
        return [
            .init(type: .header, items: [.header(headerVM)]),
            .init(type: .socialStackButtons, items: []),
            .init(type: .actorSegmentedTabs, items: [])
        ]
    }
    
    func didActorSelectTab(index: Int) {
     
        guard let details = actorDetails else { return }
        
        var newSections: [ActorPageCollectionSection] = []
        
        // Базовый блок (header + кнопки + tabs)
        let headerVM = ActorHeaderCellViewModel(actorDetails: details, actorMovies: actorMovies)
        newSections.append(.init(type: .header, items: [.header(headerVM)]))
        newSections.append(.init(type: .socialStackButtons, items: []))
        newSections.append(.init(type: .actorSegmentedTabs, items: []))
        
        if index == 0 {
            // Filmography
            let moviesVM = actorMovies.map { ActorMovieCellViewModel(actorMovie: $0) }
            newSections.append(.init(type: .filmography, items: moviesVM.map { .filmography($0) }))
        } else {
            // Biography + Gallery
            let bioVM = ActorBiographyCellViewModel(actor: details)
            newSections.append(.init(type: .biography, items: [.biography(bioVM)]))
            
            // Gallery
            let galleryVM = actorImages.map { ActorImagesCellViewModel(actorImage: $0) }
            newSections.append(.init(type: .gallery, items: galleryVM.map { .gallery($0) }))
        }
        
        Task { @MainActor in
            self.sections = newSections
            self.view?.showActorSections(sections: newSections)
        }
        
    }
}

