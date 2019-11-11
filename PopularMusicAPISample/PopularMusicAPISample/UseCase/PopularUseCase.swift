
import Foundation
import RxSwift

final class PopularUseCase {

    private let api = ApiClient()
//    private let favoriteMusicDao = FavoriteMusicDAO()

    func fetchMusic() -> Single<MusicsResponse> {
        return api.get(path: "", request: nil)
    }

//    func loadFavoriteMusic() -> Single<[Music]> {
//        return favoriteMusicDao.load()
//    }
//
//    func addFavoriteMusic(_ Music: Music) -> Single<[Music]> {
//        return favoriteMusicDao.add(Music)
//    }
//
//    func removeFavoriteMusic(target: Music) -> Single<[Music]> {
//        return favoriteMusicDao.remove(target: target)
//    }
}
