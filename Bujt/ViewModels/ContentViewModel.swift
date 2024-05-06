//
//  ContentViewModel.swift
//  Bujt
//
//  Created by Rory Allen on 6/5/2024.
//

import Foundation
import CoreData
import UIKit

class ContentViewModel: ObservableObject {
    @Published var shouldShowAdd = false
    @Published var shouldShowManage = false
    @Published var showingConfirmation = false
    
    @Published var budgets: BudgetRepository
    
    let context: NSManagedObjectContext
    private var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?

    init(context: NSManagedObjectContext, budgets: BudgetRepository) {
        self.context = context
        self.budgets = budgets
    }
    
    func restart() {
        // ...
    }
    
    func deleteAll() {
        // ...
    }
    
    func removeEntry(at indexSet: IndexSet, category: String) {
        // ...
    }
    
    func entries(for category: String) -> [Entry] {
       let fetchRequest: NSFetchRequest = Entry.fetchRequest()
       fetchRequest.predicate = NSPredicate(format: "category = %@", category)
       fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

       do {
           return try context.fetch(fetchRequest)
       } catch {
           print("Error fetching entries: \(error)")
           return []
       }
   }
    
    func total(for category: String) -> Double {
        let fetchRequest: NSFetchRequest = Entry.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category = %@", category)

        do {
            let response = try context.fetch(fetchRequest)
            let total = response.reduce(0) { $0 + $1.cost }
            return total
        } catch {
            print("Error fetching entries: \(error)")
            return 0
        }
    }
    
//    private func loadMaxBudgets() -> [CategoryBudget] {
//        if let data = UserDefaults.standard.data(forKey: "maxBudgets") {
//            do {
//                let decoder = JSONDecoder()
//                return try decoder.decode([CategoryBudget].self, from: data)
//            } catch {
//                print("Error decoding maxBudgets: \(error)")
//            }
//        }
//        return []
//    }
}
