//
//  APIClient.swift
//  StarWarsApp
//
//  Created by Josue on 1/8/19.
//  Copyright © 2019 Josue. All rights reserved.
//

import Foundation
import RxSwift

final class APIClient {

    private let session = URLSession(configuration: URLSessionConfiguration.default)
    private let baseURL: String

    init(baseURL: String) {
        self.baseURL = baseURL
    }

    func execute(_ resource: Resource) -> Observable<HTTPResponse> {

        return Observable<HTTPResponse>.create { [weak self] observer in

            guard let request = self?.buildRequest(resource) else {
                observer.onError(NetworkingError.invalidRequest)
                return Disposables.create()
            }

            let task = self?.session.dataTask(with: request) { (data, response, error) in
                observer.onNext(HTTPResponse(data, response as? HTTPURLResponse, error))
                observer.onCompleted()
            }

            task?.resume()

            return Disposables.create {
                task?.cancel()
            }
        }
    }

    func buildRequest(_ resource: Resource) -> URLRequest? {

        guard let builtURL = URL(string: baseURL),
              var components = URLComponents(url: builtURL.appendingPathComponent(resource.path),
                                             resolvingAgainstBaseURL: false)
        else {
            return nil
        }

        if let parameters = resource.parameters {
            components.queryItems = parameters.map {
                URLQueryItem(name: $0, value: $1)
            }
        }

        guard let url = components.url else {
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = resource.method.rawValue
        request.httpShouldHandleCookies = false
        request.httpShouldUsePipelining = true
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        if resource.method == .POST {
            guard let body = resource.body else {
                return nil
            }
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        }
        return request
    }

}
