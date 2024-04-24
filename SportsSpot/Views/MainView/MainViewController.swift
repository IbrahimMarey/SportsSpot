//
//  MainViewController.swift
//  SportsSpot
//
//  Created by Khokha on 22/04/2024.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth : CGFloat = 170
          let itemHeight: CGFloat = 180
          return CGSize(width: itemWidth, height: itemHeight)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }
    
    let sportTypeList = ["Football", "Basktball", "Tennis", "Cricket"]
      let sportTypeListImage = ["Football", "Basktball", "Tennis", "Cricket"]
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
            sportCollectionView.register(UINib(nibName: "MainViewCell", bundle: nil), forCellWithReuseIdentifier: "sportCell")
            
            self.sportCollectionView.dataSource = self
            self.sportCollectionView.delegate = self
        
        
        let calendar = Calendar.current
        let currentDate = Date()
        let modifiedDate = calendar.date(byAdding: .day, value: -3, to: currentDate)
        Network.shared.fetchFixtures(sport: "football",from: nil){[weak self] resulte in
            
            guard let self = self else {return}
            switch resulte {
                
            case .success(let done):
                print("el hussin hena ")
                print(done.result?[0].country_name)
            case .failure(let err):
                print(err.localizedDescription)
            }
            
        }
    }

    @IBAction func btn(_ sender: Any) {
        print("sab7")
        let testNav = TestNavViewController()
        
        //self.navigationController?.pushViewController(testNav, animated: true)
    }
}
