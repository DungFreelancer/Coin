//
//  CashInfoVM.swift
//  Coin
//
//  Created by Dung Do on 1/1/18.
//  Copyright © 2018 HD. All rights reserved.
//

import Foundation

enum Coin: String {
    case BTC = "BTC"
    case ETH = "ETH"
    case OTN = "OTN"
}

enum Currency: String {
    case USD = "USD"
    case EUR = "EUR"
}

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
    
    func getPrice(by coin:Coin, complete:((_ price:String?)->())?) {
        switch coin {
        case .BTC:
            self.getPrice(url: URL_BTC_PRICE, complete: complete)
        case .ETH:
            self.getPrice(url: URL_ETH_PRICE, complete: complete)
        case .OTN:
            self.getPrice(url: URL_OTN_PRICE, complete: complete)
        }
    }
    
    private func getPrice(url:String, complete:((_ price:String?)->())?) {
        NetworkHelper.sharedInstance.get(url: url, complete: { (json, error) in
            if let json = json {
                Logs.debug(json)
                if let complete = complete {
                    complete(String(json[Currency.USD.rawValue].double ?? 0.0))
                }
            } else {
                Logs.error(error.debugDescription)
            }
        })
    }
    
}
