//
//  ContentView.swift
//  Crickos
//
//  Created by Agha Asad Hussain on 11/17/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            GetCountriesData()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
