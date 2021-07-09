//
//  Scientist.swift
//  CustomSuggestionRowSample
//
//  Created by Hien Pham on 7/5/21.
//  Copyright © 2021 Hien Pham. All rights reserved.
//

import Foundation
import SuggestionRow

struct Scientist {
    var id: Int
    var firstName: String
    var lastName: String

    init(id: Int, firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
    }
}
