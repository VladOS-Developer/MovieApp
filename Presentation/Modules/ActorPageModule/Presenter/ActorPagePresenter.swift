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
         imageLoader: ImageLoaderProtocol,
         actorRepository: ActorRepositoryProtocol,
         movieCreditsRepository: MovieCreditsRepositoryProtocol,
         actorId: Int,
         actorTitle: String)
}

class ActorPagePresenter: ActorPagePresenterProtocol {
    
    private weak var view: ActorPageViewProtocol?
    private let router: ActorPageRouterProtocol
    private let imageLoader: ImageLoaderProtocol
    
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
                  imageLoader: ImageLoaderProtocol,
                  actorRepository: ActorRepositoryProtocol,
                  movieCreditsRepository: MovieCreditsRepositoryProtocol,
                  actorId: Int,
                  actorTitle: String) {
        
        self.view = view
        self.router = router
        self.imageLoader = imageLoader
        self.actorTitle = actorTitle
        self.actorRepository = actorRepository
        self.movieCreditsRepository = movieCreditsRepository
        self.actorId = actorId
        
    }
    
    func viewDidLoad() {
        Task {
            do {
                // Загружаем всё параллельно
                async let detailsTask = actorRepository.fetchActorDetails(by: actorId)
                async let moviesTask  = actorRepository.fetchActorMovies(by: actorId)
                async let imagesTask  = actorRepository.fetchActorImages(by: actorId)
                
                let (details, movies, images) = try await (detailsTask, moviesTask, imagesTask)
                
                self.actorDetails = details
                self.actorMovies = movies
                self.actorImages = images
                
                // Подгружаем изображения
                let headerVM = await buildHeaderVM(details: details, movies: movies)
                let movieVMs  = await buildMovieVM(movies: movies)
                let galleryVMs = await buildGalleryVM(images: images)
                
                let sections = buildSections(headerVM: headerVM,
                                             moviesVM: movieVMs,
                                             galleryVMs: galleryVMs,
                                             tabIndex: 0)
                
                await MainActor.run {
                    self.sections = sections
                    self.view?.setTitle(self.actorTitle)
                    self.view?.showActorSections(sections: sections)
                }
                
            } catch {
                print("Ошибка загрузки данных актёра: \(error)")
            }
        }
    }
    
    private func buildHeaderVM(details: ActorDetails, movies: [ActorMovie]) async -> ActorHeaderCellViewModel {
        var avtorHeaderVM = ActorHeaderCellViewModel(actorDetails: details, actorMovies: movies)
        
        if let url = avtorHeaderVM.profileURL {
            avtorHeaderVM.profileImage = await imageLoader.loadImage(from: url, localName: nil, isLocal: false)
        }
        return avtorHeaderVM
    }
    
    private func buildMovieVM(movies: [ActorMovie]) async -> [ActorMovieCellViewModel] {
        await withTaskGroup(of: ActorMovieCellViewModel.self) { group in
            for movie in movies {
                group.addTask { [imageLoader] in
                    var actorMovieVM = ActorMovieCellViewModel(actorMovie: movie)
                    if let url = actorMovieVM.posterURL {
                        actorMovieVM.posterImage = await imageLoader.loadImage(from: url, localName: nil, isLocal: false)
                    }
                    return actorMovieVM
                }
            }
            return await group.reduce(into: [ActorMovieCellViewModel](), { $0.append($1) })
        }
    }
    
    private func buildGalleryVM(images: [ActorImages]) async -> [ActorImagesCellViewModel] {
        await withTaskGroup(of: ActorImagesCellViewModel.self) { group in
            for image in images {
                group.addTask { [imageLoader] in
                    var actorImagesVM = ActorImagesCellViewModel(actorImage: image)
                    if let url = actorImagesVM.imageURL {
                        actorImagesVM.image = await imageLoader.loadImage(from: url, localName: nil, isLocal: false)
                    }
                    return actorImagesVM
                }
            }
            return await group.reduce(into: [ActorImagesCellViewModel](), { $0.append($1) })
        }
    }
    
    private func buildSections(headerVM: ActorHeaderCellViewModel,
                               moviesVM: [ActorMovieCellViewModel],
                               galleryVMs: [ActorImagesCellViewModel],
                               tabIndex: Int) -> [ActorPageCollectionSection] {
        
        var sections: [ActorPageCollectionSection] = [
            .init(type: .header, items: [.header(headerVM)]),
            .init(type: .socialStackButtons, items: []),
            .init(type: .actorSegmentedTabs, items: [])
        ]
        
        if tabIndex == 0 {
            sections.append(.init(type: .filmography, items: moviesVM.map { .filmography($0) }))
        } else {
            if let details = actorDetails {
                let bioVM = ActorBiographyCellViewModel(actor: details)
                sections.append(.init(type: .biography, items: [.biography(bioVM)]))
            }
            sections.append(.init(type: .gallery, items: galleryVMs.map { .gallery($0) }))
        }
        
        return sections
    }
    
    func didActorSelectTab(index: Int) {
        guard let details = actorDetails else { return }
        
        Task {
            let headerVM = await buildHeaderVM(details: details, movies: actorMovies)
            let movieVM = await buildMovieVM(movies: actorMovies)
            let galleryVM = await buildGalleryVM(images: actorImages)
            
            let newSections = buildSections(headerVM: headerVM,
                                            moviesVM: movieVM,
                                            galleryVMs: galleryVM,
                                            tabIndex: index)
            
            await MainActor.run {
                self.sections = newSections
                self.view?.showActorSections(sections: newSections)
            }
        }
    }
    
    func didSelectFilmographyMovie(_ movie: ActorMovieCellViewModel) {
        router.openMoviePage(movieId: movie.id, movieTitle: movie.title)
    }
}

