//
//  HomeViewController.swift
//  SoleekLabTask
//
//  Created by Ahmed Samir on 5/25/19.
//  Copyright © 2019 MrRadix. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController {

    private let cellId = "CountryViewCell"
    private var network:Networking?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        network = Networking(view: collectionView)
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(CountryViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let dataCount = network?.getNumberOfCountries() else { return 0 }
        print(dataCount)
        return dataCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CountryViewCell
        if let country = network?.getCountryAtIndex(index: indexPath.item){
            cell.country = country
        }
        return cell
    }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
}
