
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
            musicCollectionV.dataSource = dataSource
            musicCollectionV.register(cellType: MusicCell.self)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        showPopularData()
    }

    func showPopularData(){
        viewModel.fetchMusicData()
        .asDriver(onErrorRecover: { [weak self] error in
            print(error)
            return Driver.empty()
        }).drive(onNext: { [weak self] response in
            print(response)
            self?.dataSource.setMusicData(response)
            self?.musicCollectionV.reloadData()
        }).disposed(by: disposeBag)
    }
}

extension PopularViewController: MusicCellDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let musicCell = cell as? MusicCell else {
            return
        }
        musicCell.delegate = self
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
