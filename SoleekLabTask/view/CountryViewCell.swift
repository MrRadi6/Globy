//
//  CountryViewCell.swift
//  SoleekLabTask
//
//  Created by Ahmed Samir on 5/27/19.
//  Copyright © 2019 MrRadix. All rights reserved.
//

import UIKit

class CountryViewCell: UICollectionViewCell {
    
    //MARK: - Message Content handling
    var country :Country? {
        didSet{
            guard let newCountry = country else {return}
            countryLabel.text = newCountry.getName()
            details.text = newCountry.getDetails()
            timeZone.text = newCountry.getTimezone()
            
        }
    }
    
    //MARK: - Divider Line
    private let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    //MARK: - TextContainer
    private let textContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.white
        return container
    }()
    
    //MARK: - Country Name label
    private let countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Country Name"
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    //MARK: - Country Details label
    private let details: UILabel = {
        let label = UILabel()
        label.text = "Welcome to our Country hope you a nice vacation ......"
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textColor = UIColor.darkGray
        return label
    }()
    
    //MARK: - Time label
    private let timeZone: UILabel = {
        let label = UILabel()
        label.text = "UTC-0"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        dividerLineSetup()
        textContainerSetup()
        textSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    //MARK: - Divider Line Setup
    private func dividerLineSetup(){
        addSubview(dividerLineView)
        dividerLineView.translatesAutoresizingMaskIntoConstraints = false
        dividerLineView.topAnchor.constraint(equalTo: bottomAnchor, constant: 3).isActive = true
        dividerLineView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dividerLineView.widthAnchor.constraint(equalToConstant: frame.size.width ).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    //MARK: - text Container Setup
    private func textContainerSetup(){
        addSubview(textContainerView)
        textContainerView.translatesAutoresizingMaskIntoConstraints = false
        textContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        textContainerView.bottomAnchor.constraint(equalTo: dividerLineView.topAnchor, constant: -20).isActive = true
        textContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        textContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    private func textSetup(){
        textContainerView.addSubview(countryLabel)
        textContainerView.addSubview(details)
        textContainerView.addSubview(timeZone)
        
        LabelSetup(view: countryLabel, top: textContainerView.topAnchor, bottom: details.topAnchor, leading: textContainerView.leadingAnchor, trailing: timeZone.leadingAnchor)
        LabelSetup(view: details, top: countryLabel.bottomAnchor, bottom: textContainerView.bottomAnchor, leading: textContainerView.leadingAnchor, trailing: textContainerView.trailingAnchor)
        LabelSetup(view: timeZone, top: textContainerView.topAnchor, bottom: details.topAnchor, leading: countryLabel.trailingAnchor, trailing: textContainerView.trailingAnchor)
    }
    
    private func LabelSetup(view: UIView,top: NSLayoutYAxisAnchor,bottom:NSLayoutYAxisAnchor,leading: NSLayoutXAxisAnchor,trailing:NSLayoutXAxisAnchor){
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.topAnchor.constraint(equalTo: top).isActive = true
        view.bottomAnchor.constraint(equalTo: bottom).isActive = true
        view.leadingAnchor.constraint(equalTo: leading).isActive = true
        view.trailingAnchor.constraint(equalTo: trailing).isActive = true
    }
    
    //MARK: - Cell view Setup
    private func setupViews(){
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
