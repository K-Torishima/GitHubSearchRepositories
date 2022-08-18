//
//  APIServiceImpl.swift
//  GitHubSearchRepositories
//
//  Created by Koji Torishima on 2022/08/18.
//

import Foundation

final class APIServiceImpl: APIService {

    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: RequestProtocol>(_ request: T) async throws -> T.Response {
        return try await withCheckedThrowingContinuation { continuation in
            let url = request.baseURL.appendingPathComponent(request.path)
            // components
            guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                continuation.resume(with: .failure(APIError.failedToCreateComponents(url)))
                return
            }
            // set Parameter
            components.queryItems = request.parameters.compactMap(URLQueryItem.init)
            guard var urlRequest = components.url.map ({ URLRequest(url: $0) }) else {
                continuation.resume(with: .failure(APIError.failedToCreateURL(components)))
                return
            }
            // set httpMethod
            urlRequest.httpMethod = request.method.rawValue
            if let body = request.body {
                urlRequest.httpBody = body
            }
            
            // set header
            urlRequest.allHTTPHeaderFields = request.createHeders()
            
            // session.dataTask
            let task = session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    continuation.resume(with: .failure(error))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    continuation.resume(with: .failure(APIError.noResponse))
                    return
                }
                
                guard let data = data else {
                    continuation.resume(with: .failure(APIError.noData(response)))
                    return
                }
                
                guard 200..<300 ~= response.statusCode else {
                    let message = try? JSONDecoder().decode(APIError.Message.self, from: data)
                    continuation.resume(with: .failure(APIError.unacceptableStatusCode(response.statusCode, message)))
                    return
                }
                
                do {
                    let object = try JSONDecoder().decode(T.Response.self, from: data)
                    continuation.resume(with: .success(object))
                } catch {
                    continuation.resume(with: .failure(error))
                }
            }
            task.resume()
        }
    }
}
