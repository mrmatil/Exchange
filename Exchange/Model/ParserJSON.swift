//
//  ParserJSON.swift
//  Exchange
//
//  Created by Mateusz Łukasiński on 09/07/2019.
//  Copyright © 2019 Mateusz Łukasiński. All rights reserved.
//

import Foundation
import SwiftyJSON

class Parser{
    
    //variables:
    let JSON:JSON
    let upperCurrency:String
    let bottomCurrency:String
    var answer:Double = 0
    
    init(JSON:JSON, upperCurrency:String, bottomCurrency:String) {
        self.JSON=JSON
        self.upperCurrency=upperCurrency
        self.bottomCurrency=bottomCurrency
    }
    
    private func parse(){
        guard let x =  JSON["rates"][bottomCurrency].double else{return}
        answer = x
    }
    
    func answerParser()->Double{
        parse()
        return answer
    }
}
