
import RxSwift

final class PopularViewModel {

    private let useCase = PopularUseCase()

    func fetchMusicData() -> Single<[Music]> {
        return useCase.fetchMusic().map({response -> [Music] in
            return response.musics
        })
    }
}

