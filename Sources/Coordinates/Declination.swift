public struct Declination {
  public let degrees: Double

  public init(degrees: Double, minutes: Double) {
    self.degrees = degrees + minutes / 60
  }
}
