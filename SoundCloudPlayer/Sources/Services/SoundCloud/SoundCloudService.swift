
import UIKit
import RxSwift

protocol SoundCloudServiceType {
  func search(query: String) -> Observable<[Track]>
  func fetchArtwork(path: String?) -> Observable<UIImage>
  func fetchTrack(id: Int) -> Observable<Track>
  func fetchStreamUrl(id: Int) -> Observable<URL>
}

final class SoundCloudService: SoundCloudServiceType {

  private let provider: ServiceProviderType

  init(provider: ServiceProviderType) {
    self.provider = provider
  }

  func search(query: String) -> Observable<[Track]> {
    return provider.httpClient.rx
      .task(request: HTTPRequest(target: SoundCloudTarget.search(query: query)), type: HTTPResponse.self)
      .map { response in try response.json(type: [Track].self) }
  }

  func fetchArtwork(path: String?) -> Observable<UIImage> {
    guard let path = path, let url = URL(string: path) else {
      return .just(UIImage(named: "Artwork")!)
    }
    return provider.httpClient.rx
      .task(request: HTTPRequest(target: url), type: HTTPResponse.self)
      .map { response in UIImage(data: response.data) ?? UIImage(named: "Artwork")! }
  }

  func fetchTrack(id: Int) -> Observable<Track> {
    return provider.httpClient.rx
      .task(request: HTTPRequest(target: SoundCloudTarget.track(id: id)), type: HTTPResponse.self)
      .map { response in try response.json(type: Track.self) }
  }

  func fetchStreamUrl(id: Int) -> Observable<URL> {
    do {
      return Observable.just(try HTTPRequest(target: SoundCloudTarget.stream(id: id)).url())
    } catch {
      return Observable.error(error)
    }
  }

}
