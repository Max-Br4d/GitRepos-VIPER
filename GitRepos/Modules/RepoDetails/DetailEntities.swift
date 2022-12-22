//
//  DetailEntities.swift
//  GitRepos
//
//  Created by Max on 11/04/22.
//

import Foundation
struct DetailEntryEntity {
    let gitHubRepository: GitHubRepository
    init(gitHubRepository: GitHubRepository) {
        self.gitHubRepository = gitHubRepository
    }
}

struct DetailEntities {
    let entryEntity: DetailEntryEntity

    init(entryEntity: DetailEntryEntity) {
        self.entryEntity = entryEntity
    }
}
