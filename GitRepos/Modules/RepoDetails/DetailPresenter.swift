//
//  DetailPresenter.swift
//  GitRepos
//
//  Created by Max on 11/04/22.
//

import Foundation
import WebKit

typealias DetailPresenterDependencies = (
    interactor: DetailInteractor,
    router: DetailRouterOutput
)

final class DetailPresenter: Presenterable {

    internal var entities: DetailEntities
    private weak var view: DetailViewInputs!
    let dependencies: DetailPresenterDependencies

    init(entities: DetailEntities,
         view: DetailViewInputs,
         dependencies: DetailPresenterDependencies)
    {
        self.view = view
        self.entities = entities
        self.dependencies = dependencies
    }

}

extension DetailPresenter: DetailViewOutputs {

    func viewDidLoad() {
        view.requestWebView(with: URLRequest(url: URL(string: entities.entryEntity.gitHubRepository.url)!))
        view.indicatorView(animate: true)
        view.configure(entities: entities)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        view.indicatorView(animate: false)
    }
}

extension DetailPresenter: DetailInteractorOutputs {}
