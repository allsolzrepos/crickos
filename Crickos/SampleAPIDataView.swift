//
//  SampleAPIDataView.swift
//
//  Created by Agha Asad Hussain on 11/15/22.
//

import SwiftUI

//struct SampleAPIDataView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}

struct SampleAPIDataView_Previews: PreviewProvider {
    static var previews: some View {
        SampleAPIDataView()
    }
}

struct Message: Decodable, Identifiable {
    let id: Int
    let from: String
    let text: String
}

struct SampleAPIDataView: View {
    @State private var messages = [Message]()

    var body: some View {
        NavigationView {
            List(messages) { message in
                VStack(alignment: .leading) {
                    Text(message.from)
                        .font(.headline)
                    Text(message.text)
                }
            }
            .navigationTitle("Inbox")
        }
        .task {
            do {
                let url = URL(string: "https://www.hackingwithswift.com/samples/messages.json")!
                let (data, _) = try await URLSession.shared.data(from: url)
                messages = try JSONDecoder().decode([Message].self, from: data)
            } catch {
                messages = []
            }
        }
    }
}
