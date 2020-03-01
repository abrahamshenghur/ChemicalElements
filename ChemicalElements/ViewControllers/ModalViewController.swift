//
//  ModalViewController.swift
//  ChemicalElements
//
//  Created by John on 12/1/19.
//  Copyright © 2019 Abraham Shenghur. All rights reserved.
//

import UIKit


class ModalViewController: UIViewController {
    
    var elementSymbolText: String?
    var elementSymbolNumberText: String?
    var elementSymbolAtomicWeightText: String?
    var elementDescriptionText: String?

    @IBOutlet weak var elementSymbolLabel: UILabel!
    @IBOutlet weak var elementSymbolNumberLabel: UILabel!
    @IBOutlet weak var elementSymbolAtomicWeightLabel: UILabel!
    @IBOutlet weak var elementDescriptionLabel: UILabel!

    @IBAction func dismissPopupButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        elementSymbolLabel.text = elementSymbolText
        elementSymbolNumberLabel.text = elementSymbolNumberText
        elementSymbolAtomicWeightLabel.text = elementSymbolAtomicWeightText
        elementDescriptionLabel.text = elementDescriptionText
    }
}
