import Foundation

class API {
    static let shared: API = API()
    
    func postUser(user: User,
                  success: @escaping () -> (),
                  failure: @escaping (Error) -> ()) {
        let dict = ["username": user.name, "password": user.password]
        
        guard let url = URL(string: "http://present810209.twf.node.tw/api/login.php") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("utf-8", forHTTPHeaderField: "charest")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: dict, options: .fragmentsAllowed)
        } catch let err {
            
            failure(err)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                failure(err)
                return
            }
            success()
        }.resume()
    }
    
    func getStockInfo(success: @escaping([Code]) -> (),
                      failure: @escaping(Error) -> ()) {
        
        let url = "http://present810209.twf.node.tw/api/getstockcode.php"
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, err) in
            
            if let err = err {
                failure(err)
                return
            }
            
            guard let data = data else { return }
            guard let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else { return }
            guard let dataArray = json["data"] as? [[String: Any]] else { return }
            
            var codes: [Code] = []
            
            for data in dataArray {
                let code = Code.init(dict: data)
                codes.append(code)
            }
            success(codes)
        }.resume()
    }
}
