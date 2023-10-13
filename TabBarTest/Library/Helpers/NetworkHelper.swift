//
//  NetworkHelper.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.10.2023.
//

import Foundation

struct ModelForRequest {
    var country: String
    var city: String?
    var typeRequest: TypeRequest?
}

enum TypeRequest: String {
    // Запрос достопримечательности
    // http://api.apptravel.ru/data/sight?key=1Mpz0qVaff832vVAqrLVvz4H&country=Россия&city=Москва&availableCountry=true&availableCity=true
    case sight = "sight"
    
    // Запрос описания города по стране
    // http://api.apptravel.ru/data/city?key=1Mpz0qVaff832vVAqrLVvz4H&country=Россия&city=Москва&availableCountry=true&availableCity=true
    case cityAll = "city"
    
    // Запрос описания тестовых данных всех стран
    // http://api.apptravel.ru/data/city-country-info?key=1Mpz0qVaff832vVAqrLVvz4H&country=Россия
    case cityCountryInfo = "city-country-info"
    
    // Запрос на интересные события
    // http://api.apptravel.ru/data/event?key=1Mpz0qVaff832vVAqrLVvz4H&country=Россия&city=Москва
    case events = "event"
    
    // Запрос на вопросы и ответ
    // http://api.apptravel.ru/data/faq?key=1Mpz0qVaff832vVAqrLVvz4H&country=Россия&city=Москва
    case faq = "faq"
}

class NetworkHelper {
    
    // MARK: - Public properties
    
    static let shared = NetworkHelper()
    
    
    // MARK: - Private properties
    
    private init() {}
    
    private let apiKey = "1Mpz0qVaff832vVAqrLVvz4H"
    private let httpMethod = "GET"
    private let session = URLSession(configuration: .default)
    private let urlParent = "http://api.apptravel.ru/data/"
    
    private var sight: [Sight?]?
    private var allCity: [SightDescription?]?
    private var countryCityInfo: [CountryCityInfo?]?
    private var events: [Events?]?
    private var faqCity: [FAQCity?]?
    
    
    func makeRequest(type: TypeRequest, model: ModelForRequest, completion: @escaping()->()) {
        var reqModel = model
        reqModel.typeRequest = type
        
        var byte = 0
        
        switch type {
        case .sight:
            byte = UserDefaults.standard.integer(forKey: "sightData")
        case .cityAll:
            byte = UserDefaults.standard.integer(forKey: "cityAllData")
        case .cityCountryInfo:
            byte = UserDefaults.standard.integer(forKey: "cityCountryInfoData")
        case .events:
            byte = UserDefaults.standard.integer(forKey: "eventsData")
        case .faq:
            byte = UserDefaults.standard.integer(forKey: "FAQCityData")
        }

        // MARK: - TODO
        // Проверка на байты, нужно доделывать с бэком
        
        if byte == 0 {
            sendRequestToServer(model: reqModel) {
                completion()
            }
        } else {
            completion()
        }
    }
    
    private func sendRequestToServer(model: ModelForRequest, completion: @escaping()->()) {
        
        var queryItems: [URLQueryItem]!
        
        switch model.typeRequest! {
            
        case .sight, .cityAll:
            queryItems = [URLQueryItem(name: "country", value: "\(model.country)"),
                          URLQueryItem(name: "city", value: "\(model.city ?? "")"),
                          URLQueryItem(name: "availableCountry", value: "true"),
                          URLQueryItem(name: "availableCity", value: "true")]
            
        case .cityCountryInfo:
            queryItems = [URLQueryItem(name: "country", value: "\(model.country)")]
            
        case .events:
            queryItems = [URLQueryItem(name: "country", value: "\(model.country)"),
                          URLQueryItem(name: "city", value: "\(model.city ?? "")")]
            
        case .faq:
            queryItems = [URLQueryItem(name: "country", value: "\(model.country)"),
                          URLQueryItem(name: "city", value: "\(model.city ?? "")")]
        }
        
        
        var urlComps = URLComponents(string: urlParent + model.typeRequest!.rawValue)!
        
        urlComps.queryItems = queryItems
        var result = urlComps.url!
        result.removeAllCachedResourceValues()
        let request = NSMutableURLRequest(url: result)
        request.httpMethod = httpMethod
        
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            
            
            if let data = data {
                do {
                    switch model.typeRequest! {
                        
                    case .sight:
                        self.sight = try JSONDecoder().decode([Sight].self, from: data)
//                        print("sight:\(self.sight)")
                        UserDefaults.standard.setValue(self.sight, forKey: "sight")
                        
                    case .cityAll:
                        self.allCity = try JSONDecoder().decode([SightDescription].self, from: data)
//                        print("allCity:\(self.allCity)")
                        
                    case .cityCountryInfo:
                        self.countryCityInfo = try JSONDecoder().decode([CountryCityInfo].self, from: data)
//                        print("countryCityInfo:\(self.countryCityInfo)")
                        
                    case .events:
                        self.events = try JSONDecoder().decode([Events].self, from: data)
//                        print("events:\(String(describing: self.events))")
                        if let _events = self.events {
                            UserDefaults.standard.saveEvents(value: _events, data: data)
                        }
                        
                    case .faq:
                        self.faqCity = try JSONDecoder().decode([FAQCity].self, from: data)
//                        print("faqCity:\(String(describing: self.faqCity))")
                        
                        if let _faqCity = self.faqCity {
                            UserDefaults.standard.saveFAQCity(value: _faqCity, data: data)
                        }
                    }
                    completion()
                    
                } catch let error {
                    print("request type:\(String(describing: model.typeRequest!.rawValue)), \(String(describing: error))")
                    completion()
                }
            }
        }
        task.resume()
    }
    
}

