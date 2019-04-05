import UIKit

class RecentPhotoViewController: UIViewController {

    var recentPhoto: RecentPhoto!
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var photoCaption: UILabel! {
        
        didSet {
            
            photoCaption.text = nil
            
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        photoView.image = recentPhoto.photo

        photoCaption.text = recentPhoto.caption
        
    }
    
}
