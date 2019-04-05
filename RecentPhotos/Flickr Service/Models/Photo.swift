struct Photo {
    
    private(set) var identifier: String
    
    private(set) var owner: String
    
    private(set) var secret: String
    
    private(set) var server: String
    
    private(set) var farm: Int
    
    private(set) var title: String
    
}

// MARK: - Decodable

extension Photo: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        
        case identifier = "id"
        
        case owner
        
        case secret
        
        case server
        
        case farm
        
        case title
        
    }
    
}

// MARK: - Equatable

extension Photo: Equatable {
    
    public static func == (lhs: Photo, rhs: Photo) -> Bool {
        
        return lhs.identifier == rhs.identifier
        
    }
    
}
