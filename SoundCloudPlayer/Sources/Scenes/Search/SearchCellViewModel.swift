
import UIKit
import RxSwift
import RxCocoa

final class SearchCellViewModel: ViewModelType {

  // MARK: - ViewModelType

  struct Input {}

  struct Output {
    let track: Driver<Track>
    let artwork: Driver<UIImage>
  }

  // MARK: - Properties

  private let track: Track
  private let soundCloudService: SoundCloudServiceType

  // MARK: - Init

  init(track: Track, soundCloudService: SoundCloudServiceType = ServiceLocator.shared.soundCloudService) {
    self.track = track
    self.soundCloudService = soundCloudService
  }


  // MARK: - ViewModelType

  func fetchOutput(_ input: Input? = nil) -> Output {
    return Output(
      track: Driver.just(track),
      artwork: soundCloudService.fetchArtwork(path: track.artwork).asDriver(onErrorJustReturn: UIImage(named: "Artwork")!))
  }

}
