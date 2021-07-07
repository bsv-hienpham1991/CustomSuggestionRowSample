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
    
    let users: [Scientist] = [Scientist(id: 1, firstName: "Albert", lastName: "Einstein"),
                         Scientist(id: 2, firstName: "Isaac", lastName: "Newton"),
                         Scientist(id: 3, firstName: "Galileo", lastName: "Galilei"),
                         Scientist(id: 4, firstName: "Marie", lastName: "Curie"),
                         Scientist(id: 5, firstName: "Louis", lastName: "Pasteur"),
                         Scientist(id: 6, firstName: "Michael", lastName: "Faraday"),
                         Scientist(id: 5, firstName: "Louis", lastName: "Pasteur"),
                         Scientist(id: 6, firstName: "Marie", lastName: "Curie"),
                         Scientist(id: 7, firstName: "Thomas", lastName: "Edison"),
                         Scientist(id: 8, firstName: "Stephen", lastName: "Hawking"),
                         Scientist(id: 9, firstName: "Alan", lastName: "Turing"),
                         Scientist(id: 10, firstName: "Leonardo da", lastName: "Vinci"),
                         Scientist(id: 11, firstName: "Nikolas", lastName: "Tesla"),
                         Scientist(id: 12, firstName: "Ada", lastName: "Lovelace"),
                         Scientist(id: 13, firstName: "Richard", lastName: "Feyman"),
                         Scientist(id: 14, firstName: "Benjamin", lastName: "Franklin"),
                         Scientist(id: 15, firstName: "James", lastName: "D. Watson")]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
        let section = Section("Input suggestions")
        for _ in 0..<15 {
            section
            <<< ScientistSuggestionRow<Scientist>() {row in
                row.title = "Scientist"
                row.maxSuggestionRows = 4
                row.placeholder = "Please search the scientist name"
                row.add(rule: RuleRequired())
                row.asyncFilterFunction = {[weak self] (text, completion) in
                    guard let self = self else {
                        completion([])
                        return
                    }
                    completion(self.users.filter({ $0.firstName.lowercased().contains(text.lowercased()) }))
                }
            }.cellSetup({ (cell, row) in
                cell.height = { UITableView.automaticDimension }
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
