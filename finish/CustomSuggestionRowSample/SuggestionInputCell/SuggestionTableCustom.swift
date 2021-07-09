//
//  SuggestionTableCustom.swift
//  SuggestionRowExemple
//
//  Created by Hien Pham on 1/19/20.
//  Copyright © 2020 Hien Pham. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import SuggestionRow

protocol SuggestionHasCustomTableView: AnyObject {
    var tableViewProvider: ViewProvider<SuggestionTableContainer>? { get set }
}

class SuggestionTableContainer: UIView {
    @IBOutlet weak var tableView: UITableView?
}
