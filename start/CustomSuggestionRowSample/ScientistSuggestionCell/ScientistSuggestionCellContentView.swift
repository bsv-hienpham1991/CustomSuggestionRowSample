//
//  ScientistSuggestionCellContentView.swift
//  CustomSuggestionRowSample
//
//  Created by Hien Pham on 4/13/20.
//  Copyright © 2020 Hien Pham. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import SuggestionRow

class ScientistSuggestionCellContentView: SuggestionCellContentView {
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var requiredView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var errorContainer: UIView!
    @IBOutlet weak var errorLabel: UILabel!
}
