//
//  TeamDetail.swift
//  Crickos
//
//  Created by Agha Asad Hussain on 11/16/22.
//

import SwiftUI

struct TeamDetail: View {
    @State var team: Country
    @State var players = [PlayerBriefInfo]()
    @State private var shouldTransit: Bool = false
    @StateObject var api = PlayerBriefInfoAPI()
    //@State private var shouldTransit: Bool = false
    //@StateObject var navSelected = NavSelection()
    
    var body: some View
    {
        NavigationView
        {
            if (!players.isEmpty){
                List(players) {
                    info in
                    VStack{
                        NavigationLink
                        {
                            //PlayerDetailView(mplayer: info)
                            //SampleData(playerData: info)
                            SampleData(playerData: info)
                        } label :{
                            HStack{
                                AsyncImage(
                                    url: URL(string: info.image_path)!,
                                    placeholder: { Text("Loading ...") },
                                    image: { Image(uiImage: $0).resizable()}
                                ).frame(width: 200,height: 100, alignment: .center)
                                Text(info.fullname)
                            }
                        }
                    }
                }.navigationTitle(team.name)
            }
            else{
                //Text("No data available").font(.headline)
            }
        }.task {
            do
            {
                let string_team_id = String(team.id)
                let url =
                URL(string: "https://cricket.sportmonks.com/api/v2.0/players?filter[country_id]=\(string_team_id)&api_token=Kgq86V2HeGjmLAgMKAMoBOltQqtAr3jaSyAQaxH2DQ4ZdkdMyEWyeQy613ct")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let _ = print(data.description)
                if(data.isEmpty){return}
                let tempObj = try JSONDecoder().decode(PlayerBriefInfoModel.self, from: data)
                players = tempObj.data
                var _: String = ""
            }
            catch
            {
                players = []
            }
        }
    }
    
    struct TeamDetail_Previews: PreviewProvider {
        static var previews: some View {
            TeamDetail(team: countries[0])
        }
    }
    
    
    func getPlayerDetails(var mplayerBriefInfo: PlayerBriefInfo){
        do
        {
            let url =
            URL(string: "https://cricket.sportmonks.com/api/v2.0/players/\(mplayerBriefInfo.id)?include=career&include=career.season&api_token=Kgq86V2HeGjmLAgMKAMoBOltQqtAr3jaSyAQaxH2DQ4ZdkdMyEWyeQy613ct")!
            let data = try? Data(contentsOf: url)
            let _ = print(data!.description)
            if(data!.isEmpty){return}
            let tempObj = try? JSONDecoder().decode(SinglePlayerInfoModel.self, from: data!)
            if tempObj != nil {let mplayer = tempObj?.data}
            //if tempObj != nil {api.playerBriefInfo[0]! = tempObj?.data}
            var _: String = ""
        }
    }
}
