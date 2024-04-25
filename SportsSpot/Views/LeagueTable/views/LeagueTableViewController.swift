//
//  LeagueTableViewController.swift
//  SportsSpot
//
//  Created by Khokha on 25/04/2024.
//

import UIKit
import SDWebImage
class LeagueTableViewController: UITableViewController , LeagueProtocal{
    var sport: String?
    func failure(msg: String) {
        indicator.stopAnimating()
    }
    func featchLeague(leagues: [MyLeagueDto]) {
        self.leagues = leagues
        DispatchQueue.main.async{
            self.tableView.reloadData()
            self.indicator.stopAnimating()
        }
    }
    
        
    var leagues : [MyLeagueDto] = []
    var indicator = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.startAnimating()
        let presenter = LeaguePresenter()
        presenter.featchLeague(sport: self.sport!)
        presenter.VC = self
        tableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! LeaguesTableViewCell
        cell.leagueLabel.text = leagues[indexPath.row].league_name
        cell.leageuImage.sd_setImage(with: URL(string: leagues[indexPath.row].league_logo ?? ""), placeholderImage: UIImage(named: "Football"))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
