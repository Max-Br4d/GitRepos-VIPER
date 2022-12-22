//
//  Routerable.swift
//  GitRepos
//
//  Created by Max on 11/04/22.
//

import Foundation

protocol Routerable {
    var view: Viewable! { get }
    func pop(animated: Bool)
}

extension Routerable {
    func pop(animated: Bool) {
        view.pop(animated: animated)
    }
}
