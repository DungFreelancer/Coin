//
//  CashInfoVC.swift
//  TemplateProject
//
//  Created by Tran Gia Huy on 9/30/17.
//  Copyright © 2017 HD. All rights reserved.
//

import UIKit

class CashInfoVC: UIViewController {
    
    @IBOutlet weak var txtPayment: UITextField!
    @IBOutlet weak var txtCoinPrice: UITextField!
    @IBOutlet weak var txtCoinQuantity: UITextField!
    @IBOutlet weak var txtCoinCurrentlyPrice: UITextField!
    @IBOutlet weak var lbTotalMoney: UILabel!
    @IBOutlet weak var lbCurrency: UILabel!
    
    private var cashInfoVM: CashInfoVM = CashInfoVM()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUDHelper.sharedInstance.showLoading(view: self.view)
        cashInfoVM.getPrice(by: .BTC, complete: { (price) in
            self.txtCoinCurrentlyPrice.text = price
            
            HUDHelper.sharedInstance.hideLoading()
        })
        
        // Load cash info to layout.
        if let info: CashInfoModel = self.cashInfoVM.loadInfo() {
            self.txtPayment.text = String(info.payment)
            self.txtCoinPrice.text = String(info.coinPrice)
            self.txtCoinQuantity.text = String(info.coinQuantity)
        }
    }
    
    // MARK: - Tap event
    @IBAction func tapCaculate(_ sender: Any) {
        if self.checkValid() == false {
            return
        }
        
        // Save info.
        let info: CashInfoModel = CashInfoModel(payment: Double(self.txtPayment.text!)!,
                                 coinPrice: Double(self.txtCoinPrice.text!)!,
                                 coinQuantity: Double(self.txtCoinQuantity.text!)!)
        self.cashInfoVM.saveInfo(info)
        
        // Caculate info.
        let total: String = String(self.cashInfoVM.caculate(payment: Double(self.txtPayment.text!)!,
                                                            coinPrice: Double(self.txtCoinPrice.text!)!,
                                                            coinQuantity: Double(self.txtCoinQuantity.text!)!,
                                                            coinCurrentlyPrice: Double(self.txtCoinCurrentlyPrice.text!)!))
        self.lbTotalMoney.text = total
    }
    
    // MARK: - Private methods
    private func checkValid() -> Bool {
        guard let payment = self.txtPayment.text, payment != "" else {
            Commons.sharedInstance.showAlertOnViewController(self, message: "Payment should not be empty!", mainButton: "OK", mainComplete: {_ in
            })
            return false
        }
        guard let coinPrice = self.txtCoinPrice.text, coinPrice != "" else {
            Commons.sharedInstance.showAlertOnViewController(self, message: "Coin price should not be empty!", mainButton: "OK", mainComplete: {_ in
            })
            return false
        }
        guard let coinQuantity = self.txtCoinQuantity.text, coinQuantity != "" else {
            Commons.sharedInstance.showAlertOnViewController(self, message: "Coin quantity should not be empty!", mainButton: "OK", mainComplete: {_ in
            })
            return false
        }
        guard let coinCurrentlyPrice = self.txtCoinCurrentlyPrice.text, coinCurrentlyPrice != "" else {
            Commons.sharedInstance.showAlertOnViewController(self, message: "Coin currently price should not be empty!", mainButton: "OK", mainComplete: {_ in
            })
            return false
        }
        
        return true
    }
    
}

