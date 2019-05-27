//
//  Networking.swift
//  SoleekLabTask
//
//  Created by Ahmed Samir on 5/27/19.
//  Copyright © 2019 MrRadix. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Networking {
    
    private let url = "https://restcountries.eu/rest/v2/all"
    private var countries: [Country] = []
    private let collectionView: UICollectionView
    
    init(view: UICollectionView){
        collectionView = view
        makeRESTCall()
        print("Countries is equal: \(countries.count)")
    }
    deinit {
        print("network released")
    }
    //MARK: - Make REST request
    private func makeRESTCall(){
        Alamofire.request(url,method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                self.retrieveData(value: value)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //Set retrieving the
    private func retrieveData(value: Any){
        if let jsonArray = JSON(value).array{
            for i in 0..<jsonArray.count{
                let name = jsonArray[i]["name"].stringValue
                let nativeName = jsonArray[i]["nativeName"].stringValue
                let timezone = jsonArray[i]["timezones"].arrayValue[0].stringValue
                let capital = jsonArray[i]["capital"].stringValue
                countries.append(Country(name: name, capital: capital, timezone: timezone, nativeName: nativeName))
            }
            
        }
        // nodify the Controller that model finished downloading the data
        collectionView.reloadData()
    }
    
    //MARK: - Send  the Retrieved Data to Controller
    
    func getNumberOfCountries() -> Int{
        return countries.count
    }
    func getCountryAtIndex(index: Int) -> Country{
        return countries[index]
    }
}
