//
//  SortPopOver.swift
//  ChemicalElements
//
//  Created by John on 11/11/19.
//  Copyright © 2019 Abraham Shenghur. All rights reserved.
//

import UIKit

class SidebarViewController: UIViewController {
    
    private var currentSidebarButtonSelectedTag = 0
    
    @IBOutlet var sidebarButtons: [UIView]!
    
    @IBOutlet weak var topLevelView: UIStackView!
    
    @IBAction func sidebarButtonTapped(_ sender: UIButton) {
        
        currentSidebarButtonSelectedTag = sender.tag
        postNotificationUsing(currentSidebarButtonSelectedTag)
        updateButtonColors()
        toggleSideBar()
    }
    
    func postNotificationUsing(_ currentSidebarButtonTag: Int) {
        if currentSidebarButtonSelectedTag <= 7 {
            NotificationCenter.default.post(name: .periodSelectedNotification, object: currentSidebarButtonTag)
        } else {
            NotificationCenter.default.post(name: .categoryNotification, object: currentSidebarButtonTag)
        }
    }
    
    func toggleSideBar() {
        NotificationCenter.default.post(name: .toggleSidebar, object: nil)
    }
    
    @IBAction func closeSideBar(_ sender: UIButton) {
        NotificationCenter.default.post(name: .toggleSidebar, object: nil)
    }
    
    func updateButtonColors() {
        for button in sidebarButtons {
            if button == sidebarButtons[currentSidebarButtonSelectedTag] {
                button.tintColor = self.view.tintColor
            } else {
                button.tintColor = .gray
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateButtonColors()
    }
}
