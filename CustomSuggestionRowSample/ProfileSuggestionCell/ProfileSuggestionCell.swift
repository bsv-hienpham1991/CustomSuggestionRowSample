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

final class ProfileSuggestionCell<T, TableViewCell: UITableViewCell>: SuggestionCellCustom<T, TableViewCell> where TableViewCell: EurekaSuggestionTableViewCell, TableViewCell.S == T {
    var originClearButtonMode: UITextField.ViewMode?
    var originTextAlignment: NSTextAlignment?
    var originFont: UIFont?
    var originTextColor: UIColor?
    
    override func setup() {
        super.setup()
        
        bsTableContainer?.tableView?.superview?.layer.borderColor = UIColor(red: 125.0/255.0, green: 95.0/255.0, blue: 235.0/255.0, alpha: 1).cgColor
                
        originClearButtonMode = textField.clearButtonMode
        originTextAlignment = textField.textAlignment
        originFont = textField.font
        originTextColor = textField.textColor
        
        suggestionViewYOffset = { [weak self] in
            guard let unwrapped = self else { return -8 }
            let errorHeight: CGFloat
            if let contentView = unwrapped.bsContentView as? ProfileSuggestionCellContentView {
                if contentView.errorContainer.isHidden == true {
                    errorHeight = 0
                } else {
                    errorHeight = contentView.errorContainer.systemLayoutSizeFitting(CGSize(width: unwrapped.bounds.width, height: UIView.layoutFittingExpandedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height 
                }
            } else {
                errorHeight = 0
            }
            return -8 - errorHeight
        }
        suggestionTableViewCellHeight = { _ in
            return 46
        }
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
                
        if let selectedValue = row.value, let options = (row as? RowWithOptions)?.rowOptions as? [T], let index = options.firstIndex(of: selectedValue) {
            tableView?.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .none)
        }
        
        if row.isDisabled {
            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)])
            if let unwrapped = bsContentView as? ProfileSuggestionCellContentView {
                unwrapped.roundedView.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9490196078, alpha: 1)
                unwrapped.searchButton.isEnabled = false
            }
        } else {
            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5725490196, green: 0.5921568627, blue: 0.7882352941, alpha: 1)])
            if let unwrapped = bsContentView as? ProfileSuggestionCellContentView {
                unwrapped.roundedView.backgroundColor = .white
                unwrapped.searchButton.isEnabled = true
            }
        }
        
        if let unwrapped = bsContentView as? ProfileSuggestionCellContentView {
            unwrapped.errorContainer.isHidden = row.isValid
        }
        
        if let value = row.value {
            textField.text = row.displayValueFor?(value)
        }
    }
}

final class ProfileSuggestionRow<T: SuggestionValue>: _SuggestionRowCustom<ProfileSuggestionCell<T, SuggestionTableViewCellCustom<T>>>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        
        contentViewProvider = ViewProvider<SuggestionCellContentView>(nibName: "ProfileSuggestionCellCustom", bundle: Bundle.main)
        tableViewProvider = ViewProvider<SuggestionTableContainer>(nibName: "ProfileSuggestionTableContainer", bundle: Bundle.main)
        tableViewCellContentProvider = ViewProvider<SuggestionTableViewCellContentView>(nibName: "ProfileSuggestionTableViewCellContentView", bundle: Bundle.main)
    }
}
