struct PhotoList {
    
    private(set) var page: Int
    
    private(set) var pages: Int
    
    private(set) var perPage: Int
    
    private(set) var total: Int
    
    private(set) var photos: [Photo]
    
}

// MARK: - Decodable

extension PhotoList: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        
        case page
        
        case pages
        
        case perPage = "perpage"
        
        case total
        
        case photos = "photo"
        
    }
    
}
