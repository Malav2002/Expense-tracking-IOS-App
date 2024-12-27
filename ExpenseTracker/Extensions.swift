//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Malav Patel on 3/18/24.
//

import Foundation
import SwiftUI

extension Color{
    static let bg = Color("Background")
    static let Icon = Color("Icon")
    static let Text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
    
    
}
extension DateFormatter{
    static let allNumericUSA: DateFormatter = {
        print("initializing data formatter")
        let formatter = DateFormatter()
        formatter.dateFormat="MM/dd/yyy"
        return formatter
        
    }()
}
extension String{
    func dateParsed()-> Date{
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else {return Date() }
        return parsedDate
    }
}

extension Double {
    func roundedTo2Digits () -> Double {
        return (self * 100).rounded () / 100
    }
}
    
