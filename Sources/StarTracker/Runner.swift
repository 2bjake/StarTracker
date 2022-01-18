import StarCoordinates
import Foundation
import CoreLocation

extension AzimuthInstruction: CustomStringConvertible {
  public var description: String {
    "Face \(heading) and rotate \(shouldRotateClockwise ? "right" : "left") \(adjustedAngle.formatted()) degrees." // TODO: format angle
  }
}

@main
struct Runner {
  static func main() {
//    let siriusCoordinates = EquatorialCoordinates(rightAscension: .init(hours: 6, minutes: 45, seconds: 8.92), declination: .init(degrees: -16, minutes: 42, seconds: 58.0))

    let austinLoc = CLLocationCoordinate2D(latitude: 30.377222222, longitude: -97.848888889)
    let polarisCoordinates = EquatorialCoordinates(rightAscension: .init(hours: 2, minutes: 31, seconds: 49.06), declination: .init(degrees: 89, minutes: 15, seconds: 50.8))
    let horizontalCoordinates = HorizontalCoordinates(coordinates: polarisCoordinates, location: austinLoc, date: .now)
    print(AzimuthInstruction(angle: horizontalCoordinates.azimuthDeg))
    print("and look \(horizontalCoordinates.altitudeDeg) degrees up from the horizon.")
  }
}

func printDegreesMinutesSeconds(_ angle: Double) {
  let degrees = Int(angle)
  let remainder = abs(angle) - Double(abs(degrees))
  let minutes = Int(remainder * 60)
  let seconds = (remainder - Double(minutes) / 60) * 3600

  print("\(degrees) \(minutes) \(seconds)")
}
