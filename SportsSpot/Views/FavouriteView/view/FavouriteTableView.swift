//
//  FavouriteTableView.swift
//  SportsSpot
//
//  Created by AYA on 24/04/2024.
//

import Foundation
import UIKit

extension FavoutieViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isConnected{
            let detailVC = DetailsViewController()
            detailVC.league = leaguesList![indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }else{
            let alert = Util.createConnectionAlert()
            self.present(alert, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let alert = Util.createAlert(alertTitle: "Delete", alertMessage: "Are you sure you want to delete this item from favourite?", btnTitle: "Yes") {
                self.presenter.deleteFromCoreData(league: self.leaguesList![indexPath.row])
                                
            }
            self.present(alert, animated: true)
        }
        
    }
    
}
extension FavoutieViewController : UITextFieldDelegate,NetworkStatusProtocol{
    func networkStatusDidChange(connected: Bool) {
        isConnected = connected
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = (searchTF.text ?? "") + string
        
        showFavourites = leaguesList?.filter({ i in
            i.league_name!.lowercased().contains(currentText.lowercased())
        }) ?? []
        
        print("current text \(currentText)")
        self.tableView.reloadData()
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        showFavourites = leaguesList ?? []
        tableView.reloadData()
        return true
    }
    
}

