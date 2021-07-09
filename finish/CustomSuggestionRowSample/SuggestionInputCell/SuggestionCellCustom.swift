//
//  SuggestionCellCustom.swift
//  SuggestionRowExemple
//
//  Created by Hien Pham on 1/19/20.
//  Copyright © 2020 Hien Pham. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import SuggestionRow

protocol SuggestionHasCustomContentView: AnyObject {
    var contentViewProvider: ViewProvider<SuggestionCellContentView>? { get set }
}

class SuggestionCellContentView: UIView {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var textField: UITextField!
}

open class SuggestionCellCustom<T, TableViewCell: UITableViewCell>: SuggestionTableCell<T, TableViewCell> where TableViewCell: EurekaSuggestionTableViewCell, TableViewCell.S == T {
    var customContentView: SuggestionCellContentView?
    var tableContainer: SuggestionTableContainer?
    
    fileprivate var suggsetionRowCustom: SuggestionHasCustomContentView? { return row as? SuggestionHasCustomContentView }

    open override func setup() {
        customContentView = suggsetionRowCustom?.contentViewProvider?.makeView()
        if let unwrapped = customContentView {
            contentView.addSubview(unwrapped)
            unwrapped.translatesAutoresizingMaskIntoConstraints = false
            unwrapped.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            unwrapped.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            unwrapped.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
            unwrapped.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        }
                
        if customContentView != nil {
            textField.removeFromSuperview()
            textField = customContentView?.textField
        }
        
        tableContainer = (row as? SuggestionHasCustomTableView)?.tableViewProvider?.makeView()
        if let unwrapped = tableContainer {
            tableView = unwrapped.tableView
            tableViewContainer = unwrapped
        }
                        
        super.setup()
    }
    
    open override func customConstraints() {
        
    }
    
    open override func update() {
        super.update()
        titleLabel?.isHidden = true
        customContentView?.titleLabel?.text = row.title
    }
}
