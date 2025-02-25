//
//  APIClient.swift
//  GameWorld
//
//  Created by Anjar Harimurti on 16/02/25.
//

import Foundation
import Combine

protocol APIClient {
    func fetch<T: Decodable>(from endpoint: Endpoint) -> AnyPublisher<T, Error>
}

final class APIClientImpl: APIClient {
    func fetch<T: Decodable>(from endpoint: Endpoint) -> AnyPublisher<T, Error> {
        guard let url = endpoint.url else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }

                switch httpResponse.statusCode {
                case 200:
                    return data
                default:
                    throw NetworkError.invalidResponse
                }
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                }
                return NetworkError.invalidData(error)
            }
            .eraseToAnyPublisher()
    }
}
