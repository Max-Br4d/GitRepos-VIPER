//
//  ListInteractor.swift
//  GitRepos
//
//  Created by Max on 11/04/22.
//

import Foundation

protocol ListInteractorOutputs: AnyObject {
    func onSuccessSearch(res: SearchRepositoriesResponse)
    func onErrorSearch(error: Error)
}

final class ListInteractor: Interactorable {

    weak var presenter: ListInteractorOutputs?
    private var gitHubApi: GitHubApiType
    init(gitHubApi: GitHubApiType) {
        self.gitHubApi = gitHubApi
    }
    
    func fetchSearch(request:SearchLanguageRequest, language: String, page: Int) {
        gitHubApi.search(with: request) {[weak self] result in
            switch result {
            case .success(let res):
                self?.presenter?.onSuccessSearch(res: res)
            case .failure(let error):
                self?.presenter?.onErrorSearch(error: error)
            }
        }
    }
}
