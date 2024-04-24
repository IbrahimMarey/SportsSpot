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
        Network.shared.fetchLeagues(sport: "football") { [weak self] result in
            guard let self = self else{return}
            switch result{
                case .success(let data):
                print(data.result?[0].league_name)
                //testNav.leagueTest = data.result?[0]
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }

    @IBAction func btn(_ sender: Any) {
        print("sab7")
        let testNav = FavoutieViewController()
        Network.shared.fetchLeagues(sport: "football") { [weak self] result in
            guard let self = self else{return}
            switch result{
                case .success(let data):
                print(data.result?[0].league_name)
                testNav.leagueTest = data.result?[0]
                print("test League home \(testNav.leagueTest?.league_key)")
                self.navigationController?.pushViewController(testNav, animated: true)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
