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
    
    init(view: ActorPageViewProtocol,
         actorRepository: ActorRepositoryProtocol,
         movieCreditsRepository: MovieCreditsRepositoryProtocol,
         actorId: Int,
         actorTitle: String)
    
}

class ActorPagePresenter: ActorPagePresenterProtocol {
    
    private weak var view: ActorPageViewProtocol?
    private let actorRepository: ActorRepositoryProtocol
    private let movieCreditsRepository: MovieCreditsRepositoryProtocol
    
    private var sections: [ActorPageCollectionSection] = []
    private let actorTitle: String
    private var actorId: Int
    
    required init(view: ActorPageViewProtocol,
                  actorRepository: ActorRepositoryProtocol,
                  movieCreditsRepository: MovieCreditsRepositoryProtocol,
                  actorId: Int,
                  actorTitle: String) {
        
        self.view = view
        self.actorTitle = actorTitle
        self.actorRepository = actorRepository
        self.movieCreditsRepository = movieCreditsRepository
        self.actorId = actorId
    }
    
    func viewDidLoad() {

        let actorDetails = ActorDetails.mockActor(id: actorId)
        let actorMovies = ActorMovie.mockActorMovies()
        
        // Header
        let headerVM = ActorHeaderCellViewModel(actorDetails: actorDetails, actorMovies: actorMovies)
        let headerSection = ActorPageCollectionSection(type: .header,items: [.header(headerVM)])
        
        // SocialStackButtons
        let socialStackButtons = ActorPageCollectionSection(type: .socialStackButtons, items: [])
        
        // SegmentedTabs
        let actorSegmentedTabs = ActorPageCollectionSection(type: .actorSegmentedTabs, items: [])
    
        let sections: [ActorPageCollectionSection] = [headerSection, socialStackButtons, actorSegmentedTabs]
        
        self.sections = sections
        view?.showActorSections(sections: sections)
        view?.setTitle(actorTitle)
    }
    
    func didActorSelectTab(index: Int) {
        
        let actorDetails = ActorDetails.mockActor(id: actorId)
        let actorMovies = ActorMovie.mockActorMovies()
        
        var newSections: [ActorPageCollectionSection] = []
        
        // оставляем header + buttons + tabs
        let headerVM = ActorHeaderCellViewModel(actorDetails: actorDetails, actorMovies: actorMovies)
        newSections.append(.init(type: .header, items: [.header(headerVM)]))
        newSections.append(.init(type: .socialStackButtons, items: []))
        newSections.append(.init(type: .actorSegmentedTabs, items: []))
        
        if index == 0 { // Filmography
            let moviesVM = actorMovies.map { ActorMovieCellViewModel(actorMovie: $0) }
            newSections.append(.init(type: .filmography, items: moviesVM.map { .filmography($0) }))
        } else { // Biography
            let bioVM = ActorBiographyCellViewModel(actor: actorDetails)
            newSections.append(.init(type: .biography, items: [.biography(bioVM)]))
        }
        
        self.sections = newSections
        view?.showActorSections(sections: newSections)
        view?.setSelectedTabIndex(index)
    }
    
}
    

