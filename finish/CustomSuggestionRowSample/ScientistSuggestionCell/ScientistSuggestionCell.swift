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
import SnapKit
import SuggestionRow

final class ScientistSuggestionCell<T, TableViewCell: UITableViewCell>: SuggestionCellCustom<T, TableViewCell> where TableViewCell: EurekaSuggestionTableViewCell, TableViewCell.S == T {
    var originClearButtonMode: UITextField.ViewMode?
    var originTextAlignment: NSTextAlignment?
    var originFont: UIFont?
    var originTextColor: UIColor?
    
    override func setup() {
        super.setup()
        
        originClearButtonMode = textField.clearButtonMode
        originTextAlignment = textField.textAlignment
        originFont = textField.font
        originTextColor = textField.textColor
        
        suggestionViewYOffset = { [weak self] in
            guard let self = self else { return -8 }
            let errorHeight: CGFloat
            if let contentView = self.bsContentView as? ScientistSuggestionCellContentView {
                if contentView.errorContainer.isHidden == true {
                    errorHeight = 0
                } else {
                    errorHeight = contentView.errorContainer.systemLayoutSizeFitting(CGSize(width: self.bounds.width - 64, height: UIView.layoutFittingExpandedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
                }
            } else {
                errorHeight = 0
            }
            return -8 - errorHeight
        }
        suggestionTableViewCellHeight = { (indexPath) in
            return 46
        }
        
        if let contentView = bsContentView as? ScientistSuggestionCellContentView {
            contentView.roundedView.layer.borderColor = UIColor(red: 233.0/255.0, green: 234.0/255.0, blue: 242.0/255.0, alpha: 1).cgColor
        }
        
        tableViewContainer?.addObserver(self, forKeyPath: "hidden", options: .init(arrayLiteral: [.old, .new]), context: nil)
    }
    
    override func update() {
        super.update()
        if let unwrapped = originClearButtonMode {
            textField.clearButtonMode = unwrapped
        }
        if let unwrapped = originTextAlignment {
            textField.textAlignment = unwrapped
        }
        textField.font = originFont
        textField.textColor = originTextColor
        
        if let unwrapped = bsContentView as? ScientistSuggestionCellContentView {
            // 1
            unwrapped.errorContainer.isHidden = row.isValid
            
            // 2
            let errorMessages =
                row.validationErrors.map { error in
                    return error.msg
                }
                .joined(separator: "\n")
            
            // 3
            unwrapped.errorLabel.text = errorMessages
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let observedTableView = object as? UITableView, observedTableView == tableViewContainer,
              let contentView = bsContentView as? ScientistSuggestionCellContentView else { return }
              
        if let isHidden: Bool = change?[.newKey] as? Bool {
            if isHidden == true {
                contentView.separator.isHidden = true
                contentView.roundedView.isHidden = false
            } else {
                contentView.separator.isHidden = false
                contentView.roundedView.isHidden = true
            }
        }
    }
    
    deinit {
        tableViewContainer?.removeObserver(self, forKeyPath: "hidden")
    }
}

final class ScientistSuggestionRow<T: SuggestionValue>: _SuggestionRowCustom<ScientistSuggestionCell<T, SuggestionTableViewCellCustom<T>>>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        
        contentViewProvider = ViewProvider<SuggestionCellContentView>(nibName: "ScientistSuggestionCellContentView", bundle: Bundle.main)
        tableViewProvider = ViewProvider<SuggestionTableContainer>(nibName: "ScientistSuggestionTableContainer", bundle: Bundle.main)
        tableViewCellContentProvider = ViewProvider<SuggestionTableViewCellContentView>(nibName: "ScientistSuggestionTableViewCellContentView", bundle: Bundle.main)
    }
}
