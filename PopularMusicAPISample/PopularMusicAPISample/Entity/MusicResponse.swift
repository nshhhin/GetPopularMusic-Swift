
import Foundation
import SwiftyJSON

struct MusicsResponse: ResponseEntity {
    var json: JSON
    var musics: [Music]

    init(_ json: JSON) {
        self.json = json

        let jsonData = json["feed"]["results"].arrayValue

        self.musics = jsonData.compactMap({ data in
            let id = data["id"].stringValue
            let artistName = data["artistName"].stringValue
            let title = data["name"].stringValue
            let artworkUrl100 = data["artworkUrl100"].stringValue

            return Music(id: id, artistName: artistName, name: title, artworkUrl100: artworkUrl100)
        })
    }
}
