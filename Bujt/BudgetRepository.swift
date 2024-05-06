//
//  BudgetRepository.swift
//  Bujt
//
//  Created by Rory Allen on 6/5/2024.
//

import Foundation

class BudgetRepository {
    private var storage: [CategoryBudget] = []
    
    init() {
        self.storage = loadBudgets()
    }
    
    func getBudgets() -> [CategoryBudget] {
        return storage
    }
    
    func setBudgets(_ budgets: [CategoryBudget]) {
        storage = budgets
        saveBudgets()
    }
    
    func addBudget(_ newBudget: CategoryBudget) {
        storage.append(newBudget)
        saveBudgets()
    }
    
    private func loadBudgets() -> [CategoryBudget] {
        if let data = UserDefaults.standard.data(forKey: "budgets") {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([CategoryBudget].self, from: data)
            } catch {
                print("Error decoding budgets: \(error)")
            }
        }
        return []
    }
    
    private func saveBudgets() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(storage)
            UserDefaults.standard.set(data, forKey: "budgets")
        } catch {
            print("Error encoding budgets: \(error)")
        }
    }
}
