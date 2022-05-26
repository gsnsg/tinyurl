//
//  AllMappingsView.swift
//  tiny_url_client
//
//  Created by Sai Nikhit Gulla on 26/05/22.
//

import SwiftUI
import CoreData

struct AllMappingsView: View {
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.timestamp, order: .reverse)
    ]) var mappings: FetchedResults<UrlMapping>
    
    var body: some View {
        VStack {
            ForEach(mappings, id: \.timestamp) { mapping  in
                if let shortUrl = mapping.shortUrl,
                   let longUrl = mapping.longUrl,
                   let timestamp = mapping.timestamp {
                    RowView(shortUrl: shortUrl, longUrl: longUrl, createdAt: timestamp)
                        .padding(.vertical, 20)
                }
            }
        }
        Spacer()
    }
}

struct RowView: View {
    let shortUrl: String
    let longUrl: String
    let createdAt: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Short Link")
            Link(destination: URL(string: shortUrl)!) {
                Text(shortUrl)
            }.padding(.bottom, 10)
            Text("Original Link")
            Link(destination: URL(string: longUrl)!) {
                Text(longUrl)
            }.padding(.bottom, 10)
            Text("Created at: \(formattedDate(date: createdAt))\n\n")
        }
        .padding(.horizontal, 10)
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.blue, lineWidth: 1))
    }
    
    private func formattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}

struct AllMappingsView_Previews: PreviewProvider {
    static var previews: some View {
        AllMappingsView()
    }
}
