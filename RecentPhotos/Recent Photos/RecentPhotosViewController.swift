import UIKit

class RecentPhotosViewController: UIViewController {

    private var selectedPhoto: RecentPhoto?
    
    private var recentPhotos: RecentPhotos?
    
    @IBOutlet weak var recentlyViewedCaption: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        recentPhotos = RecentPhotos(FlickrService(Client()), delegate: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        if let selectedPhoto = selectedPhoto {
            
            recentlyViewedCaption.text = selectedPhoto.caption
            
        }
        
        recentPhotos?.load()
        
    }
    
}

// MARK: - UITableViewDataSource

extension RecentPhotosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recentPhotos?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let recentPhoto = recentPhotos?.image(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RecentPhotoCell.self),
                                                 for: indexPath) as! RecentPhotoCell
        
        
        cell.recentPhotoImageView.image = recentPhoto?.photo
        
        cell.recentPhotoLabel.text = recentPhoto?.caption
        
        return cell
        
    }
    
}

// MARK: - UITableViewDelegate

extension RecentPhotosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedImage = recentPhotos?.image(at: indexPath.row) else {
            
            return
            
        }
        
        selectedPhoto = selectedImage
        
        performSegue(withIdentifier: "showRecentPhoto", sender: nil)
        
    }
    
}

// MARK: - RecentPhotosDelegate

extension RecentPhotosViewController: RecentPhotosDelegate {
    
    func didLoadRecentPhoto(_ recentPhoto: RecentPhoto, at index: Int) {
        
        let indexPath = IndexPath(row: index, section: 0)
        
        tableView.insertRows(at: [indexPath], with: .automatic)
        
    }
    
    func didEncounterError(_ error: Error) {
        
        print(error)
        
    }
    
}

// MARK: - Navigation

extension RecentPhotosViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let recentPhotoViewController = segue.destination as? RecentPhotoViewController {
            
            recentPhotoViewController.recentPhoto = selectedPhoto
            
        }
        
    }
    
}

