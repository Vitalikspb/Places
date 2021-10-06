//
//  WeatherView.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 28.09.2021.
//

import Foundation

enum Constants {
    // google map api key
    static let apiKey = "AIzaSyCT5aMIZxW2i19oK2D3VTekdAnxATzUCFU"
    
    // Weather Map Api
    static let APIKEY = "8a8dd7602db62946ca2c5ab51405a786"
    static let BASEURL = "https://api.openweathermap.org/data/2.5/weather?"
    static let weatherIconUrl = "https://openweathermap.org/img/wn/"
    static let weatherIconUrlEnd = "@2x.png"
    
    static let mapStyleJSON = """
      [
        {
          "featureType" : "poi",
          "elementType" : "all",
          "stylers" : [
            {
              "visibility" : "off"
            }
          ]
        },
        {
          "featureType" : "transit",
          "elementType" : "all",
          "stylers" : [
            {
              "visibility" : "off"
            }
          ]
        }
      ]
      """
}
