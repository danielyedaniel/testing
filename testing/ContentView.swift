//
//  ContentView.swift
//  testing
//
//  Created by Daniel Ye on 2023-01-03.
//

import SwiftUI

import Foundation

struct ContentView: View {
    @State private var response: String = ""

    var body: some View {
        VStack {
            Text("Response: \(response)")
            Button(action: sendPostRequest) {
                Text("Send POST request")
            }
        }
    }

    func sendPostRequest() {
        let url = URL(string: "https://www.wangevan.com/user/login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let postData = [
            "email": "testuser@gmail.com",
            "password": "testpassword"
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: postData)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                self.response = "Error: \(error)"
                return
            }
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                self.response = dataString
            }
        }.resume()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
