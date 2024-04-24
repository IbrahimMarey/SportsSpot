//
//  FavoutieViewController.swift
//  SportsSpot
//
//  Created by AYA on 24/04/2024.
//

import UIKit
import SDWebImage

class FavoutieViewController: UIViewController,UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var appBar: CustomAppBar!
    
    var serviceDataBase:CoreDataProtocol = CoreDataImple.shared
    var showFavourites = [MyLeagueDto]()
    var leaguesList = [MyLeagueDto]()
    var leagueTest : MyLeagueDto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
       // serviceDataBase.insertLeague(League: leagueTest!)
        print("Test leage \(leagueTest?.country_name)\n")
        leaguesList = serviceDataBase.fetchingData()
        //leaguesList.append(leagueTest!)
        showFavourites = leaguesList
    }
    func setup(){
       // Bundle.main.loadNibNamed("CustomAppBar", owner: self)
       // self.addChild(UI)
        let cellNib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
        
        appBar.backBtn.isHidden = true
        appBar.titleLabel.text = "Favourites"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchTF.delegate = self
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell
        cell.leagueLabel?.text = showFavourites[indexPath.row].league_name
        cell.leageuImage.sd_setImage(with: URL(string: showFavourites[indexPath.row].league_logo!),placeholderImage: UIImage(named: "images"))
        //cell.separatorInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)

        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showFavourites.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favourite"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
