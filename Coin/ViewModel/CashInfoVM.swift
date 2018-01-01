//
//  CashInfoVM.swift
//  Coin
//
//  Created by Dung Do on 1/1/18.
//  Copyright © 2018 HD. All rights reserved.
//

import Foundation

class CashInfoVM {
    
    func saveInfo(_ info: CashInfoModel) {
        let dataInfo: Data = try! JSONEncoder().encode(info)
        
        UserDefaults.standard.set(dataInfo, forKey:KEY_INFO)
        UserDefaults.standard.synchronize()
    }
    
    func loadInfo() -> CashInfoModel? {
        guard let dataInfo: Data = UserDefaults.standard.object(forKey: KEY_INFO) as? Data else {
            return nil
        }
        
        let info: CashInfoModel? = try? JSONDecoder().decode(CashInfoModel.self, from: dataInfo)
        
        return info
    }
    
    func caculate(payment: Double, coinPrice: Double, coinQuantity: Double, coinCurrentlyPrice: Double) -> Double {
        let total = (coinQuantity * coinCurrentlyPrice) - payment
        
        return total
    }
    
}
