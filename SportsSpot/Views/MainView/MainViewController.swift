//
//  MainViewController.swift
//  SportsSpot
//
//  Created by Khokha on 22/04/2024.
//

import UIKit

class MainViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout,NetworkStatusProtocol{
    
    @IBOutlet weak var bgColorView: UIView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var appBarView: UIView!
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth : CGFloat = 170
        let itemHeight: CGFloat = 240
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    let sportTypeList = ["Football", "Basketball", "Tennis", "Cricket"]
    let sportTypeListImage = ["fb", "bb", "te", "cr"]
    
    @IBOutlet weak var sportCollectionView: UICollectionView!
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportTypeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! MainViewCell
       
        cell.cellTitle.text = sportTypeList[indexPath.item]
              cell.imageCell.image = UIImage(named: sportTypeListImage[indexPath.item])
              return cell
    }
    
    var networkPresenter :NetworkManager?
    var isConnected:Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        appBarView.layer.cornerRadius = 30
        bgImage.layer.cornerRadius = 30
        bgColorView.layer.cornerRadius = 30
        // Do any additional setup after loading the view.
        sportCollectionView.register(UINib(nibName: "MainViewCell", bundle: nil), forCellWithReuseIdentifier: "sportCell")
        
        self.sportCollectionView.dataSource = self
        self.sportCollectionView.delegate = self
        
      
    }
    override func viewWillAppear(_ animated: Bool) {
        networkPresenter = NetworkManager(vc: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isConnected{
            let leagueVC = LeagueTableViewController()
            leagueVC.sport = sportTypeList[indexPath.row]
            //let vcTest = DetailsViewController()
            self.navigationController?.pushViewController(leagueVC, animated: true)
        }else{
            let alert = Util.createConnectionAlert()
            self.present(alert, animated: true)
        }
    }
    func networkStatusDidChange(connected: Bool) {
        isConnected = connected
    }
}
