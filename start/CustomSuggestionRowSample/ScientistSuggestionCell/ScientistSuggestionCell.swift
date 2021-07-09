//
//  ProfileSuggestionCell.swift
//  koremana
//
//  Created by Hien Pham on 1/19/20.
//  Copyright © 2020 Bravesoft. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import SuggestionRow

final class ScientistSuggestionCell<T, TableViewCell: UITableViewCell>: SuggestionCellCustom<T, TableViewCell> where TableViewCell: EurekaSuggestionTableViewCell, TableViewCell.S == T {
}

final class ScientistSuggestionRow<T: SuggestionValue>: _SuggestionRowCustom<ScientistSuggestionCell<T, SuggestionTableViewCellCustom<T>>>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
}
