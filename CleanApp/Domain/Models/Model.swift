//
//  Model.swift
//  Domain
//
//  Created by Marcio Abrantes on 31/08/22.
//

import Foundation

public protocol Model: Encodable { }

public extension Model {
    func toData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
