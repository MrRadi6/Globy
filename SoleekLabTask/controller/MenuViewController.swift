//
//  MenuViewController.swift
//  SoleekLabTask
//
//  Created by Ahmed Samir on 6/17/19.
//  Copyright © 2019 MrRadix. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let characters = Characters()
var char:String?

class MenuViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.getCharactersNum()
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 80, height: 80))
        button.setTitle(characters.getCharacterAtIndex(index: indexPath.item), for: .normal)
        button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(goToHome(sender:)), for: .touchUpInside)
        cell.addSubview(button)
        return cell
    }
    
    @objc func goToHome(sender:UIButton) {
        char = sender.titleLabel?.text
        performSegue(withIdentifier: "goToHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHome" {
            if let vc = segue.destination as? HomeViewController {
                guard let unwrapedChar = char else {
                    return
                }
                vc.startWith = unwrapedChar
            }
        }
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
