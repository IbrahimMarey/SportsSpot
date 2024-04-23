//
//  MainViewController.swift
//  SportsSpot
//
//  Created by Khokha on 22/04/2024.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Network.shared.fetchLeagues {[weak self] resulte in
//            guard let self = self else {return}
//            switch resulte {
//
//            case .success(let done):
//                print(done.result?[0].country_name)
//                print("Switch is here")
//            case .failure(let err):
//                print(err.localizedDescription)
//            }
////            print( resulte)
//        }
        
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
        
        self.navigationController?.pushViewController(testNav, animated: true)
    }
}
