//
//  TransactionVeiwModal.swift
//  ExpenseTracker
//
//  Created by Malav Patel on 3/21/24.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum = [(String,Double)]
final class TransactionListViewModel: ObservableObject{
    @Published var Transactions: [Transaction]=[]
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getTransactions()
    }
    
    func getTransactions(){
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else{
            print("invalid URL")
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                    dump(response)
                    throw URLError(.badServerResponse)
                    
                }
                return data
            }
        
            .decode( type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("error fetching transactions", error.localizedDescription)
                case.finished:
                    print("finished fetching transaction")
                }
            } receiveValue: { [weak self] result in
                self?.Transactions = result
                
            }
            .store(in: &cancellables)
        
    }
    
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !Transactions.isEmpty else { return [:]}
        let groupedTransaction = TransactionGroup(grouping: Transactions) { $0.month }
        return groupedTransaction
    }
    
    
    func accumulateTransactions() -> TransactionPrefixSum {
        print("accumulated transactions")
        guard !Transactions.isEmpty else { return []}
        
        let today = "02/17/2022" .dateParsed() // Date()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        print ("dateInterval", dateInterval)
        
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24 ){
            let dailyExpenses = Transactions.filter{ $0.dateParsed == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cumulativeSum.append((date.formatted(), sum))
            print(date.formatted(), "dailyTotal:", dailyTotal, "sum:", sum)
 
        }
        return cumulativeSum
    }
}
