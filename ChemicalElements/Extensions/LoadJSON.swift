//
//  LoadJSON.swift
//  ChemicalElements
//
//  Created by John on 2/8/20.
//  Copyright © 2020 Abraham Shenghur. All rights reserved.
//

import Foundation

extension ElementsViewController {

    func loadJSON() {
        if let url = Bundle.main.url(forResource: "ElementJSON", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let response = try decoder.decode(LocalJSONData.self, from: data)
                for element in response.elements {
                    elements.append(element)
                }
            } catch {
                print("SOME ERROR: \(error)")
            }
        }
    }
}
