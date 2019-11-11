
import SwiftyJSON
import Alamofire
import RxSwift

protocol ApiClientProtocol {
    var baseUrl: String { get }

    init(_ baseUrl: String)

    func get<T: ResponseEntity>(path: String?,
                                request: RequestEntity?) -> Single<T>
}

class ApiClient: ApiClientProtocol {

    var baseUrl: String

    required init(_ baseUrl: String = Config.RSS_URL) {
        self.baseUrl = baseUrl
    }

    func get<T: ResponseEntity>(path: String?,
                                request: RequestEntity?) -> Single<T> {

        var requestUrl = baseUrl
        if let path = path {
            requestUrl = baseUrl + path
        }

        var params = Parameters()
        if let request = request {
            params = request.parameterize()
        }

        return Single<T>.create { single in
            let manager = SessionManager.default
            let request = manager.request(requestUrl,
                                          method: .get,
                                          parameters: params,
                                          encoding: URLEncoding.default,
                                          headers: nil)
                .responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(_):
                        guard let data = response.data else {
                            return single(.error(response.error!))
                        }
                        let json = JSON(data)
                        return single(.success(T(json)))

                    case .failure(let error):
                        return single(.error(error))
                    }
                })
            return Disposables.create {
                return request.cancel()
            }
        }
    }
}
