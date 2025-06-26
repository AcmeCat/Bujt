# <img src="https://github.com/user-attachments/assets/1551e4fb-849b-4d32-9e3b-c19d91e988cd" height="40" width="40"> Bujt
Bujt is a practical iOS budgeting app built with SwiftUI. It was born out of a personal need—to help my partner and me manage our finances better as we prepared for the arrival of our first child. With a clean, minimal interface and a simple weekly flow, Bujt helps users track expenses, set budget categories, and reset spending each week for a fresh start.

## Features
- View weekly remaining cash at a glance
- Add expenses and assign them to categories
- Create and manage custom budget categories
- Reset your weekly budget with confirmation
- Persistent storage for all your data
- Built using TDD principles for reliability and extensibility

## Acceptance Criteria
**Expense Categorization**
- *Given* I am using the app for the first time
- - *When* I navigate to the category management screen
- - - *Then* I can create new expense categories to suit my budgeting style

**Quick Expense Entry**
- *Given* I have spent money and want to track it
- - *When* I open the "Add Expense" screen
- - - *Then* I can enter an amount, a description, and assign a category to the expense

**Budget Awareness**
- *Given* I have entered expenses throughout the week
- - *When* I view the main screen
- - - *Then* I can see how much money remains in each category and in total

**Weekly Reset**
- *Given* it’s the start of a new budgeting week
- - *When* I tap "Start a New Week"
- - - *Then* I am asked to confirm, and upon confirming, all expenses are cleared while my categories and budgets remain intact

**Persistent Data**
- *Given* I’ve previously used the app
- - *When* I reopen it
- - - *Then* all my categories, budgets, and expenses are restored from local storage

## Tools & Frameworks
| Tech | Purpose |
| --------- | --------- |
| Swift	| Primary development language |
| SwiftUI	| UI layer for declarative design |
| Combine	| Reactive state management |
| FileManager	| Lightweight local persistence |
| XCTest | Unit testing of view models & logic |
| Xcode Previews| Rapid visual iteration on UI |

## Architecture
The project is structured using a MVVM (Model–View–ViewModel) pattern with a focus on modular, testable code.
```
Bujt
├── Models
│   └── Budget, Expense, Category (Codable structs)
├── ViewModels
│   └── BudgetViewModel.swift
├── Views
│   ├── MainBudgetView.swift
│   ├── AddExpenseView.swift
│   ├── EditCategoriesView.swift
│   └── ConfirmationView.swift
├── Persistence
│   └── BudgetStore.swift (File-based JSON storage)
└── Tests
    └── BujtTests.swift
```
| **Architecture Diagram** |
| --------- |
| ![bujt_architecture_diagram](https://github.com/user-attachments/assets/28f21541-e602-4eee-bdf4-cf9b4a21ca50) |


| **Class Diagram** |
| --------- |
| ![bujt_class_diagram](https://github.com/user-attachments/assets/2b958dd4-bda2-4835-b664-c30e119d5df8) |

## Screen Caps
The below images show the UI views as seen in iOS

| ![The main screen showing your remaining cash for the week, and lists of spending entries](/caps/Main.PNG) | ![Here you can enter a new expense and assign it a category](/caps/Add.PNG) |
| --------- | ---------- |
| The main screen showing your remaining cash for the week, and lists of spending entries | Here you can enter a new expense and assign it a category |

| ![Here you can adjust your budget for each expense category](/caps/Edit.PNG) | ![When you want to start a new week, you will need to confirm](/caps/Confirm.PNG) |
| --------- | ---------- |
| Here you can adjust your budget for each expense category | When you want to start a new week, you will need to confirm |

## Upcoming Features
- [ ] Core Data or CloudKit-based persistence
- [ ] Analytics and insights into spending patterns
- [ ] Widget or Apple Watch integration for quick expense entry
- [ ] Syncing across devices

