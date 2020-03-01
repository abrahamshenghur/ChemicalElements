//
//  ContainerViewController.swift
//  ChemicalElements
//
//  Created by John on 12/8/19.
//  Copyright © 2019 Abraham Shenghur. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {
    
    var isSideBarShowing = false
    
    
    @IBOutlet weak var sideBarTrailingConstraint: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideBar), name: .toggleSidebar, object: nil)
        
        sideBarTrailingConstraint.constant = 250
    }
    
    
    @objc func toggleSideBar() {
        if (isSideBarShowing) {
            sideBarTrailingConstraint.constant = 250
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
        } else {
            sideBarTrailingConstraint.constant = 0
            UIView.animate(withDuration: 0.2, animations: {
                self.view.layoutIfNeeded()
            })
        }
        
        isSideBarShowing = !isSideBarShowing
    }
}


