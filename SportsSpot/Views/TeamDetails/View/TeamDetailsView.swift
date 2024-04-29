//
//  TeamDetailsView.swift
//  SportsSpot
//
//  Created by Khokha on 28/04/2024.
//

import UIKit

class TeamDetailsView: UIViewController, TeamDetailsProtocal {
    var players = [Player]()
    var coaches = [CoachDto]()
    @IBOutlet weak var appBar: CustomAppBar!
    var sport: String?
    
    @IBOutlet weak var tableView: UITableView!
    var teamId: Int?
    
    func featchTeamDetails(team: TeamDto) {
        //print(team.teamName!)
        //print(team.teamKey!)
        //print(team.teamLogo!)
        players = team.players ?? []
        coaches = team.coaches ?? []
        self.tableView.reloadData()
    }
    
    func failure(msg: String) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        let presenter = TeamDetailsPresenter()
        presenter.VC = self
        presenter.featchLeague(sport: sport!, teamId: teamId!)
        
        appBar.titleLabel.text = "Team Details"
        appBar.favouriteBtn.isHidden = true
        appBar.backBtn.addTarget(self, action: #selector(goBack) , for: .touchUpInside)
    }
    
    func setUp(){
        let cellNib = UINib(nibName: "LeaguesTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension TeamDetailsView : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return coaches.count
        case 1:
            return players.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesTableViewCell
        switch indexPath.section{
        case 0:
            let coach = coaches[indexPath.row]
            cell.leagueLabel.text = coach.coachName
        case 1:
            let player = players[indexPath.row]
            cell.leagueLabel.text = player.playerName
            if let playerImage = player.playerImage{
                cell.leageuImage.sd_setImage(with: URL(string: playerImage), placeholderImage: UIImage(named: "football"))
            }else{
                cell.leageuImage.image = UIImage(named: "football")
            }
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Coaches"
        case 1:
            return "Players"
        default:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
