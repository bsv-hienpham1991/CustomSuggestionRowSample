//
//  ProfileSuggestionTableContainer.swift
//  CustomSuggestionRowSample
//
//  Created by Hien Pham on 4/15/20.
//  Copyright © 2020 Hien Pham. All rights reserved.
//

import Foundation
import UIKit

class ScientistSuggestionTableContainer: SuggestionTableContainer {
    @IBOutlet weak var container: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        container.layer.borderColor = UIColor(red: 125.0/255.0, green: 95.0/255.0, blue: 235.0/255.0, alpha: 1).cgColor
    }
}
