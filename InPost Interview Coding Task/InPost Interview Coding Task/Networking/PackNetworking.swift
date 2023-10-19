//
//  PackNetworking.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 04/11/2022.
//

import Foundation

class PackNetworking {
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func getPacks(completion: @escaping (Result<[Pack], Error>) -> Void) {
        let url = Bundle.main.url(forResource: "packs", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let result = try! jsonDecoder.decode([Pack].self, from: data)
        completion(.success(result))
    }
    
}
