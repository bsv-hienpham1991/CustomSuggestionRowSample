//
//  ProfileSuggestionCellContentView.swift
//  CustomSuggestionRowSample
//
//  Created by Hien Pham on 4/13/20.
//  Copyright © 2020 Hien Pham. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import SuggestionRow

class ProfileSuggestionCellContentView: SuggestionCellContentView {
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var requiredView: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var errorContainer: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    private weak var tableViewContainer: UIView?
    override func setUp<T, TableViewCell: UITableViewCell>(cell: SuggestionCellCustom<T, TableViewCell>) where TableViewCell: EurekaSuggestionTableViewCell, TableViewCell.S == T {
        super.setUp(cell: cell)
        roundedView.layer.borderColor = UIColor(red: 233.0/255.0, green: 234.0/255.0, blue: 242.0/255.0, alpha: 1).cgColor
        tableViewContainer = cell.tableViewContainer
        if let tableViewContainer = tableViewContainer {
            tableViewContainer.addObserver(self, forKeyPath: "hidden", options: .init(arrayLiteral: [.old, .new]), context: nil)
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let isHidden: Bool = change?[.newKey] as? Bool {
            if isHidden == true {
                separator.isHidden = true
                roundedView.isHidden = false
            } else {
                separator.isHidden = false
                roundedView.isHidden = true
            }
        }
    }
    
    deinit {
        if let tableViewContainer = tableViewContainer {
            tableViewContainer.removeObserver(self, forKeyPath: "hidden")
        }
    }
}
