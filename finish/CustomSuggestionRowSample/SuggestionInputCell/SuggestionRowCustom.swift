//
//  SuggestionInputCellCustom.swift
//  SuggestionRowExemple
//
//  Created by Hien Pham on 1/19/20.
//  Copyright © 2020 Hien Pham. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import SnapKit
import SuggestionRow

open class _SuggestionRowCustom<Cell: CellType> : _SuggestionRow<Cell>,
    SuggestionHasCustomContentView,
    SuggestionHasCustomTableView,
    SuggestionHasCustomTableViewCell,
NoValueDisplayTextConformance where Cell: BaseCell, Cell: TextFieldCell, Cell.Value: SuggestionValue {
    open var noValueDisplayText: String? = nil
    var contentViewProvider: ViewProvider<SuggestionCellContentView>?
    var tableViewProvider: ViewProvider<SuggestionTableContainer>?
    var tableViewCellContentProvider: ViewProvider<SuggestionTableViewCellContentView>?
    
    required public init(tag: String?) {
        super.init(tag: tag)
    }
}

public final class SuggestionRowCustom<T: SuggestionValue>: _SuggestionRowCustom<SuggestionCellCustom<T, SuggestionTableViewCellCustom<T>>>, RowType {

    required public init(tag: String?) {
        super.init(tag: tag)
    }
}

