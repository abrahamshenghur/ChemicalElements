//
//  ElementsViewController.swift
//  ChemicalElements
//
//  Created by John on 9/17/19.
//  Copyright © 2019 Abraham Shenghur. All rights reserved.
//


import UIKit

enum Segue: String {
    case ViewCell = "Webpage"
    case ModalPopup = "ElementSummaryPopup"
}

class ElementsViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var elements = [Element]()

    let cellIdentifier = "ViewCell"
    
    var isSidebarButtonPressed: Bool = false
    
    var loadedPeriodNumbersArray = [Int]()
    var loadedCategoryNamesArray = [String]()

    var filteredRowCount = 0
    var filteredElementsArray = [Element]()
    
    var rowCount: Int {
        get {
            return elements.count
        }
        set {
            filteredRowCount = newValue
        }
    }
    
    let navBarTitles = [
        "Chemical Elements", "Period 1", "Period 2", "Period 3", "Period 4", "Period 5", "Period 6", "Period 7", "Nonmetals", "Alkali Metals", "Alkaline Earth Metals", "Metalloids", "Halogens", "Noble Gases", "Transition Metals", "Post-transition Metals", "Lanthanides", "Actinides"
    ]
    
    let categoryNames = [
        8: "nonmetal", 9: "alkali metal", 10: "alkaline earth metal", 11: "metalloid", 12: "halogen", 13: "noble gas", 14: "transition metal", 15: "post-transition metal", 16: "lanthanide", 17: "actinide"
    ]
    
    
    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!

    @IBAction func sortSidebarButton(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: .toggleSidebar, object: nil)
    }

    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Chemical Elements"
        
        loadJSON()
  
        for element in elements {
            loadedPeriodNumbersArray.append(element.period)
            loadedCategoryNamesArray.append(element.category)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(sidebarButtonTapped), name: .periodSelectedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(categoryButtonTapped), name: .categoryNotification, object: nil)
    }
    
    
    // MARK: - Methods
    
    @objc private func sidebarButtonTapped(_ notification: Notification) {
        var currentlySelectedSidebarButtonTag = 0
        var selectedPeriodNumbersArray = [Int]()
        
        if let tagFromSidebarButtonNotification = notification.object as? Int {
            isSidebarButtonPressed = true
            
            currentlySelectedSidebarButtonTag = tagFromSidebarButtonNotification
            
            if currentlySelectedSidebarButtonTag >= 1 && currentlySelectedSidebarButtonTag <= 7 {
                selectedPeriodNumbersArray = loadedPeriodNumbersArray.filter { $0 == currentlySelectedSidebarButtonTag }
                filteredRowCount = selectedPeriodNumbersArray.count
                filteredElementsArray = elements.filter { $0.period == currentlySelectedSidebarButtonTag }
            } else {
                isSidebarButtonPressed = false
            }
            
            for buttonTag in [currentlySelectedSidebarButtonTag] {
                navigationItem.title = navBarTitles[buttonTag]
            }
            
            tableView.reloadSections([0], with: .automatic)
            if tableView.numberOfRows(inSection: 0) != 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }
    
    @objc private func categoryButtonTapped(_ notification: Notification) {
        
        var currentlySelectedSidebarButtonTag = 0
        var selectedCategoryNamesArray = [String]()
        
        if let tagFromSidebarButtonNotification = notification.object as? Int {
            isSidebarButtonPressed = true
            
            currentlySelectedSidebarButtonTag = tagFromSidebarButtonNotification
            
            if currentlySelectedSidebarButtonTag >= 8 && currentlySelectedSidebarButtonTag <= 17 {
                for (tag, categoryName) in categoryNames {
                    if tag == currentlySelectedSidebarButtonTag {
                        selectedCategoryNamesArray = loadedCategoryNamesArray.filter { $0 == categoryName }
                        filteredRowCount = selectedCategoryNamesArray.count
                        filteredElementsArray = elements.filter { $0.category == categoryName }
                    }
                }
            }
            else {
                isSidebarButtonPressed = false
            }
            
            for buttonTag in [currentlySelectedSidebarButtonTag] {
                navigationItem.title = navBarTitles[buttonTag]
            }
            
            tableView.reloadSections([0], with: .automatic)
            if tableView.numberOfRows(inSection: 0) != 0 {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndexPath = self.tableView.indexPath(for: sender as! UITableViewCell)
        let element = isSidebarButtonPressed ? filteredElementsArray[selectedIndexPath!.row] : elements[selectedIndexPath!.row]

        if segue.identifier == Segue.ViewCell.rawValue {
            let webpageUrl: String?
            webpageUrl = element.webpageUrl
            if let destinationVC = segue.destination as? WebpageViewController {
                destinationVC.webpageTitle = element.name
                destinationVC.theURLPassedInFromOrigin = webpageUrl
            }
        } else if segue.identifier == Segue.ModalPopup.rawValue {
            if let destinationVC = segue.destination as? ModalViewController {
                destinationVC.elementSymbolText = element.symbol
                destinationVC.elementSymbolNumberText = String(element.number)
                destinationVC.elementSymbolAtomicWeightText = String(element.atomicWeight.truncate(to: 4))
                destinationVC.elementDescriptionText = element.summary
            }
        }
    }
}


// MARK: -  Tableview Datasource Methods

extension ElementsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSidebarButtonPressed ? filteredRowCount : rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ViewCell
        
        let element = isSidebarButtonPressed ? filteredElementsArray[indexPath.row] : elements[indexPath.row]
        
        let name = element.name
        let number = element.number
        let sybmol = element.symbol
        let atomicWeight = element.atomicWeight
        let category = element.category

        cell.name.text = name
        cell.number.text = String(number)
        cell.symbol.text = sybmol
        cell.atomicWeight.text = String(atomicWeight.truncate(to: 4))
        cell.category.text = category

        let rowColor = cell.rowColor
        for (categoryName, color) in rowColor {
            if category == categoryName {
                cell.backgroundColor = color
            }
        }

        return cell
    }
}


// MARK: -  Tableview Delegate Methods

extension ElementsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        var selectedIndexPath: IndexPath? = nil

        if selectedIndexPath == nil {
            selectedIndexPath = nil
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            selectedIndexPath = indexPath
        }
    }
}

