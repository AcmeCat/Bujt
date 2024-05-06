//
//  Categories.swift
//  Bujt
//
//  Created by Rory Allen on 18/2/2024.
//

import Foundation

struct CategoryBudget: Codable, Identifiable {
    var id: String
    let category: String
    var budget: Double
    
    init(id: String = UUID().uuidString, category: String, budget: Double) {
        self.id = id
        self.category = category
        self.budget = budget
    }
    
    func updateBudget(_ value: Double) -> CategoryBudget {
        return CategoryBudget(id: id, category: category, budget: value)
    }
}

