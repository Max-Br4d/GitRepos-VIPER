//
//  DetailInteractor.swift
//  GitRepos
//
//  Created by Max on 11/04/22.
//

import Foundation
protocol DetailInteractorOutputs: AnyObject {

}

final class DetailInteractor: Interactorable {
    weak var presenter: DetailInteractorOutputs?
}
