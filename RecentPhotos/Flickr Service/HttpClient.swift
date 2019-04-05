import Alamofire
import Foundation

// MARK: - HttpClient

protocol HttpClient {
    
    func send(_ request: URLRequest, completion: @escaping (_ data: Data?, _ error: Error?) -> Void)
    
}

struct Client: HttpClient {
    
    func send(_ request: URLRequest, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        
        Alamofire.request(request).validate().responseData { response in
            
            switch response.result {
                
            case .success:
                
                completion(response.result.value, nil)
                
            case .failure(let error):
                
                completion(response.result.value, error)
                
            }
            
        }
        
    }
    
}
