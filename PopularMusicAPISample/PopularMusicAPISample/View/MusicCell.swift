
import UIKit
import AlamofireImage

class MusicCell: UICollectionViewCell {

    @IBOutlet weak var artworkV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        artworkV = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }

    func setImage(url: String){
        if let artworkV = self.artworkV {
            artworkV.af_setImage(withURL: URL(string: url)!)
        }
    }
}
