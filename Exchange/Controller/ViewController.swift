//
//  ViewController.swift
//  Exchange
//
//  Created by Mateusz Łukasiński on 09/07/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //IBOutlets:
    
    @IBOutlet weak var upperTextField: UITextField!
    @IBOutlet weak var bottomValueLabel: UILabel!
    @IBOutlet weak var upperPickerView: UIPickerView!
    @IBOutlet weak var bottomPickerView: UIPickerView!
    
    //IBActions:
    @IBAction func calculateButton(_ sender: UIButton) {
        getValue()
        hideKeyboard()
    }

    
    //Variables:
    let currenciesArray: [String] = ["","CAD","HKD","ISK","PHP","DKK","HUF","CZK","GBP",
                                     "RON","SEK","IDR","INR","BRL","RUB","HRK","JPY",
                                     "THB","CHF","EUR","MYR","BGN","TRY","CNY","NOK",
                                     "NZD","ZAR","USD","MXN","SGD","AUD","ILS","KRW",
                                     "PLN"]
    var upperCurrency: String?
    var bottomCurrency: String?
    var bottomValue:Double?
    
    //functions:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enablePickerViews()
        
        // Do any additional setup after loading the view.
    }

    func getValue(){
        guard upperCurrency != nil else {
            return
        }
        guard bottomCurrency != nil else{
            return
        }
        let x = JSONDownload.init(upperCurrency: upperCurrency!, bottomCurrency: bottomCurrency!)
        x.getJSON()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.bottomValue=x.value()
            self.calculate()
        }
    }
    
    func calculate(){
        guard var amountOf = Double(upperTextField.text!) else {return}
        amountOf = Double(round(1000*(amountOf*bottomValue!))/1000)
        changeLabelValues(value: amountOf)
    }
    
    func changeLabelValues(value:Double){
        bottomValueLabel.text=String(value)
    }
    
    func hideKeyboard(){
        view.endEditing(true)
    }
}

//Setting up both picker views:
extension ViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    
    func enablePickerViews(){
        upperPickerView.delegate=self
        bottomPickerView.delegate=self
        upperPickerView.dataSource=self
        bottomPickerView.dataSource=self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currenciesArray.count
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: currenciesArray[row], attributes: [NSAttributedString.Key.foregroundColor:UIColor.white]) // returns string + set color to white
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == upperPickerView{
            print("upper")
            upperCurrency=currenciesArray[row]
            hideKeyboard()
        }
        else if pickerView == bottomPickerView{
            print("bottom")
            bottomCurrency=currenciesArray[row]
            hideKeyboard()
        }
    }
}

