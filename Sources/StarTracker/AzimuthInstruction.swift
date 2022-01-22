public struct AzimuthInstruction {
  public var heading: CardinalDirection
  public var shouldRotateClockwise: Bool
  public var adjustedAngle: Double

  public init(angle: Double) {
    guard let halfWind = HalfWind(angle: angle) else { fatalError() }
    heading = halfWind.nearestCardinalDirection
    shouldRotateClockwise = !halfWind.isClockwise(to: heading)

    var adjustedAngle: Double
    if shouldRotateClockwise {
      adjustedAngle = angle - heading.angle
    } else {
      adjustedAngle = heading.angle - angle
    }

    if adjustedAngle < 0 {
      adjustedAngle += 360
    }
    self.adjustedAngle = adjustedAngle
  }
}
