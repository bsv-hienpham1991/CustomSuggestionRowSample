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

extension Scientist: SuggestionValue {
    // 1
    init?(string stringValue: String) {
        return nil
    }

    // 2
    var suggestionString: String {
        return "\(firstName) \(lastName)"
    }

    // 3
    static func == (lhs: Scientist, rhs: Scientist) -> Bool {
        return lhs.id == rhs.id
    }
}
