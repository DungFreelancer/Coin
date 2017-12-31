//
//  CashInfoModel.swift
//  Coin
//
//  Created by Dung Do on 12/31/17.
//  Copyright © 2017 HD. All rights reserved.
//

import Foundation

class CashInfoModel: Codable {
    
    var payment: Double
    var coinPrice: Double
    var coinQuantity: Double
    
    init(payment: Double, coinPrice: Double, coinQuantity: Double) {
        self.payment = payment
        self.coinPrice = coinPrice
        self.coinQuantity = coinQuantity
    }
    
}
