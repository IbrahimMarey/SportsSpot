//
//  FavouriteTableView.swift
//  SportsSpot
//
//  Created by AYA on 24/04/2024.
//

import Foundation
import UIKit

extension FavoutieViewController : UITableViewDelegate{
    
}
extension FavoutieViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = (searchTF.text ?? "") + string
        
        showFavourites = leaguesList.filter({ i in
            i.league_name!.lowercased().contains(currentText.lowercased())
        })
        
        print("current text \(currentText)")
        self.tableView.reloadData()
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        showFavourites = leaguesList
        tableView.reloadData()
        return true
    }
}
