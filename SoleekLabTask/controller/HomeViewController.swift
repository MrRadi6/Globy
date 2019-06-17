//
//  HomeViewController.swift
//  SoleekLabTask
//
//  Created by Ahmed Samir on 5/25/19.
//  Copyright © 2019 MrRadix. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UICollectionViewController {

    private let cellId = "CountryViewCell"
    private var network:Networking?
    var startWith:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let start = startWith {
            network = Networking(view: collectionView,startWith: start)
        } else {
            print("start not set yet")
        }
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = false
        collectionView.register(CountryViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataCount = network?.getNumberOffilteredCountries() else { return 0 }
        print(dataCount)
        return dataCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CountryViewCell
        if let country = network?.getFilteredCountriesAtIndex(index: indexPath.item){
            cell.country = country
        }
        return cell
    }
    
    @IBAction func logoutPress(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        }
        catch {
            print(error)
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}
