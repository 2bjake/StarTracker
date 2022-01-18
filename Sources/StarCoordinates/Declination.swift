public struct Declination {
  public let degrees: Double

  public init(degrees: Double, minutes: Double = 0, seconds: Double = 0) {
    var minutes = minutes
    var seconds = seconds

    if degrees < 0 {
      minutes *= -1
      seconds *= -1
    }
    self.degrees = degrees + minutes / 60 + seconds / 3600
  }
}
