import UIKit

// MARK: - RecentPhotosDelegate

protocol RecentPhotosDelegate {
    
    func didLoadRecentPhoto(_ recentPhoto: RecentPhoto, at index: Int)
    
    func didEncounterError(_ error: Error)
    
}

// MARK: - RecentPhotos

class RecentPhotos {
    
    var count: Int {
        
        return photos.count
        
    }
    
    private(set) var photos: [RecentPhoto] = []
    
    private let flickr: Flickr
    
    private let delegate: RecentPhotosDelegate
    
    init(_ flickr: Flickr, delegate: RecentPhotosDelegate) {
        
        self.flickr = flickr
        
        self.delegate = delegate
        
    }
    
    func load() {
                
        flickr.getRecent { result, error in
            
            guard error == nil, let result = result else {
                
                self.delegate.didEncounterError(error!)
                
                return
                
            }
            
            for photo in result.photoList.photos {
                
                self.flickr.getImage(forPhoto: photo) { data, error in
                    
                    guard error == nil, let data = data else {
                        
                        self.delegate.didEncounterError(error!)

                        return
                        
                    }
                    
                    let image = UIImage(data: data)
                    
                    let recentPhoto = RecentPhoto(photo: image ?? UIImage(), caption: photo.title)
                    
                    self.photos.append(recentPhoto)
                    
                    self.delegate.didLoadRecentPhoto(recentPhoto, at: self.photos.count - 1)
                    
                }
                
            }
            
        }
        
    }
    
    func image(at index: Int) -> RecentPhoto  {
        
        return photos[index]
        
    }
    
}

// MARK: - Image

protocol Image {
    
    var photo: UIImage { get }
    
    var caption: String { get }
    
}

// MARK: - RecentPhoto

struct RecentPhoto: Image {
    
    var photo: UIImage
    
    var caption: String
    
}
