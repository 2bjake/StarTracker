public struct RightAscension {
  public let hours: Int
  public let minutes: Double

  public init(hours: Int, minutes: Double) {
    self.hours = hours
    self.minutes = minutes
  }
}

extension RightAscension {
  public var degrees: Double { (Double(hours) + minutes / 60) * 15 }
}
