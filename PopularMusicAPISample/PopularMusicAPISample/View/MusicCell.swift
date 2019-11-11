
import UIKit
import AlamofireImage

protocol MusicCellDelegate {
}


class MusicCell: UICollectionViewCell {

    @IBOutlet weak var artworkV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    var delegate: MusicCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        artworkV = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }

    func setData(music: Music) {
        if let url = URL(string: music.artworkUrl100) {
//            artworkV.af_setImage(withURL: url)
        }
        titleLabel.text = music.name
        artistLabel.text = music.artistName
    }
}
