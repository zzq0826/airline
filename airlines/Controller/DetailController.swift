//
//  ViewController.swift
//  aaa
//
//  Created by 张铮琦 on 1/31/19.
//  Copyright © 2019 张铮琦. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    var airline: Airline?
    var code: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        airlineNameLabel.text = airline?.defaultName
        airlinePhoneLabel.text = airline?.phone
        code = airline?.code
        setupThumnailImage()
        setupViews()
        setLikeImage()
    }
    
    func setupThumnailImage() {
        if let thumnailUrl = airline?.logoURL {
            airlineThumnailView.loadImageUsingUrlString(urlString: thumnailUrl)
        }
    }
    
    let airlineThumnailView: CustomImageView = {
        let view = CustomImageView()
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        return view
    }()
    
    let airlineNameLabel: UILabel = {
        let label = UILabel()
        label.font=UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let airlinePhoneLabel: UILabel = {
        let label = UILabel()
        label.text = "0810-333-8222"
        label.textColor = UIColor.lightGray
        return label
    }()
    
    let airlineWebsiteLabel: UIButton = {
        let button = UIButton(type:.custom)
        button.frame = CGRect(x:0 , y:0, width:80, height:30)
        button.setTitle("www.avianca.com.ar", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return button
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named:"heart-full.pdf"), for: .normal)
        button.tintColor = .red
        button.addTarget(self, action: #selector(likeAirline), for: .touchUpInside)
        return button
    }()
    
    @objc func buttonClick() {
        if let url = URL(string: "https://" + "www.avianca.com.ar") {
            UIApplication.shared.open(url, options: [:])
        }
        print("Button Clicked")
    }
    
    func setupViews() {
        
        view.addSubview(airlineThumnailView)
        view.addSubview(airlineNameLabel)
        view.addSubview(airlinePhoneLabel)
        view.addSubview(likeButton)
        view.addSubview(airlineWebsiteLabel)
        
        AutolayoutProxy.layout(airlineThumnailView)
            .centerHorizontallyInParentView()
            .topSpaceToSuperview(120)
            .width(60)
            .height(60)
        AutolayoutProxy.layout(airlineNameLabel)
            .centerHorizontallyInParentView()
            .topSpaceToSuperview(220)
            .height(30)
        AutolayoutProxy.layout(airlinePhoneLabel)
            .centerHorizontallyInParentView()
            .topSpaceToSuperview(260)
            .height(30)
        AutolayoutProxy.layout(likeButton)
            .topSpaceToSuperview(100)
            .trailingSpaceToSuperview(20)
            .width(30)
            .height(30)
        AutolayoutProxy.layout(airlineWebsiteLabel)
            .centerHorizontallyInParentView()
            .topSpaceToSuperview(300)
            .height(30)
    }
    
    @objc func likeAirline() {
        let defaults = UserDefaults.standard
        var airlines = defaults.stringArray(forKey: "likedAirlines") ?? [String]()
        if airlines.contains(where: { $0 == code }) {
            airlines.removeAll { $0 == code }
            defaults.set(airlines, forKey: "likedAirlines")
            likeButton.setBackgroundImage(UIImage(named:"heart-hollow.pdf")?.withRenderingMode(.alwaysTemplate), for: .normal)
            
        } else {
            airlines.append(code)
            defaults.set(airlines, forKey: "likedAirlines")
            likeButton.setBackgroundImage(UIImage(named:"heart-full.pdf")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    
    func setLikeImage() {
        let defaults = UserDefaults.standard
        let airlines = defaults.stringArray(forKey: "likedAirlines") ?? [String]()
        if airlines.contains(where: { $0 == code }) {
            likeButton.setBackgroundImage(UIImage(named:"heart-full.pdf")?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            likeButton.setBackgroundImage(UIImage(named:"heart-hollow.pdf")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
}

