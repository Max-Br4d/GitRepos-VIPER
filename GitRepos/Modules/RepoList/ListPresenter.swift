//
//  ListPresenter.swift
//  GitRepos
//
//  Created by Max on 11/04/22.
//

import Foundation

typealias ListPresenterDependencies = (
    interactor: ListInteractor,
    router: ListRouterOutput
)

final class ListPresenter: Presenterable {

    var entities: ListEntities
    private weak var view: ListViewInputs!
    let dependencies: ListPresenterDependencies

    init(entities: ListEntities,
         view: ListViewInputs,
         dependencies: ListPresenterDependencies)
    {
        self.view = view
        self.entities = entities
        self.dependencies = dependencies
    }

}

extension ListPresenter: ListViewOutputs {
    func viewDidLoad() {
        view.configure(entities: entities)
        entities.searchApiState.isFetching = true
        let request = SearchLanguageRequest(language: entities.entryEntity.language, page: entities.searchApiState.pageCount)
        dependencies.interactor.fetchSearch(request: request , language: entities.entryEntity.language, page: entities.searchApiState.pageCount)
    }

    func onReachBottom() {
        guard !entities.searchApiState.isFetching else { return }
        entities.searchApiState.isFetching = true
        
        let request = SearchLanguageRequest(language: entities.entryEntity.language, page: entities.searchApiState.pageCount)

        dependencies.interactor.fetchSearch(request: request, language: entities.entryEntity.language, page: entities.searchApiState.pageCount)
        view.indicatorView(animate: true)
    }
}

extension ListPresenter: ListInteractorOutputs {
    func onSuccessSearch(res: SearchRepositoriesResponse) {
        entities.searchApiState.isFetching = false
        entities.searchApiState.pageCount += 1
        entities.gitHubRepositories += res.items
        view.reloadTableView(tableViewDataSource: ListTableViewDataSource(entities: entities, presenter: self))
        view.indicatorView(animate: false)
    }

    func onErrorSearch(error: Error) {
        view.indicatorView(animate: false)
    }
}

extension ListPresenter: ListTableViewDataSourceOutputs {
    func didSelect(_ gitHubRepository: GitHubRepository) {
        dependencies.router.transitionDetail(gitHubRepository: gitHubRepository)
    }
}
