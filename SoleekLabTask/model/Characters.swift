//
//  Characters.swift
//  SoleekLabTask
//
//  Created by Ahmed Samir on 6/17/19.
//  Copyright © 2019 MrRadix. All rights reserved.
//

import Foundation

struct Characters {
    private let characters = ["A","B","C","D","E","F","G","H","I","J",
                      "K","L","M","N","O","P","Q","R","S","T",
                      "U","V","W","X","Y","Z"]
    
    
    func getCharacterAtIndex(index:Int) -> String{
        return characters[index]
    }
    
    func getCharactersNum() -> Int{
        return characters.count
    }
}
