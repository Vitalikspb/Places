//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import MapKit

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?,
                                                    _ country:  String?,
                                                    _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) {
            completion($0?.first?.locality, $0?.first?.country, $1)
        }
    }
    
    func saveCurentLocation() {
        fetchCityAndCountry { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            let userDefault = UserDefaults.standard
            print("save new location")
            userDefault.set("\(city),\(country)", forKey: UserDefaults.currentLocation)
        }
    }
    
}
