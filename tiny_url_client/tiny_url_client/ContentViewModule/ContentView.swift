//
//  ContentView.swift
//  tiny_url_client
//
//  Created by Sai Nikhit Gulla on 26/05/22.
//

import SwiftUI
import Combine
import CoreData


struct ContentView: View {
   @StateObject var vm = ContentViewVM()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter or Paste your url here", text: $vm.urlString)
                    .font(Font.system(size: 14))
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, lineWidth: 1))
                
                if vm.shortUrl != nil {
                    Link(vm.shortUrl!, destination: URL(string: vm.shortUrl!)!)
                }
                
                Button(action: {
                    vm.generateShortUrl()
                }) {
                    Text("Generate Short Url")
                        .font(.system(size: 20, weight: .regular))
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .foregroundColor(.white)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }.disabled(vm.isButtonDisabled)
                    .padding(.top, 20)
                
            }
            .alert(vm.errorMessage, isPresented: $vm.showAlert, actions: {})
            .padding()
            .navigationTitle(Text("Url Shortener 🔗"))
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
