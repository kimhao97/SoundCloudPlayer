
import UIKit
import RxSwift

final class SearchCell: UITableViewCell, NibReusable {

  // MARK: - IBOutlets

  @IBOutlet private var artworkImageView: UIImageView!
  @IBOutlet private var titleLabel: UILabel!
  @IBOutlet private var durationLabel: UILabel!
  @IBOutlet private var usernameLabel: UILabel!

  // MARK: - Properties

  private var disposeBag = DisposeBag()

  // MARK: - UITableViewCell

  override func prepareForReuse() {
    super.prepareForReuse()

    disposeBag = DisposeBag()
    artworkImageView.alpha = 0
  }

  // MARK: - Binding

  func bind(to viewModel: SearchCellViewModel) {

    let output = viewModel.transform(.init())

    output.track
      .map { track in track.title }
      .bind(to: titleLabel.rx.text)
      .disposed(by: disposeBag)

    output.track
      .map { track in track.user.username }
      .bind(to: usernameLabel.rx.text)
      .disposed(by: disposeBag)

    output.track
      .map { track in track.duration }
      .map { duration in String(milliseconds: duration) }
      .bind(to: durationLabel.rx.text)
      .disposed(by: disposeBag)

    output.artwork
      .do(onNext: { _ in UIView.animate(withDuration: 0.1) { [weak self] in self?.artworkImageView.alpha = 1 } })
      .bind(to: artworkImageView.rx.image)
      .disposed(by: disposeBag)
  }

}
