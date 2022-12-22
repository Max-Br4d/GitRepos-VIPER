//
//  Collection.swift
//  GitRepos
//
//  Created by Max on 11/04/22.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
