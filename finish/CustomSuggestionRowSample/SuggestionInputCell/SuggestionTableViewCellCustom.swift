//
//  SuggestionTableViewCellCustom.swift
//  SuggestionRowExemple
//
//  Created by Hien Pham on 1/19/20.
//  Copyright © 2020 Hien Pham. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import SuggestionRow

protocol SuggestionHasCustomTableViewCell: AnyObject {
    var tableViewCellContentProvider: ViewProvider<SuggestionTableViewCellContentView>? { get set }
}

class SuggestionTableViewCellContentView: UIView {
    @IBOutlet weak var textLabel: UILabel?
}

open class SuggestionTableViewCellCustom<T: SuggestionValue>: SuggestionTableViewCell<T> {
    var bsContentView: SuggestionTableViewCellContentView?
    open override func setUp() {
        guard let row = parentCell?.baseRow as? SuggestionHasCustomTableViewCell else { return }
        bsContentView = row.tableViewCellContentProvider?.makeView()
        if let unwrapped = bsContentView {
            contentView.addSubview(unwrapped)
            unwrapped.translatesAutoresizingMaskIntoConstraints = false
            unwrapped.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            unwrapped.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            unwrapped.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
            unwrapped.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
            textLabel?.removeFromSuperview()
        }
    }
    
    open override func setupForValue(_ value: T) {
        textLabel?.text = value.suggestionString
        textLabel?.isHidden = (bsContentView?.textLabel != nil)
        bsContentView?.textLabel?.text = value.suggestionString
    }
}
