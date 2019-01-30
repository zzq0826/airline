//
//  ViewController.swift
//  airlines
//
//  Created by 张铮琦 on 1/31/19.
//  Copyright © 2019 张铮琦. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var airlines: [Airline]?
    
    var isList = true
    
    func fetchAirlines() {
        let session = URLSession(configuration: .default)
        let url = "https://www.kayak.com/h/mobileapis/directory/airlines"
        let UrlRequest = URLRequest(url: URL(string: url)!)
        let task = session.dataTask(with: UrlRequest) {(data, response, error) in
            
            ViewControllerUtils().hideActivityIndicator(uiView: self.collectionView)
            do {
                let r = try JSONSerialization.jsonObject(with: data!, options: []) as! Array<NSDictionary>
                self.airlines = [Airline]()
                
                for dict in r as! [[String: AnyObject]] {
                    let airline = Airline()
                    airline.defaultName = dict["defaultName"] as? String
                    airline.logoURL = dict["logoURL"] as? String
                    airline.phone = dict["phone"] as? String
                    airline.site = dict["site"] as? String
                    airline.code = dict["code"] as? String
                    
                    self.airlines?.append(airline)
                }

                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
                
            } catch {
                print("network error")
                return
            }
        }
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 30, height:    view.frame.height))
        titleLabel.text = "Airline"
        navigationItem.titleView = titleLabel
        ViewControllerUtils().showActivityIndicator(uiView: collectionView)
        fetchAirlines()
        collectionView.backgroundColor = .white
        collectionView.register(AirlineItemCell.self, forCellWithReuseIdentifier: "homeCell")
        collectionView.register(AirlineItemGridCell.self, forCellWithReuseIdentifier: "gridCell")
        setLayoutButton()
        
    }
    
    func setLayoutButton() {
        let layoutImage = UIImage(named: "list")?.withRenderingMode(.alwaysOriginal)
        let layoutButton = UIBarButtonItem(image: layoutImage, style: .plain, target: self, action:  #selector(changeLayout))
        navigationItem.rightBarButtonItem = layoutButton
    }
    
    @objc func changeLayout(){
        let listLayout = UICollectionViewFlowLayout()
        listLayout.itemSize = CGSize(width: view.frame.width, height: 100)
        
        let gridLayout = UICollectionViewFlowLayout()
        gridLayout.itemSize = CGSize(width: view.frame.width / 2 - 10, height: 200)
        
        if isList {
            collectionView.setCollectionViewLayout(gridLayout, animated: true, completion: { (com) in
                if com {
                    self.isList = false
                    self.collectionView.reloadData()
                    self.navigationItem.rightBarButtonItem?.image = UIImage(named: "grid")?.withRenderingMode(.alwaysOriginal)
                }
            })
            
        } else {
            collectionView.setCollectionViewLayout(listLayout, animated: true, completion: { (com) in
                if com {
                    self.isList = true
                    self.collectionView.reloadData()
                    self.navigationItem.rightBarButtonItem?.image = UIImage(named: "list")?.withRenderingMode(.alwaysOriginal)
                }
            })
            
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return airlines?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isList {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! AirlineItemCell
            cell.airline = airlines?[indexPath.item]
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridCell", for: indexPath) as! AirlineItemGridCell
            cell.airline = airlines?[indexPath.item]
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
            return cell
        }

    }

    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        if let index = indexPath {
            let detailController = DetailController()
            detailController.airline = airlines?[index[1]]
            self.navigationController?.pushViewController(detailController, animated: true)
        }
    }
    
    
}

