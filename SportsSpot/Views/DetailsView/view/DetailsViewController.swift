//
//  DetailsViewController.swift
//  SportsSpot
//
//  Created by AYA on 27/04/2024.
//

import UIKit
import PKHUD

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
        
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        appBar.backBtn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        appBar.favouriteBtn.addTarget(self, action: #selector(favouriteBtn), for: .touchUpInside)
        
        indicator.center = view.center
        indicator.color = UIColor.blue
        view.addSubview(indicator)
        indicator.startAnimating()
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           guard kind == UICollectionView.elementKindSectionHeader else {
               return UICollectionReusableView()
           }
           
           let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! SectionHeaderView
           
           // Customize the header view based on the section
           switch indexPath.section {
           case 0:
               if upComingMatches.count == 0{
                   headerView.titleLabel.text = "No Upcoming Matches"
               }else{
                   headerView.titleLabel.text = "Upcoming Matches"
               }
           case 1:
               if latestMatches.count == 0 {
                   headerView.titleLabel.text = "No Latest Matches"

               }else{
                   headerView.titleLabel.text = "Latest Matches"
               }
           case 2:
               if teamsList.count == 0 {
                   headerView.titleLabel.text = "No Teams"
               }else{
                   headerView.titleLabel.text = "Teams"
               }
           default:
               headerView.titleLabel.text = ""
           }
           
           return headerView
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.bounds.width, height: 50)
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

        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                        
                        section.boundarySupplementaryItems = [headerSupplementary]
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
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                        
                        section.boundarySupplementaryItems = [headerSupplementary]
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
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                        let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                        
                        section.boundarySupplementaryItems = [headerSupplementary]
        return section
    }
    
    @objc func goBack(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func favouriteBtn(){
        guard let league = league else {
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
        self.upComingMatches = sports;
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
        self.indicator.stopAnimating()

    }
    
    func failure(msg: String) {
        DispatchQueue.main.async {
            PKHUD.sharedHUD.contentView = PKHUDTextView(text: msg)
            PKHUD.sharedHUD.show()
            PKHUD.sharedHUD.hide(afterDelay: 2.0)
        }
        self.indicator.stopAnimating()
        
    }
    
    func fetchLatestMatches(sports:[FixturesDto]) {
        self.latestMatches = sports;
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
        self.indicator.stopAnimating()
    }
    
    func fetchTeams(teams:[TeamDto]) {
        self.teamsList = teams
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
        self.indicator.stopAnimating()

    }
    func callForData(){
        
        presenter.attachView(v: self)
        presenter.fetchUpcomingMatches(sport:league?.sportName?.lowercased() ?? "football",leagueId:(league?.league_key!)!)
        presenter.fetchLatestMatches(sport: league!.sportName!.lowercased(), leagueId: (league?.league_key!)!)
        presenter.fetchLeagueTeams(sport: league!.sportName!.lowercased(), leagueId: (league?.league_key!)!)
    }
    
}
