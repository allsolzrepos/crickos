//
//  SampleData.swift
//  Crickos
//
//  Created by Agha Asad Hussain on 11/20/22.
//

import SwiftUI

var s3API = ""

struct SampleData: View {
    @State var  playerData : PlayerBriefInfo!
    @StateObject var api = PlayerBriefInfoAPI()
    @State var dataLoaded : Bool = false
    //@StateObject var viewModel = MyAccountListViewModel()
    
    var body: some View {
        VStack
        {
            if(dataLoaded)
            {
                AsyncImage(
                    url: URL(string: playerData.image_path)!,
                    placeholder: { Text("Loading ...") },
                    image: { Image(uiImage: $0).resizable()}
                ).frame(alignment: .top)
                Text(playerData.fullname).font(.title).foregroundColor(.red)
                if(playerData.position != nil) {  Text(playerData.position.name).font(.title).foregroundColor(.red).padding(.bottom)}
                if(playerData.career != nil && (!playerData.career.isEmpty))
                {
                    if (playerData.career[0].batting != nil){
                        Text("\(playerData.career[0].type)" + " Batting Career").font(.headline).foregroundColor(.red)
                        HStack{Text("Total matches played : ").font(.subheadline)
                            Text("\(String(playerData.career[0].batting.matches))")}
                        HStack{
                            Text("Total innings played : ").font(.subheadline)
                            Text("\(String(playerData.career[0].batting.innings))")}
                        HStack{
                            Text("Total runs scored : ").font(.subheadline)
                            Text("\(String(playerData.career[0].batting.runs_scored))")
                        }.padding(.bottom)
                    }
                    if (playerData.career[0].bowling != nil){
                        Text("\(playerData.career[0].type)" + " Bowling Career").font(.headline).foregroundColor(.red)
                        HStack{
                            Text("Total matches bowled : ").font(.subheadline)
                            Text("\(String(playerData.career[0].bowling!.matches))")
                        }
                        HStack{
                            Text("Total overs bowled : ").font(.subheadline)
                            Text("\(String(playerData.career[0].bowling!.overs))")
                        }
                        HStack{
                            Text("Avg. Econ Rate : ").font(.subheadline)
                            Text("\(String(playerData.career[0].bowling!.econ_rate))")
                        }
                        
                    }
                }
            }
            Spacer()
        }.onAppear{
            getPlayerDetails(mplayerBriefInfo: playerData)
            dataLoaded = true
        }.onDisappear{dataLoaded = false}
    }
    
    func getPlayerDetails(mplayerBriefInfo: PlayerBriefInfo){
        do
        {
            let url =
            URL(string: "https://cricket.sportmonks.com/api/v2.0/players/\(mplayerBriefInfo.id)?include=career&include=career.season&api_token=Kgq86V2HeGjmLAgMKAMoBOltQqtAr3jaSyAQaxH2DQ4ZdkdMyEWyeQy613ct")!
            let data = try? Data(contentsOf: url)
            //let _ = print(data!.description)
            if(data == nil){return}
            let tempObj = try? JSONDecoder().decode(SinglePlayerInfoModel.self, from: data!)
            if tempObj != nil {playerData = tempObj?.data}
        }
    }
    
}
