//
//  TransactionRow.swift
//  expensetracker
//
//  Created by Eric Zheng on 8/18/23.
//

import SwiftUI

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 6) {
                // MARK: Transaction Merchant
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                // MARK: Transaction Category
                Text(transaction.category)
                    .font(.footnote)
                    .opacity(0.7)
                    .lineLimit(1)
                
                // MARK: Transaction Date
                Text(transaction.dateParsed, format: .dateTime.year().month().day())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // MARK: Transaction Amount
            Text(transaction.amount, format: .currency(code: "USD"))
                .bold()
                .foregroundColor(transaction.type == TransactionType.credit.rawValue ? Color.text: .primary)
        }
        .padding([.top, .bottom], 8)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TransactionRow(transaction: transactionPreviewData)
            TransactionRow(transaction: transactionPreviewData)
                .preferredColorScheme(.dark)
        }
    }
}
