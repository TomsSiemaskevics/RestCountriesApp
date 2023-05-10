

import Foundation


class NetworkManager {
    
    static func fetchData(url: String, completion: @escaping ([Country]) -> () ) {
        
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        
        URLSession(configuration: config).dataTask(with: request) { (data, response, err ) in
            
            guard err == nil else {
                print("err:::::", err!)
                return
            }
            
            //print("response:", response as Any)
            
            guard let data = data else { return }
            
            
            do {
                let jsonData = try JSONDecoder().decode([Country].self, from: data)
                completion(jsonData)
            }catch{
                print("err:::::", error)
            }
            
        }.resume()
        
    }
    
    
}
