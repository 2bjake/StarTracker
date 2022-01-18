public struct EquatorialCoordinates {
  public let epoch: Epoch = .j2000

  public var rightAscension: RightAscension
  public var declination: Declination

  public init(rightAscension: RightAscension, declination: Declination) {
    self.rightAscension = rightAscension
    self.declination = declination
  }
}
