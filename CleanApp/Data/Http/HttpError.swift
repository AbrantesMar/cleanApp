//
//  HttpError.swift
//  Data
//
//  Created by Marcio Abrantes on 31/08/22.
//

import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}
