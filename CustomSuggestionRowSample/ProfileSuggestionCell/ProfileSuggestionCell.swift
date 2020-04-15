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
        
        originClearButtonMode = textField.clearButtonMode
        originTextAlignment = textField.textAlignment
        originFont = textField.font
        originTextColor = textField.textColor
        
        suggestionViewYOffset = { [weak self] in
            guard let self = self else { return -8 }
            let errorHeight: CGFloat
            if let contentView = self.bsContentView as? ProfileSuggestionCellContentView {
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
        
        if let unwrapped = bsContentView as? ProfileSuggestionCellContentView {
            unwrapped.errorContainer.isHidden = row.isValid
        }
    }
}

final class ProfileSuggestionRow<T: SuggestionValue>: _SuggestionRowCustom<ProfileSuggestionCell<T, SuggestionTableViewCellCustom<T>>>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        
        contentViewProvider = ViewProvider<SuggestionCellContentView>(nibName: "ProfileSuggestionCellContentView", bundle: Bundle.main)
        tableViewProvider = ViewProvider<SuggestionTableContainer>(nibName: "ProfileSuggestionTableContainer", bundle: Bundle.main)
        tableViewCellContentProvider = ViewProvider<SuggestionTableViewCellContentView>(nibName: "ProfileSuggestionTableViewCellContentView", bundle: Bundle.main)
    }
}
