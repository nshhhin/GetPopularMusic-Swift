
import Foundation
import UIKit

final class PopularCollectionViewDataSource: NSObject {

    private var musics = [Music]()

    func setMusicData(_ data: [Music]) {
        musics = data
    }

    func updateDataState(_ data: Music) {
        for (index, music) in musics.enumerated() {
            guard music.id == data.id else {
                continue
            }
            break
        }
    }
}

extension PopularCollectionViewDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musics.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCell", for: indexPath) as! MusicCell
        cell.setData(music:musics[indexPath.row])

        return cell
    }


}
