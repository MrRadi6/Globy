//
//  Country.swift
//  SoleekLabTask
//
//  Created by Ahmed Samir on 5/27/19.
//  Copyright © 2019 MrRadix. All rights reserved.
//

import Foundation

struct Country {
    private var name: String?
    private var capital: String?
    private var timezone: String?
    private var nativeName: String?
    
    init(name:String,capital: String,timezone: String,nativeName: String){
        self.name = name
        self.nativeName = nativeName
        self.capital = capital
        self.timezone = timezone
    }
    
    func getName() -> String {
        return name ?? "Name unavailable"
    }
    
    func getCapital() -> String {
        return capital ?? ""
    }
    
    func getTimezone() -> String {
        return timezone ?? "timezone unvailable"
    }
    
    func getNativeName() -> String {
        return nativeName ?? "timezone unvailable"
    }
    
    func getDetails() -> String {
        return "The Capital of \(getName()) is \(getCapital()) and its native name \(getNativeName())"
    }
    
}
