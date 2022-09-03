//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Marcio Abrantes on 02/09/22.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    return AccountModel(id: "any_id", name: "any_name", email: "any_email@email.com", password: "äny_password")
}
