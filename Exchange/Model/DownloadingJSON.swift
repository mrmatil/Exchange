//
//  DownloadingJSON.swift
//  Exchange
//
//  Created by Mateusz Łukasiński on 09/07/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class JSONDownload{
    
    //variables:
    let upperCurrency:String
    let bottomCurrency:String
    let mainURL:String = "https://api.exchangeratesapi.io/latest"
    let baseAndSymbols: [String:String]
    let completion:(Double, Bool)->Void
    
    
    init(upperCurrency:String, bottomCurrency:String, completion:@escaping (Double, Bool)->Void) {
        self.upperCurrency=upperCurrency
        self.bottomCurrency=bottomCurrency
        baseAndSymbols=["base":upperCurrency,"symbols":bottomCurrency]
        self.completion = completion
        getJSON()
    }
    
    
    func getJSON(){
        
        Alamofire.request(mainURL, method: .get, parameters: baseAndSymbols).responseJSON(){
            response in
            
            if response.result.isSuccess{
                let currencyValue = Parser.init(JSON: JSON(response.result.value!), upperCurrency: self.upperCurrency, bottomCurrency: self.bottomCurrency).answerParser()
                self.completion(currencyValue,true)
                
            }
            
            if response.result.isFailure {
                self.completion(0,false)
            }
            
        }
    }
    

    
}
