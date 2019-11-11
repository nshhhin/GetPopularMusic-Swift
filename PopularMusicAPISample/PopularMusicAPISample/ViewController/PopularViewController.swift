
import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import RxSwift
import RxCocoa

class PopularViewController: UIViewController {

    private let viewModel = PopularViewModel()
    private let disposeBag = DisposeBag()
    private let dataSource = PopularCollectionViewDataSource()

    var musics: [Music] = []
    
    @IBOutlet weak var musicCollectionV: UICollectionView! {
        didSet {
            musicCollectionV.delegate = self
            musicCollectionV.dataSource = self
            musicCollectionV.register(cellType: MusicCell.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.fetchMusicData()
                .asDriver(onErrorRecover: { [weak self] error in
                    return Driver.empty()
                }).drive(onNext: { [weak self] response in
                    self?.dataSource.setMusicData(response)
                    self?.musicCollectionV.reloadData()
                }).disposed(by: disposeBag)
    }
}

extension PopularViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musics.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let music = musics[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCell", for: indexPath) as! MusicCell
        cell.titleLabel.text = music.name
        cell.artistLabel.text = music.artistName

        if let url = URL(string: music.artworkUrl100) {
            cell.artworkV = UIImageView(image: Image(named: "image"))
//            cell.artworkV.af_setImage(withURL: url, placeholderImage: Image(named: "image"))

        }
        return cell
    }
}

extension PopularViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat = collectionView.layer.bounds.width / 2
        let height = width + 100
        return CGSize(width: width, height: height)
    }
}


struct PopularMusicRSS: Codable {
    var feed: PopularMusicFeed
}

struct PopularMusicFeed: Codable {
    var results: [Music]
}
