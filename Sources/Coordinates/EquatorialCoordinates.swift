public struct EquatorialCoordinates {
  public let epoch: Epoch = .j2000

  public var rightAscension: RightAscension
  public var declination: Declination

  public init(rightAscension: RightAscension, declination: Declination) {
    self.rightAscension = rightAscension
    self.declination = declination
  }
}

//extension EquatorialCoordinates {
//  public init?(_ source: String) {
//    let parts = source.split(separator: " ")
//    guard parts.count == 3,
//          let raHours = Int(parts[0]),
//          let raMinutes = Int(parts[1]),
//          let decAngle = Double(parts[2]) else { return nil }
//    self.init(rightAscension: .init(hours: raHours, minutes: raMinutes), declination: .init(decAngle))
//  }
//}
//
//extension EquatorialCoordinates: CustomStringConvertible {
//  public var description: String {
//    "\(rightAscension.hours) \(rightAscension.minutes) \(declination.angle)"
//  }
//}
