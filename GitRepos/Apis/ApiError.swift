//
//  ApiError.swift
//  GitRepos
//
//  Created by Max on 11/04/22.
//

import Foundation

enum ApiError: Int, Error {
    case recieveNilResponse = 0,
    recieveErrorHttpStatus,
    recieveNilBody,
    failedParse
}
