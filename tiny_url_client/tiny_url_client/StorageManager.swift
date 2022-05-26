//
//  StorageManager.swift
//  tiny_url_client
//
//  Created by Sai Nikhit Gulla on 26/05/22.
//

import Foundation

struct StorageManager {
    
    static let shared = StorageManager()
    
    private let userDefaultsKey = "shortened_links"
    
    private var mappings: [String : String] = [:]
    
    private init() {
        mappings = UserDefaults.standard.value(forKey: userDefaultsKey) as? [String : String] ?? [:]
    }
    
    func saveMapping(originalUrl: String, shortUrl: String) {
        mappings[originalUrl] = shortUrl
        UserDefaults.standard.set(mappings, forKey: userDefaultsKey)
    }
}
