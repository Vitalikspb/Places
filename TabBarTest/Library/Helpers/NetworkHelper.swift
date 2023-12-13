//
//  NetworkHelper.swift
//  TabBarTest
//
//  Created by VITALIY SVIRIDOV on 13.10.2023.
//

import UIKit

struct ModelForRequest {
    var country: String
    var city: String?
    var typeRequest: TypeRequest?
}

enum TypeRequest: String {
    /// Запрос достопримечательности
    // http://api.apptravel.ru/data/sight?key=1Mpz0qVaff832vVAqrLVvz4H&country=Россия&city=Москва&availableCountry=true&availableCity=true
    case sight = "sight"
    
    /// Запрос описании города для стране
    // http://api.apptravel.ru/data/city?key=1Mpz0qVaff832vVAqrLVvz4H&country=Россия&city=Москва&availableCountry=true&availableCity=true
    case cityAll = "city"
    
    /// Запрос инфы о городе
    // http://api.apptravel.ru/data/city-country-info?key=1Mpz0qVaff832vVAqrLVvz4H&country=Россия
    case cityCountryInfo = "city-country-info"
    
    /// Запрос на интересные события
    // http://api.apptravel.ru/data/event?key=1Mpz0qVaff832vVAqrLVvz4H&country=Россия&city=Москва
    case events = "event"
    
    /// Запрос на вопросы и ответ
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
    
    private var sight: [SightResponse?]?
    private var allCity: [SightDescriptionResponse?]?
    private var countryCityInfo: [CountryCityInfo?]?
    private var events: [EventsResponce?]?
    private var faqCity: [FAQCity?]?
    
    
    func downloadAllRequest() {
        makeRequest(type: .cityAll, model: .init(country: "Россия")) {
            print("download .cityAll")
        }
        makeRequest(type: .cityCountryInfo, model: .init(country: "Россия")) {
            print("download .cityCountryInfo")
        }
        makeRequest(type: .sight, model: .init(country: "Россия")) {
            print("download .sight")
        }
        
    }
    
    func makeRequest(type: TypeRequest, model: ModelForRequest, completion: @escaping()->()) {
        var reqModel = model
        reqModel.typeRequest = type
        sendRequestToServer(model: reqModel)
    }
    
    private func sendRequestToServer(model: ModelForRequest) {
        
        var queryItems: [URLQueryItem]!
        
        switch model.typeRequest! {
            
        case .sight, .cityAll:
            queryItems = [URLQueryItem(name: "country", value: "Россия"),
                          URLQueryItem(name: "city", value: "\(model.city ?? "")"),
                          URLQueryItem(name: "availableCountry", value: "true"),
                          URLQueryItem(name: "availableCity", value: "true")]
            
        case .cityCountryInfo:
            queryItems = [URLQueryItem(name: "country", value: "Россия")]
            
        case .events:
            queryItems = [URLQueryItem(name: "country", value: "Россия"),
                          URLQueryItem(name: "city", value: "\(model.city ?? "")")]
            
        case .faq:
            queryItems = [URLQueryItem(name: "country", value: "Россия"),
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
                        
                        // MARK: - Загрузка достопримечательностей
                        
                    case .sight:
                        self.sight = try JSONDecoder().decode([SightResponse].self, from: data)
                        if let _sight = self.sight {
//                            print("sight:\(_sight)")
                            var tempAllCountry = [Sight?]()
                            _sight.forEach {
                                tempAllCountry.append(Sight(id: $0?.id ?? 0,
                                                            name: $0?.name ?? "",
                                                            country: $0?.country ?? "",
                                                            city: $0?.city ?? "",
                                                            type: $0?.type ?? .sightSeen,
                                                            category: $0?.category ?? .mustSee,
                                                            rating: $0?.rating ?? "",
                                                            latitude: $0?.latitude ?? 0.0,
                                                            longitude: $0?.longitude ?? 0.0,
                                                            address: $0?.address ?? "",
                                                            test: $0?.test ?? false,
                                                            big_image: self.decodeImage(image: $0?.big_image ?? ""),
                                                            small_image: self.decodeImage(image: $0?.small_image ?? ""),
                                                            images: self.decodeImages(images: $0?.images?["image"]), 
                                                            favorite: "AddtofavoritesUnselected"))
                            }
                            UserDefaults.standard.saveSight(value: tempAllCountry, data: data)
                        }
                        
                        
                        // MARK: - Запрос описании города для стране
                        
                    case .cityAll:
                        self.allCity = try JSONDecoder().decode([SightDescriptionResponse].self, from: data)
                        if let _allCountry = self.allCity {
//                            print("allCity:\(_allCountry)")
                            var tempAllCountry = [SightDescriptionResponce?]()
                            _allCountry.forEach {
                                tempAllCountry.append(SightDescriptionResponce(
                                    id: $0?.id ?? 0,
                                    name: $0?.name ?? "",
                                    description: $0?.description ?? "",
                                    price: $0?.price  ?? 0,
                                    sight_count: $0?.sight_count ?? 0,
                                    latitude: $0?.latitude ?? 0.0,
                                    longitude: $0?.longitude ?? 0.0,
                                    images: self.decodeImages(images: $0?.images?["image"])))
                            }
                            UserDefaults.standard.saveAllCity(value: tempAllCountry, data: data)
                        }
                        
                        
                        // MARK: - Заx
                    case .cityCountryInfo:
                        self.countryCityInfo = try JSONDecoder().decode([CountryCityInfo].self, from: data)
                        if let _countryCityInfo = self.countryCityInfo {
//                            print("countryCityInfo:\(_countryCityInfo)")
                            UserDefaults.standard.saveCityCountryInfo(value: _countryCityInfo, data: data)
                        }
                        
                        
                        // MARK: - загрузка интересныз событий
                        
                    case .events:
                        self.events = try JSONDecoder().decode([EventsResponce].self, from: data)
                        if let _events = self.events {
//                            print("_events:\(_events)")
                            var tempEvents = [Events?]()
                            _events.forEach { itemEvent in
                                let tempStringImages = self.decodeImages(images: itemEvent?.images?["image"])
                                tempEvents.append(Events(id: itemEvent?.id ?? 0,
                                                         name: itemEvent?.name ?? "",
                                                         description: itemEvent?.description ?? "",
                                                         country: itemEvent?.country ?? "",
                                                         images: tempStringImages,
                                                         city: itemEvent?.city ?? "",
                                                         date: itemEvent?.date ?? ""))
                                UserDefaults.standard.saveEvents(value: tempEvents, data: data)
                            }
                        }
                        
                        
                        // MARK: - Вопросов и ответов
                        
                    case .faq:
                        self.faqCity = try JSONDecoder().decode([FAQCity].self, from: data)
                        if let _faqCity = self.faqCity {
//                            print("_faqCity:\(_faqCity)")
                            UserDefaults.standard.saveFAQCity(value: _faqCity, data: data)
                        }
                    }
                    
                    
                } catch let error {
                    print("request type:\(String(describing: model.typeRequest!.rawValue)), \(String(describing: error))")
                }
            }
        }
        task.resume()
    }
    
    // Преобразование словаря картинок в массив картинок
    private func decodeImages(images: [ImagesArray]?) -> [String] {
        var imgArray = [String]()
//        print("images:\(images)")
        images?.forEach { imagesItem in
            var imageName = ""
            for (_,val) in imagesItem.photo.reversed().enumerated() {
                if val == "/" {
                    break
                }
                imageName += "\(val)"
            }
            imgArray.append(String(imageName.reversed()))
        }
        return imgArray
    }
    
    // Из полного пути от сервара оставляет только название фотки
    private func decodeImage(image: String) -> String {
        var imageName = ""
        print("image:\(image)")
        for (_,val) in image.reversed().enumerated() {
            if val == "/" {
                break
            }
            imageName += "\(val)"
        }
        return String(imageName.reversed())
    }
    
    // загрузка фото
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // подготовка к загрузке фото
    func downloadImage(from url: String, completion: @escaping(UIImage)->()) {
        var urlString = "http://api.apptravel.ru/media/photogallery/\(url)"
        guard let URL = URL(string: urlString) else { return }
        getData(from: URL) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                completion(UIImage(data: data) ?? UIImage())
            }
        }
    }
    
}

