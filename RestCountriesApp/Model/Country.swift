

import Foundation


struct Country: Codable {
    let name: Name
    let region, subregion: String?
}


struct Name: Codable {
    let common, official: String?
}

