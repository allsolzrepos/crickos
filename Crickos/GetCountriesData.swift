//
//  GetCountriesData.swift
//
//  Created by Agha Asad Hussain on 11/15/22.
//

import SwiftUI

struct GetCountriesData_Previews: PreviewProvider {
    static var previews: some View {
        GetCountriesData()
    }
}


struct GetCountriesData: View {
    @State var countries = [Country]()
    @State private var dataObj = [DataObj]()

    //var mcountries: callURL

    var body: some View {
        NavigationView {
            List(countries) { country in
                        VStack(alignment: .leading) {
                            Text(country.name)
                                .font(.headline)
                            NavigationLink{
                                TeamDetail(team: country)
                            } label: {
                                AsyncImage(
                                    url: URL(string: country.image_path)!,
                                    placeholder: { Text("Loading ...") },
                                    image: { Image(uiImage: $0).resizable() }
                                ).frame(width: 200,height: 100, alignment: .center)
                            }

                        }
            }
            .navigationTitle("Countries")
        }
        .task
        {            
            do
            {
                let url =
                URL(string: "https://cricket.sportmonks.com/api/v2.0/countries?api_token=Kgq86V2HeGjmLAgMKAMoBOltQqtAr3jaSyAQaxH2DQ4ZdkdMyEWyeQy613ct")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let _ = print(data.description)
                let tempObj = try JSONDecoder().decode(DataModel.self, from: data)
                countries = tempObj.data
                var _: String = ""
            } catch
            {
                countries = []
            }
        }
        
    }
    
}
