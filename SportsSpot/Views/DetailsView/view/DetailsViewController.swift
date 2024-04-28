//
//  DetailsViewController.swift
//  SportsSpot
//
//  Created by AYA on 27/04/2024.
//

import UIKit

class DetailsViewController: UIViewController{
    let presenter = DetailsPresenter()
    
    var league : MyLeagueDto?
    
    var upComingMatches = [FixturesDto]()
    var latestMatches = [FixturesDto]()
    var teamsList = [TeamDto]()
    
    var indicator = UIActivityIndicatorView(style: .large)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var appBar: CustomAppBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        appBar.titleLabel.text = league?.league_name ?? "Details"
        
        setUp()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        setUpLayouts()
        
        //print("Sports name \(sport) and league key is \(leagueInfo?.league_key)")
        callForData()
    }
    override func viewWillAppear(_ animated: Bool) {
        if presenter.isLeagueFavourite(league: league!){
            self.appBar.favouriteBtn.setImage(UIImage(named: "fav_filled"), for: .normal)
        }else{
            self.appBar.favouriteBtn.setImage(UIImage(named: "fav_outLine"), for: .normal)

        }
    }
    
    func setUp(){
        collectionView.register(UINib(nibName: "MatchesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "matchesCell")
        collectionView.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        appBar.backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        appBar.favouriteBtn.addTarget(self, action: #selector(favouriteBtn), for: .touchUpInside)
    }
    
    func setUpLayouts(){
        let layout = UICollectionViewCompositionalLayout{ sectionIndex, enviroment in
                switch sectionIndex{
                    case 0:
                    return self.upComingSection()
                    case 1:
                    return self.latestMatchSection()
                    case 2:
                    return self.teamsSection()
                default:
                    return nil
                }
            }
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func upComingSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
    
    func latestMatchSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.17))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
           
           let section = NSCollectionLayoutSection(group: group)
           section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)
           //section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    func teamsSection()-> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                , heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(150)
        , heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize
        , subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
        , bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
        , bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        
        return section
    }
    
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func favouriteBtn(){
        guard let league = league else {
            print("league info nil")
            return
        }
        //league = MyLeagueDto(league_key: leagueInfo.league_key, league_name: leagueInfo.league_name, country_key: leagueInfo.country_key, country_name: leagueInfo.country_name, league_logo: leagueInfo.league_logo, country_logo: leagueInfo.country_logo, sportName: sport)
        var alert: UIAlertController?
        if presenter.isLeagueFavourite(league: league){
          alert = Util.createAlert(alertTitle: "Favourite", alertMessage: "Do you want to remove this item from favoutite?", btnTitle: "Yes") {
               self.appBar.favouriteBtn.setImage(UIImage(named: "fav_outLine"), for: .normal)
              
              self.presenter.deleteFromFavourite(league: self.league!)
           }
            
        }else{
             alert = Util.createAlert(alertTitle: "Favourite", alertMessage: "Do you want to add this item to favoutite?", btnTitle: "Yes") {
                self.appBar.favouriteBtn.setImage(UIImage(named: "fav_filled"), for: .normal)
                 self.presenter.insertToCoreData(leagueInfo: self.league!)
            }
        }
        if let alert = alert {
            self.present(alert, animated: true, completion: nil)
        }
    }
}


extension DetailsViewController: DetailsProtocol{
    func fetchUpCommingMatches(sports: [FixturesDto]) {
        print("Sport count details \(sports.count)\n")
        self.upComingMatches = sports;
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
    }
    
    func failure(msg: String) {
        print("Failed\n")
        
    }
    
    func fetchLatestMatches(sports:[FixturesDto]) {
        print("Sport count details \(sports.count)\n")
        self.latestMatches = sports;
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
    }
    
    func fetchTeams(teams:[TeamDto]) {
        self.teamsList = teams
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
    }
    func callForData(){
        
        presenter.attachView(v: self)
        presenter.fetchUpcomingMatches(sport:league?.sportName?.lowercased() ?? "football",leagueId:(league?.league_key!)!)
        presenter.fetchLatestMatches(sport: league!.sportName!.lowercased(), leagueId: (league?.league_key!)!)
        presenter.fetchLeagueTeams(sport: league!.sportName!.lowercased(), leagueId: (league?.league_key!)!)
    }
    
}
