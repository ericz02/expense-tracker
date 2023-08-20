//
//  expensetrackerApp.swift
//  expensetracker
//
//  Created by Eric Zheng on 8/18/23.
//

import SwiftUI

@main
struct expensetrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
