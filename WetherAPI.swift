//
//  WetherAPI.swift
//  Clima
//
//  Created by Ammar Ahmed on 04/06/1445 AH.
//  Copyright © 1445 AH App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WetherAPI {
    var wetherURL="http://api.weatherapi.com/v1/"
    var appKey="f99e8da54bc047deb2071330231712"
    
    
    func getWeherByCityName(name:String?)async throws->WetherResponse{
        
        
        guard let url=URL(string:"\(wetherURL)current.json?key=\(appKey)q=\(String(describing: name))")else{fatalError("Missing URL")}
        
        let urlRequest = URLRequest(url: url)
        
        let (data,response)=try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode==200 else{fatalError("Error while fetching wether for \(String(describing: name))")}
        
        let decodedData = try JSONDecoder().decode(WetherResponse.self, from: data)
        
        return decodedData
    }
    
    struct WetherResponse :Decodable{
        var location :LocationDto
        var current:CurrentDto
        
        struct LocationDto:Decodable {
            var name:String
            var region:String
            var country:String
            var lat:String
            var lon:String
        }
        struct CurrentDto:Decodable {
            var temp_c:Float
            var condition:ConditionDto
            
            struct ConditionDto:Decodable {
                var text:String
            }
        }
        
    }

}
