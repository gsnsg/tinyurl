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
        ScrollView {
            VStack {
                ForEach(mappings, id: \.timestamp) { mapping  in
                    if let shortUrl = mapping.shortUrl,
                       let longUrl = mapping.longUrl,
                       let timestamp = mapping.timestamp {
                        RowView(shortUrl: shortUrl, longUrl: longUrl, createdAt: timestamp)
                    }
                }
            }
        }
    }
}

struct RowView: View {
    let shortUrl: String
    let longUrl: String
    let createdAt: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Short Link").fontWeight(.semibold)
                    .padding(.top, 15)
                Link(destination: URL(string: shortUrl)!) {
                    Text(shortUrl)
                }.padding(.bottom, 10)
                Text("Original Link").fontWeight(.semibold)
                Link(destination: URL(string: longUrl)!) {
                    Text(longUrl).lineLimit(0)
                }.padding(.bottom, 10)
                Text("Created at: \(formattedDate(date: createdAt))")
                    .padding(.bottom, 15)
            }
            .padding(.horizontal, 10)
            Spacer()
        }
        .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.black, lineWidth: 1))
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 10)
        .padding(.vertical, 20)
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
