//
//  NetworkManager.swift
//  SportsSpot
//
//  Created by AYA on 29/04/2024.
//

import Foundation
import Reachability

protocol NetworkStatusProtocol {
    func networkStatusDidChange(connected: Bool)
}

class NetworkManager{
    let reachability = try! Reachability()
    var status:NetworkStatusProtocol?
        
    init(vc:NetworkStatusProtocol) {
        status = vc
        setUpReachability()
    }
    
    private func setUpReachability() {
            NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(notification:)), name: .reachabilityChanged, object: reachability)
            do {
                try reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        }
    @objc func reachabilityChanged(notification: Notification) {
        guard let reachability = notification.object as? Reachability else {
            return
        }

        if reachability.connection != .unavailable {
            print("Device is connected to the network")
            status?.networkStatusDidChange(connected: true)
        } else {
            print("Device is not connected to the network")
            status?.networkStatusDidChange(connected: false)
        }
    }
}
