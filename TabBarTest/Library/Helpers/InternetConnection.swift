//
//  InternetConnection.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 30.09.2021.
//

import UIKit
import Alamofire

protocol ConnectivityDelegate {
    func lostInternetConnection()
    func goodInternetConnection()
}

//MARK: слушатель на интернет
class Connectivity {
    static let shared = Connectivity()
    
    var connectivityDelegate: ConnectivityDelegate?
    let reachabilityManager = NetworkReachabilityManager()
    
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func startNetworkReachabilityObserver() {
        reachabilityManager?.startListening(onUpdatePerforming: { (status) in
            switch status {
            case .notReachable:
                print("[startNetworkReachabilityObserver] The network is not reachable")
                self.connectivityDelegate?.lostInternetConnection()
            case .unknown :
                print("[startNetworkReachabilityObserver] It is unknown whether the network is reachable")
            case .reachable(.ethernetOrWiFi), .reachable(.cellular):
                print("Internet connection is good")
                self.connectivityDelegate?.goodInternetConnection()
            }
        })

    }
    func stopNetworkReachabilityObserver() {
        reachabilityManager?.stopListening()
    }
}

