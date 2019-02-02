
extension String {

  init(milliseconds: Int) {
    self = String(format: "%02i:%02i", ((milliseconds / 1000) / 60 % 60), (milliseconds / 1000) % 60)
  }

}