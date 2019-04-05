struct GetRecentResult {
    
    private(set) var photoList: PhotoList
    
    private(set) var stat: String
    
}

// MARK: - Decodable

extension GetRecentResult: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        
        case photoList = "photos"
        
        case stat
        
    }
    
}
