//
//  ViewController.swift
//  CustomSuggestionRowSample
//
//  Created by Hien Pham on 4/13/20.
//  Copyright © 2020 Hien Pham. All rights reserved.
//

import UIKit
import Eureka
import SuggestionRow

class ViewController: FormViewController {
    private var contentInset: UIEdgeInsets = .zero

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        let users: [Scientist] = [Scientist(id: 1, firstName: "Albert", lastName: "Einstein"),
                             Scientist(id: 2, firstName: "Isaac", lastName: "Newton"),
                             Scientist(id: 3, firstName: "Galileo", lastName: "Galilei"),
                             Scientist(id: 4, firstName: "Marie", lastName: "Curie"),
                             Scientist(id: 5, firstName: "Louis", lastName: "Pasteur"),
                             Scientist(id: 6, firstName: "Michael", lastName: "Faraday"),
                             Scientist(id: 5, firstName: "Louis", lastName: "Pasteur"),
                             Scientist(id: 6, firstName: "Michael", lastName: "Faraday"),
                             Scientist(id: 7, firstName: "Michael", lastName: "Faraday"),
                             Scientist(id: 8, firstName: "Michael", lastName: "Faraday"),
                             Scientist(id: 9, firstName: "Michael", lastName: "Faraday"),
                             Scientist(id: 10, firstName: "Michael", lastName: "Faraday"),
                             Scientist(id: 11, firstName: "Michael", lastName: "Faraday"),
                             Scientist(id: 12, firstName: "Michael", lastName: "Faraday"),
                             Scientist(id: 13, firstName: "Michael", lastName: "Faraday"),
                             Scientist(id: 14, firstName: "Michael", lastName: "Faraday"),
                             Scientist(id: 15, firstName: "Michael", lastName: "Faraday")]

        let section = Section("Input suggestions")
        for _ in 0..<15 {
            section
            <<< ProfileSuggestionRow<Scientist>() {row in
                row.title = "学校名を検索"
                row.maxSuggestionRows = 4
                row.placeholder = "学校名を検索してください"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
                row.filterFunction = { text in
                    users.filter({ $0.firstName.lowercased().contains(text.lowercased()) })
                }
            }.cellSetup({ (cell, row) in
                cell.height = { UITableView.automaticDimension }
            })
            .onCellHighlightChanged({ (cell, row) in
                if cell.textField.isEditing == false {
                    row.validate()
                }
            })
            .onRowValidationChanged({ (cell, row) in
                UIView.performWithoutAnimation { [weak self] in
                    self?.tableView.performBatchUpdates({
                        row.updateCell()
                    }, completion: nil)
                }
            })
        }
        
        form +++ section
    }
    
    override func keyboardWillShow(_ notification: Notification) {
        super.keyboardWillShow(notification)
        
        // Handle suggestion cell
        guard let cell = tableView.findFirstResponder()?.formCell() as? BaseSuggestionTableCellType else { return }
        contentInset = tableView.contentInset
        cell.formContentInset = tableView.contentInset

        if let suggestTableView = cell.tableView {
            if suggestTableView.frame.maxY > tableView.contentSize.height && suggestTableView.isHidden == false {
                var contentInset = tableView.contentInset
                contentInset.bottom += (suggestTableView.frame.maxY - tableView.contentSize.height)
                tableView.contentInset = contentInset
            }
        }
    }
    
    override func keyboardWillHide(_ notification: Notification) {
        super.keyboardWillHide(notification)
        contentInset = .zero
        tableView.contentInset = .zero
    }
    
    override func textInputDidEndEditing<T>(_ textInput: UITextInput, cell: Cell<T>) where T : Equatable {
        super.textInputDidEndEditing(textInput, cell: cell)
        tableView.contentInset = contentInset
    }
    
    override func textInputDidBeginEditing<T>(_ textInput: UITextInput, cell: Cell<T>) where T : Equatable {
        super.textInputDidBeginEditing(textInput, cell: cell)
        if let suggestionCell = cell as? BaseSuggestionTableCellType {
            suggestionCell.formContentInset = contentInset
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let row = form.allSections[indexPath.section].allRows[indexPath.row]
        if row.baseCell is BaseSuggestionTableCellType {
            return nil
        }
        return super.tableView(tableView, willSelectRowAt: indexPath)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let beginDragging: Bool
        if
            let cell = tableView.findFirstResponder()?.formCell(),
            cell is BaseSuggestionTableCellType {
            beginDragging = false
        } else {
            beginDragging = true
        }
        
        if beginDragging == true {
            super.scrollViewWillBeginDragging(scrollView)
        }
    }
    
    override func inputAccessoryView(for row: BaseRow) -> UIView? {
        if row.baseCell is BaseSuggestionTableCellType {
            let navigation = NavigationAccessoryView(frame: .zero)
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            navigation.setItems([flexibleSpace, navigation.doneButton], animated: false)
            navigation.doneClosure = { [weak self] in
                self?.view.endEditing(true)
            }
            return navigation
        }
        return super.inputAccessoryView(for: row)
    }
}

struct Scientist: SuggestionValue {
    var id: Int
    var firstName: String
    var lastName: String


    var suggestionString: String {
        return "\(firstName) \(lastName)"
    }

    init(id: Int, firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
    }

    init?(string stringValue: String) {
        return nil
    }
}

func == (lhs: Scientist, rhs: Scientist) -> Bool {
    return lhs.id == rhs.id
}
