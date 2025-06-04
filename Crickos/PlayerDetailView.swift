//
//  PlayerDetailView.swift
//  Crickos
//
//  Created by Agha Asad Hussain on 11/19/22.
//

import SwiftUI


struct PlayerDetailView: View {
    @State var mplayer: PlayerBriefInfo

    var body: some View {
        Text(mplayer.fullname).onAppear(perform: readPlayerData)
        Text(mplayer.fullname).task{
                do
                {
                let url =
                    URL(string: "https://cricket.sportmonks.com/api/v2.0/players/\(mplayer.id)?include=career&include=career.season&api_token=Kgq86V2HeGjmLAgMKAMoBOltQqtAr3jaSyAQaxH2DQ4ZdkdMyEWyeQy613ct")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let _ = print(data.description)
                if(data.isEmpty){return}
                let tempObj = try JSONDecoder().decode(SinglePlayerInfoModel.self, from: data)
                    mplayer = tempObj.data
                var _: String = ""
                }
                catch
            {
                //player =
            }
        }
        Text(mplayer.position.name)
        Text(mplayer.gender)
        HStack{
            SwiftUI.Group{
                Image("icon_batsman").resizable().frame(width: 40,height: 40, alignment: .center)
                Text(mplayer.battingstyle)
            }
        }//.onAppear(readPlayerData(mplayer[0]))
        Text(mplayer.bowlingstyle)
        Text(mplayer.career[0].type).onAppear(perform: readPlayerData)
        AsyncImage(
            url: URL(string: mplayer.image_path)!,
            placeholder: { Text("Loading ...") },
            image: { Image(uiImage: $0).resizable()}
        ).frame(width: 100,height: 100, alignment: .center)
    }
    
    private func readPlayerData(){
                let url =
                    URL(string: "https://cricket.sportmonks.com/api/v2.0/players/\(mplayer.id)?include=career&include=career.season&api_token=Kgq86V2HeGjmLAgMKAMoBOltQqtAr3jaSyAQaxH2DQ4ZdkdMyEWyeQy613ct")!
                let data = try? Data(contentsOf: url)
                let _ = print(data!.description)
                if(data!.isEmpty){return}
                let tempObj = try? JSONDecoder().decode(SinglePlayerInfoModel.self, from: data!)
        if let newPlayer = tempObj?.data {
            mplayer = newPlayer
        }
                var _: String = ""
        }

}

