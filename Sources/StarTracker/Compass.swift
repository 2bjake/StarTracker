public enum CardinalDirection: String { case north, east, south, west }

extension CardinalDirection {
  public var angle: Double {
    switch self {
      case .north: return 0
      case .east: return 90
      case .south: return 180
      case .west: return 270
    }
  }
}

public enum HalfWind: CaseIterable { case northNortheast, eastNortheast, eastSoutheast, southSoutheast, southSouthwest, westSouthwest, westNorthwest, northNorthwest }

extension HalfWind {
  static let angleRangeForHalfWind: [HalfWind: Range<Double>] = [
    .northNortheast: 0..<45,
    .eastNortheast: 45..<90,
    .eastSoutheast: 90..<135,
    .southSoutheast: 135..<180,
    .southSouthwest: 180..<225,
    .westSouthwest: 225..<270,
    .westNorthwest: 270..<315,
    .northNorthwest: 315..<360
  ]

  var angleRange: Range<Double> { Self.angleRangeForHalfWind[self]! }

  public init?(angle: Double) {
    let match = Self.angleRangeForHalfWind.first { halfWind, range in range.contains(angle) }
    guard let halfWind = match?.key else { return nil }
    self = halfWind
  }

  public var nearestCardinalDirection: CardinalDirection {
    switch self {
      case .northNorthwest, .northNortheast: return .north
      case .eastNortheast, .eastSoutheast: return .east
      case .southSoutheast, .southSouthwest: return .south
      case .westSouthwest, .westNorthwest: return .west
    }
  }

  public func isClockwise(to direction: CardinalDirection) -> Bool {
    switch direction {
      case .north: return self.nearestCardinalDirection == .west || self == .northNorthwest || self == .southSouthwest
      case .south: return self.nearestCardinalDirection == .east || self == .northNortheast || self == .southSoutheast
      case .west: return self.nearestCardinalDirection == .south || self == .westSouthwest || self == .eastSoutheast
      case .east: return self.nearestCardinalDirection == .north || self == .westNorthwest || self == .eastNortheast
    }
  }
}
