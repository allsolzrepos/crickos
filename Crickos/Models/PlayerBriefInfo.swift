//
//  PlayerBriefInfo.swift
//
//  Created by Agha Asad Hussain on 11/16/22.
//

import Foundation

var players : [PlayerBriefInfo]! = []
var player: PlayerBriefInfo!

struct PlayerBriefInfo : Decodable, Identifiable{
    var resource: String
    var id: Int
    var country_id: Int
    var firstname: String
    var lastname: String
    var fullname: String
    var image_path: String
    var dateofbirth: String
    var gender: String
    var battingstyle: String!
    var bowlingstyle: String!
    var position: Position!
    var updated_at: String
    var career: [career]!
}

struct season: Decodable, Identifiable{
    var resource: String
    var id: Int
    var league_id: Int
    var name : String
    var code : String
    var updated_at : String
}

struct career: Decodable {
            var resource : String
            var type: String
            var season_id: Double
            var player_id: Double
            var bowling: Bowling!
            var batting: Batting!
            var updated_at: String
            var season : season!
            }

struct Position: Decodable, Identifiable{
    var resource: String
    var id: Int
    var name: String
}

struct Bowling: Decodable {
    var matches : Double
    var overs : Double
    var innings : Double
    var average : Double
    var econ_rate : Double
    var medians : Double
    var runs : Double
    var wickets : Double
    var wide : Double
    var noball : Double
    var strike_rate : Double
    var four_wickets : Double
    var five_wickets : Double
    var ten_wickets : Double
    var rate : Double
}

struct Batting: Decodable{
    var matches : Double
    var innings : Double
    var runs_scored : Double
    var not_outs : Double
    var highest_inning_score : Double
    var strike_rate : Double
    var balls_faced : Double
    var average : Double
    var four_x : Double
    var six_x : Double
    var fow_score : Double
    var fow_balls : Double
    var hundreds : Double
    var fifties : Double
}

struct SinglePlayerInfoModel: Decodable {
    var data : PlayerBriefInfo
    
    enum CodingKeys: String, CodingKey{
        case data
    }
    
    enum NameKeys: CodingKey {
        case resource
        case id
        case country_id
        case firstname
        case lastname
        case fullname
        case image_path
        case dateofbirth
        case gender
        case battingstyle
        case bowlingstyle
        case position
        case updated_at
        case career
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode(PlayerBriefInfo.self, forKey: .data)
    }
}
struct PlayerBriefInfoModel: Decodable {
    var data : [PlayerBriefInfo]

    enum CodingKeys: String, CodingKey{
        case data
    }
    
    enum NameKeys: CodingKey {
        case resource
        case id
        case country_id
        case firstname
        case lastname
        case fullname
        case image_path
        case dateofbirth
        case gender
        case battingstyle
        case bowlingstyle
        case position
        case updated_at
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decode([PlayerBriefInfo].self, forKey: .data)
    }
    
}
extension PlayerBriefInfo {
    static let sampleData: [PlayerBriefInfo] =
    [
//        DailyScrum(title: "Design", attendees: ["Cathy", "Daisy", "Simon", "Jonathan"], lengthInMinutes: 10, theme: .yellow),
//        DailyScrum(title: "App Dev", attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"], lengthInMinutes: 5, theme: .orange),
//        DailyScrum(title: "Web Dev", attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"], lengthInMinutes: 5, theme: .poppy)
        PlayerBriefInfo(resource: "test", id: 1, country_id: 1, firstname: "test", lastname: "test", fullname: "test", image_path: "test", dateofbirth: "test", gender: "test", position: Position(resource: "test", id: 1, name: "test"), updated_at: "test")
    ]
}



@MainActor
class PlayerBriefInfoAPI: ObservableObject {
    @Published var playerBriefInfo: [PlayerBriefInfo] = []

    func fetchRecipes(for selection: PlayerBriefInfo) async {

        //create the API URL by substituting the selected menu
        //into the baseURL
//        let apiURL = URL(string: baseURL.replacingOccurrences(of: "MENU", with: selection.menu))!
//
//        do {
//            let (data, _) = try await URLSession.shared.data(from: apiURL)
//            let decoder = JSONDecoder()
//            recipes = try decoder.decode([Recipe].self, from: data)
//        } catch {
//            print(error)
//        }
        
        let url =
        URL(string: "https://cricket.sportmonks.com/api/v2.0/players/\(selection.id)?include=career&include=career.season&api_token=Kgq86V2HeGjmLAgMKAMoBOltQqtAr3jaSyAQaxH2DQ4ZdkdMyEWyeQy613ct")!
        let data = try? Data(contentsOf: url)
        let _ = print(data!.description)
        if(data!.isEmpty){return}
        let tempObj = try? JSONDecoder().decode(SinglePlayerInfoModel.self, from: data!)
        if let player = tempObj?.data {
            playerBriefInfo = [player]
        }
        var _: String = ""
//        return true
        
    }
}
