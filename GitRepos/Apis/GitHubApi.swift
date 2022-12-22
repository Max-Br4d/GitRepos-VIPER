//
//  GitHubApi.swift
//  GitRepos
//
//  Created by Max on 11/04/22.
//

import Foundation


protocol GitHubApiType {
    func search(with request: SearchLanguageRequest, completion:@escaping((Result<SearchRepositoriesResponse, ApiError>) -> Void))

//    func search(with request: SearchLanguageRequest, onSuccess: @escaping (SearchRepositoriesResponse) -> Void, onError: @escaping (Error) -> Void)
}

struct SearchLanguageRequest: Request {
    private let baseUrl = "https://api.github.com"

    var url: String {
        return baseUrl + "/search/repositories"
    }
    let language: String
    let page: Int
    
    func params() -> [(key: String, value: String)] {
        return [
            (key: "q", value: language),
            (key: "sort", value : "stars"),
            (key: "page", value : "\(page)")
        ]
    }
}

struct GitHubApi: GitHubApiType {
  
    func search(with request: SearchLanguageRequest, completion: @escaping((Result<SearchRepositoriesResponse, ApiError>) -> Void)) {
       
        ApiTask().request(.get, request: request) { (data, session) in
            do {
                let response = try self.parse(data)
                completion(.success(response))
            } catch {
                completion(.failure(ApiError.failedParse))
            }
        } onError: { error in
            completion(.failure(ApiError.recieveNilResponse))
        }
    }
    
    
//    func search(with request: SearchLanguageRequest, onSuccess: @escaping (SearchRepositoriesResponse) -> Void, onError: @escaping (Error) -> Void) {
//        ApiTask().request(.get, request: request, onSuccess: { (data, session) in
//            do {
//                let response = try self.parse(data)
//                onSuccess(response)
//            } catch {
//                onError(ApiError.failedParse)
//            }
//        }, onError: onError)
//    }
    
    private func parse(_ data: Data) throws -> SearchRepositoriesResponse {
        let response: SearchRepositoriesResponse = try JSONDecoder().decode(SearchRepositoriesResponse.self, from: data)
        return response
    }
}
