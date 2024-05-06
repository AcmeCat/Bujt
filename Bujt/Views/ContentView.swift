//
//  ContentView.swift
//  Bujt
//
//  Created by Rory Allen on 18/2/2024.
//

import CoreData
import SwiftUI

//struct ContentView: View {
//    
//    @State private var shouldShowAdd = false
//    @State private var shouldShowManage = false
//    @State private var showingConfirmation = false
//    @State private var deleteToggle = false
//    
//    
//    @State private var personalBudgetMax: Double = 100.00
////    Int16 = Int16(UserDefaults.standard.integer(forKey: "personalBudgetMax"))
//    @State private var groceryBudgetMax: Double = 100.00
////    Int16 = Int16(UserDefaults.standard.integer(forKey: "groceryBudgetMax"))
//    @State private var savingsBudgetMax: Double = 100.00
////    Int16 = Int16(UserDefaults.standard.integer(forKey: "savingsBudgetMax"))
//    
//    @Environment(\.managedObjectContext) var moc
//    
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "category = %@", Category.personal.rawValue)) var personalEntries: FetchedResults<Entry>
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "category = %@", Category.groceries.rawValue)) var groceryEntries: FetchedResults<Entry>
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "category = %@", Category.savings.rawValue)) var savingsEntries: FetchedResults<Entry>
//    
//    var body: some View {
//        NavigationView {
//            List {
//                Section {
//                    Text("Remaining Cash")
//                        .font(.title)
//                    if personalBudgetMax > 0 {
//                        HStack {
//                            Text("Personal:")
//                            Spacer()
//                            Text((personalBudgetMax - total(personalEntries)), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                        }
//                    }
//                    if groceryBudgetMax > 0 {
//                        HStack {
//                            Text("Groceries:")
//                            Spacer()
//                            Text((groceryBudgetMax - total(groceryEntries)), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                        }
//                    }
//                    if savingsBudgetMax > 0 {
//                        HStack {
//                            Text("Savings:")
//                            Spacer()
//                            Text((savingsBudgetMax - total(savingsEntries)), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                        }
//                    }
//                }
//                if personalEntries.count > 0 {
//                    Section {
//                        ForEach(personalEntries) { entry in
//                            HStack {
//                                Text(entry.name ?? "Unknown")
//                                Spacer()
//                                Text(entry.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                            }
//                        }
//                        .onDelete(perform: removePersonalEntry)
//                    } header: {
//                        Text("Personal: $\(total(personalEntries))")
//                    }
//                    
//                }
//                if groceryEntries.count > 0 {
//                    Section {
//                        ForEach(groceryEntries) { entry in
//                            HStack {
//                                Text(entry.name ?? "Unknown")
//                                Spacer()
//                                Text(entry.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                            }
//                        }
//                        .onDelete(perform: removeGroceryEntry)
//                    } header: {
//                        Text("Groceries: $\(total(groceryEntries))")
//                    }
//                }
//                if savingsEntries.count > 0 {
//                    Section {
//                        ForEach(savingsEntries) { entry in
//                            HStack {
//                                Text(entry.name ?? "Unknown")
//                                Spacer()
//                                Text(entry.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
//                            }
//                        }
//                        .onDelete(perform: removeSavingsEntry)
//                    } header: {
//                        Text("Savings: $\(total(savingsEntries))")
//                    }
//                }
//                Button {
//                    restart()
//                } label: {
//                    Text("Start a new week")
//                }
//            }
//            .padding()
//            .toolbar{
//                ToolbarItem (placement: .topBarLeading) {
//                    addEntry
//                }
//                ToolbarItem (placement: .topBarTrailing) {
//                    manageBudget
//                }
//            }
//            .sheet(isPresented: $shouldShowAdd, onDismiss: dismissAdd){
//                AddView()
//            }
//            .sheet(isPresented: $shouldShowManage, onDismiss: dismissManage){
//                BudgetView()
//            }
//            .alert("Are you sure?", isPresented: $showingConfirmation) {
//                Button("Cancel", role: .cancel) {}
//                Button("Yes, Delete It All!") { deleteAll() }
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
//
//private extension ContentView {
//    
//    var addEntry: some View {
//        Button {
//            shouldShowAdd.toggle()
//            print("add tapped...")
//        } label: {
//            Symbols.plus
//                .font(
//                    .system(.headline, design: .rounded)
//                    .bold()
//                )
//        }
//    }
//    
//    func dismissAdd () {
//        print("dismissed add view...")
//    }
//                    
//    var manageBudget: some View {
//        Button {
//            shouldShowManage.toggle()
//            print("add tapped...")
//        } label: {
//            Symbols.dollar
//                .font(
//                    .system(.headline, design: .rounded)
//                    .bold()
//                )
//        }
//    }
//    
//    func dismissManage () {
//        personalBudgetMax = 100.00
//        //Int16(UserDefaults.standard.integer(forKey: "personalBudgetMax"))
//        groceryBudgetMax = 100.00
//        //Int16(UserDefaults.standard.integer(forKey: "groceryBudgetMax"))
//        savingsBudgetMax = 100.00
//        //Int16(UserDefaults.standard.integer(forKey: "savingsBudgetMax"))
//    }
//    
//    func total (_ entries: FetchedResults<Entry>) -> Double {
//        var total: Double = 0.0
//        entries.forEach {
//            total += $0.cost
//        }
//        return total
//    }
//    
//    func restart() {
//        showingConfirmation.toggle()
//    }
//    
//    func deleteAll() {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Entry")
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        do {
//            try moc.execute(deleteRequest)
//            moc.reset()
//            print("It's all gone!")
//            deleteToggle.toggle()
//        } catch let error as NSError {
//            print("an error: ", error.localizedDescription)
//        }
//    }
//    
//    func removePersonalEntry(at indexSet: IndexSet) {
//        for index in indexSet {
//            let entry = personalEntries[index]
//            moc.delete(entry)
//        }
//        try? moc.save()
//    }
//    
//    func removeGroceryEntry(at indexSet: IndexSet) {
//        for index in indexSet {
//            let entry = groceryEntries[index]
//            moc.delete(entry)
//        }
//        try? moc.save()
//    }
//    
//    func removeSavingsEntry(at indexSet: IndexSet) {
//        for index in indexSet {
//            let entry = savingsEntries[index]
//            moc.delete(entry)
//        }
//        try? moc.save()
//    }
//}

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var viewModel: ContentViewModel
    //var budgets: BudgetRepository = BudgetRepository()
    //@State var maxBudgets: [CategoryBudget] = []
    
    init(context: NSManagedObjectContext) {
        self.viewModel = ContentViewModel(context: context, budgets: BudgetRepository())
//        if let data = UserDefaults.standard.data(forKey: "maxBudgets") {
//            do {
//                let decoder = JSONDecoder()
//                viewModel.maxBudgets = try decoder.decode([CategoryBudget].self, from: data)
//            } catch {
//                print("Error decoding maxBudgets: \(error)")
//            }
//        }
    }
    
    var body: some View {
        NavigationView {
            List {
                RemainingCashView(viewModel: viewModel, budgets: viewModel.budgets.getBudgets())
                ForEach(viewModel.budgets.getBudgets()) { budget in
                    EntriesView(viewModel: viewModel, category: budget.category)
                }
                Button("Start a new week") {
                    viewModel.restart()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    AddEntryButton(viewModel: viewModel)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    ManageBudgetButton(viewModel: viewModel)
                }
            }
            .sheet(isPresented: $viewModel.shouldShowAdd) {
                AddView(categories: viewModel.budgets.getBudgets().map {$0.category} )
            }
            .sheet(isPresented: $viewModel.shouldShowManage) {
                BudgetView(viewModel: BudgetViewModel(budgetRepository: viewModel.budgets))
            }
            .alert("Are you sure?", isPresented: $viewModel.showingConfirmation) {
                Button("Cancel", role: .cancel) {}
                Button("Yes, Delete It All!") {
                    viewModel.deleteAll()
                }
            }
        }
    }
}

// MARK: - Subviews

struct RemainingCashView: View {
    @ObservedObject var viewModel: ContentViewModel
    let budgets: [CategoryBudget]
    //private var budgetMaximums: [String : Double] = UserDefaults.standard.dictionary(forKey: "budgetMaximums")
        
    var body: some View {
        Section {
            Text("Remaining Cash")
                .font(.title)
            ForEach(budgets) { budget in
                HStack {
                    Text("\(budget.category):")
                    Spacer()
                    Text("$\(budget.budget - viewModel.total(for: budget.category))")
                }
            }
        }
    }
}

struct EntriesView: View {
    @ObservedObject var viewModel: ContentViewModel
    let category: String
    
    var body: some View {
        Section {
            if viewModel.entries(for: category).isEmpty {
                Text("No entries for \(category.capitalized)")
                    .foregroundColor(.secondary)
            } else {
                ForEach(viewModel.entries(for: category)) { entry in
                    HStack {
                        Text(entry.name ?? "Unknown")
                        Spacer()
                        Text(entry.cost, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
                .onDelete {
                    viewModel.removeEntry(at: $0, category: category)
                }
            }
        } header: {
            Text("\(category.capitalized): $\(viewModel.total(for: category))")
        }
    }
}

struct ManageBudgetButton: View {
    @ObservedObject var viewModel: ContentViewModel
    var body: some View {
        Button {
            viewModel.shouldShowManage.toggle()
            print("add tapped...")
        } label: {
            Symbols.dollar
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
}


struct AddEntryButton: View {
    @ObservedObject var viewModel: ContentViewModel
    var body: some View {
        Button {
            viewModel.shouldShowAdd.toggle()
            print("add tapped...")
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
}
