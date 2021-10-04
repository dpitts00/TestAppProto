//
//  NumberFormatterSingleton.swift
//  TestAppProto
//
//  Created by Daniel Pitts on 10/3/21.
//

import UIKit

class CurrencyNumberFormatter: NumberFormatter {
    static var shared: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }
    
    static func currencyString(amount: CGFloat) -> String? {
        return self.shared.string(for: amount) ?? "0.00"
    }
    

}
