import Foundation

public struct RightAscension {
  public let hours: Int
  public let minutes: Int
  public let seconds: Double

  public init(hours: Int, minutes: Int = 0, seconds: Double = 0) {
    self.hours = hours
    self.minutes = minutes
    self.seconds = seconds
  }
}

extension RightAscension {
  public var degrees: Double { (Double(hours) + Double(minutes) / 60 + seconds / 3600) * 15 }
}

extension RightAscension {
  public func hourAngle(longitude: Double, date: Date) -> Double {
    let lst = date.localSiderealTimeDegrees(longitude: longitude)
    var angle = lst - self.degrees
    if angle < 0 { angle += 360 }
    return angle
  }
}
