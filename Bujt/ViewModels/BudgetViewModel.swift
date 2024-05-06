//
//  BudgetViewModel.swift
//  Bujt
//
//  Created by Rory Allen on 6/5/2024.
//

import Foundation
import SwiftUI

class BudgetViewModel: ObservableObject {
    @Published var budgetArray: [CategoryBudget]
    
    let budgetRepository: BudgetRepository
    
    init(budgetRepository: BudgetRepository) {
        self.budgetRepository = budgetRepository
        self.budgetArray = budgetRepository.getBudgets()
    }
    
    func submit() {
        budgetRepository.setBudgets(budgetArray)
    }
    
    func addCategory(name: String) {
        let newBudget = CategoryBudget(category: name, budget: 0.0)
        budgetArray.append(newBudget)
        budgetRepository.addBudget(newBudget)
    }
}
