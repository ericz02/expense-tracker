//
//  TransactionListViewModel.swift
//  expensetracker
//
//  Created by Eric Zheng on 8/19/23.
//

import Foundation
import Combine

typealias TransactionGroup = [String: [Transaction]]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data: Data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching transactions: ", error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
            }
            .store(in: &cancellables)

    }
    
    func groupTransactionsByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        
        let groupedTransctions = TransactionGroup(grouping: transactions) { $0.month }
        
        return groupedTransctions
    }
}
