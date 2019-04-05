import Foundation

// MARK: - Flickr

protocol Flickr {
    
    func getRecent(completion: @escaping (GetRecentResult?, Error?) -> Void)
    
    func getImage(forPhoto photo: Photo, completion: @escaping (Data?, Error?) -> Void)
    
}

// MARK: - FlickrService

struct FlickrService: Flickr {
    
    enum FlickrError: Error {
        
        case generic
        
    }
    
    private(set) var client: HttpClient
    
    init(_ client: HttpClient = Client()) {
        
        self.client = client
        
    }
    
}

// MARK: - getRecent

extension FlickrService {
    
    func getRecent(completion: @escaping (GetRecentResult?, Error?) -> Void) {
        
        // hardcoded for now
        guard let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=fee10de350d1f31d5fec0eaf330d2dba&format=json&nojsoncallback=1") else {
            
            completion(nil, FlickrError.generic)
            
            return
            
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        client.send(request) { data, error in
            
            guard error == nil, data != nil else {
                
                completion(nil, FlickrError.generic)
                
                return
                
            }
            
            do {
                
                let decoder = JSONDecoder()
                
                let result = try decoder.decode(GetRecentResult.self, from: data!)
                
                completion(result, nil)
                
            } catch {
                
                completion(nil, FlickrError.generic)
                
            }
            
        }
        
    }
    
}

// MARK: - Farm

extension FlickrService {
    
    func getImage(forPhoto photo: Photo, completion: @escaping (Data?, Error?) -> Void) {
        
//        https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
        
        let urlString = "https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.identifier)_\(photo.secret).jpg"
        
        guard let url = URL(string: urlString) else {
            
            completion(nil, FlickrError.generic)
            
            return
            
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        client.send(request) { data, error in
            
            guard error == nil, data != nil else {
                
                completion(nil, FlickrError.generic)
                
                return
                
            }
            
            completion(data, nil)
            
        }
        
    }
    
}
