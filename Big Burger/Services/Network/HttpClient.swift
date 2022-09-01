//
//  HttpClient.swift
//  Big Burger
//
//  Created by emilien on 01/09/2022.
//

import Foundation

class HttpClient {
	
	// MARK: - Properties
	
	static let shared = HttpClient()
	
	// MARK: - Public
	
	/// Fetch all the datas together and returns it asynchronously.
	/// - Parameters:
	///   - completion: Callback that will be executed after the fulfillment of the request.
	func fetchDatas(_ completion: @escaping (Result<[Product]?, Error>) -> Void) async throws {
		guard let url = URL(string: "\(Constants.API_BASE)") else {
			completion(.failure(HttpErrors.invalidURL))
			return
		}
		
		URLSession.shared.dataTask(with: url) { data, _, error in
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let data = data else {
				completion(.failure(HttpErrors.missingData))
				return
			}
			
			do {
				let result = try JSONDecoder().decode([Product].self, from: data)
				completion(.success(result))
			} catch {
				completion(.failure(error))
			}
			
		}.resume()
	}
	
	/// Fetch the datas of an image based on an URL.
	/// - Parameters:
	///   - url: URL of the content that will be downloaded.
	///   - completion: Callback that will be executed after the fulfillment of the request.
	func fetchImageData(_ url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
		URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
	}
}
