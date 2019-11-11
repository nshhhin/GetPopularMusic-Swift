
import Foundation

struct Music: Codable {
    var id: String
    var artistName: String
    var name: String
    var artworkUrl100: String

    func print(){
        Swift.print(artistName, name, artworkUrl100)
    }
}
