//
//  PackNetworking.swift
//  InPost Interview Coding Task
//
//  Created by Damian Piwowarski on 04/11/2022.
//

import Foundation

public class PackNetworking {

    public init() { }

    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    public func getPacks(completion: @escaping (Result<[Pack], Error>) -> Void) {
        let url = Bundle.module.url(forResource: "packs", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let result = try! jsonDecoder.decode([Pack].self, from: data)
        completion(.success(result))
    }

}
