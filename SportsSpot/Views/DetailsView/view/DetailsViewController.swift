//
//  DetailsViewController.swift
//  SportsSpot
//
//  Created by AYA on 27/04/2024.
//

import UIKit

class DetailsViewController: UIViewController, DetailsProtocol{
    
    
    var leagueInfo: MyLeagueDto?
    var sport: String?
    
    var upComingMatches = [FixturesDto]()
    var latestMatches = [FixturesDto]()
    var teamsList = [Int]()
    
    var indicator = UIActivityIndicatorView(style: .large)
    
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
    
    func fetchTeams() {
        //teamsList [TeamsModel]
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var appBar: CustomAppBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        appBar.titleLabel.text = "Details"
        
        setUp()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        setUpLayouts()
        
        print("Sports name \(sport) and league key is \(leagueInfo?.league_key)")
        callForData()
    }
    func setUp(){
        collectionView.register(UINib(nibName: "MatchesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "matchesCell")
        collectionView.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
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
    func callForData(){
        let presenter = DetailsPresenter()
        presenter.attachView(v: self)
        presenter.fetchUpcomingMatches(sport: sport!.lowercased(),leagueId:(leagueInfo?.league_key!)!)
        presenter.fetchLatestMatches(sport: sport!.lowercased(), leagueId: (leagueInfo?.league_key!)!)
    }
}
