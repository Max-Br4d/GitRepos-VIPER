//
//  DetailRouterInput.swift
//  GitRepos
//
//  Created by Max on 11/04/22.
//

import Foundation

struct DetailRouterInput {

    private func view(entryEntity: DetailEntryEntity) -> DetailViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let dependencies = DetailPresenterDependencies(interactor: interactor, router: DetailRouterOutput(view))
        let presenter = DetailPresenter(entities: DetailEntities(entryEntity: entryEntity), view: view, dependencies: dependencies)
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }

    func push(from: Viewable, entryEntity: DetailEntryEntity) {
        let view = self.view(entryEntity: entryEntity)
        from.push(view, animated: true)
    }

}

final class DetailRouterOutput: Routerable {

    private(set) weak var view: Viewable!

    init(_ view: Viewable) {
        self.view = view
    }

}
