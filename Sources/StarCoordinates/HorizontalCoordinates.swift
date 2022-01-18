import CoreLocation
import Foundation

public struct HorizontalCoordinates {
  public var altitudeDeg: Double
  public var azimuthDeg: Double
}

extension HorizontalCoordinates {
  public init(coordinates: EquatorialCoordinates, location: CLLocationCoordinate2D, date: Date) {
    let hourAngle = coordinates.rightAscension.hourAngle(longitude: location.longitude, date: date)

    let haRad = hourAngle * .pi / 180
    let decRad = coordinates.declination.degrees * .pi / 180
    let latRad = location.latitude * .pi / 180

    let altRad = asin(sin(decRad) * sin(latRad) + cos(decRad) * cos(latRad) * cos(haRad))

    let aRad = acos((sin(decRad) - sin(altRad) * sin(latRad)) / (cos(altRad) * cos(latRad)))

    var azRad: Double
    if sin(haRad) < 0 {
      azRad = aRad
    } else {
      azRad = (2 * .pi) - aRad
    }

    self.altitudeDeg = altRad * 180 / .pi
    self.azimuthDeg = azRad * 180 / .pi
  }
}
