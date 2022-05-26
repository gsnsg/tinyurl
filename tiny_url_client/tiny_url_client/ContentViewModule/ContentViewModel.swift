//
//  ContentViewModel.swift
//  tiny_url_client
//
//  Created by Sai Nikhit Gulla on 26/05/22.
//

import SwiftUI
import Combine
import CoreData

struct Response: Decodable {
    var short_url: String
    var message: String
}

class ContentViewVM: ObservableObject {
    @Published var urlString: String = "";
    @Published var isButtonDisabled: Bool = true
    
    @Published var showProgess: Bool = false
    @Published var errorMessage: String = ""
    @Published var showAlert: Bool = false
    
    @Published var shortUrl: String?
    
    private var cancellables = Set<AnyCancellable>();
    
    private let deviceId = UIDevice.current.identifierForVendor!.uuidString
    
    init() {
        $urlString
            .receive(on: RunLoop.main)
            .sink { [weak self] newVal in
                self?.shortUrl = nil
                self?.isButtonDisabled = newVal.isEmpty
            }
            .store(in: &cancellables)
    }
    
    func generateShortUrl(with context: NSManagedObjectContext) {
        guard let url = URL(string: "http://localhost:9098/create-short-url") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "long_url": urlString.lowercased(),
            "user_id": deviceId
        ]
        
        let bodyData = try? JSONSerialization.data(
            withJSONObject: parameters,
            options: []
        )
        
        request.httpBody = bodyData
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, err in
            guard let `self` = self else { return }
            
            guard let httpResponse = response as? HTTPURLResponse else { return }
            
            if httpResponse.statusCode == 200, let data = data {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        self.shortUrl = response.short_url
                        self.saveMapping(originalUrl: self.urlString, shortUrl: response.short_url, with: context)
                    }
                } catch {
                    // do something
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.errorMessage = "Unknown Error Occured, Status Code: \(httpResponse.statusCode)"
                }
            }
        }
        .resume()
    }
    
    private func saveMapping(originalUrl: String, shortUrl: String, with context: NSManagedObjectContext) {
        let newMapping = UrlMapping(context: context)
        newMapping.longUrl = originalUrl
        newMapping.shortUrl = shortUrl
        newMapping.timestamp = Date.now
        do {
            try context.save()
        } catch {
            print("Error Savings in CoreData: \(error)")
        }
    }
}
