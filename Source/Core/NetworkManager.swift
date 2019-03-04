import Foundation
import Alamofire

class NetworkManager {
    private let baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func loadMatches(success: @escaping ([Match]) -> Void, failure: @escaping (Error) -> Void) {

        AF.request(requestURL(with: "bhxgt")).responseDecodable { (response: DataResponse<MatchesInfo>) in
            guard response.result.isSuccess else {
                failure(response.result.error!)
                return
            }
            
            success(response.result.value!.matches)
        }
    }
    
    func loadResults(success: @escaping ([Match]) -> Void, failure: @escaping (Error) -> Void) {
        
        AF.request(requestURL(with: "bhxgt")).responseDecodable { (response: DataResponse<MatchesInfo>) in
            guard response.result.isSuccess else {
                failure(response.result.error!)
                return
            }
            
            success(response.result.value!.matches)
        }
    }
    
    private func requestURL(with enterPoint: String) -> URL {
        return baseURL.appendingPathComponent(enterPoint)
    }

}
