import Coordinates
import Foundation
import CoreLocation

//func calculateJD(year: Int, month: Int, day: Int, utcTime: Double) -> Double {
//  let first = 367 * year - 7 * (year + (month + 9) / 12) / 4
//  let second = 3 * ((year + (month - 9) / 7) / 100 + 1) / 4
//  let third = Double(275 * month / 9 + day) + 1721028.5 + utcTime / 24
//
//  return Double(first) - Double(second) + third
//}





@main
struct Runner {
  static func main() {
    //let siriusCoordinates = EquatorialCoordinates(rightAscension: .init(hours: 6, minutes: 45), declination: .init(-16.7))
    //let siriusCoordinates = EquatorialCoordinates("06 45 -16.7")!
    //print(siriusCoordinates)

//   As a concrete example, I shall calculate the ALT and AZ of the Messier object M13 for 10th August 1998 at 2310 hrs UT, for Birmingham UK. The RA and DEC of M13 are given as:

//    RA  = 16 h 41.7 min
//    DEC = 36 d 28   min
//
//    according to The Cambridge Star Atlas, and my old school atlas gives the latitude and longitude of Birmingham UK as;
//
//    LAT = 52 d 30 min North
//    LONG = 1 d 55 min West

//    We will need these figures in decimal form, along with the time;
//
//         RA   = 16 h 41.7 min     = 16 + 41.7/60 = 16.695     hrs
//         DEC  = 36 d 28   min     = 36 + 28/60   = 36.466667  degs
//         Time = 2310 hrs          = 23 + 10/60   = 23.166667  hrs
//         LAT  = 52 d 30 min North = 52 + 30/60   = 52.5       degs
//         LONG =  1 d 55 min West  = -(1 + 55/60) = -1.9166667 degs
//
//    It is a good idea to keep all the decimal places in the figures until the calculation is complete, then round off later on. Notice how Longitudes west are counted as negative, and East counted as positive. We will also need the RA in degrees, not hours. Just multiply the hours figure by 15;
//
//                RA  = 16.695 * 15 = 250.425 degrees


    let m13Coordinates = EquatorialCoordinates(rightAscension: .init(hours: 16, minutes: 41.7),
                                               declination: .init(degrees: 36, minutes: 28))

    let birminghamUKLoc = CLLocationCoordinate2D(latitude: 52.5, longitude: -1.9166667)
    let exampleDate = try! Date("1998-08-10T23:10:00Z", strategy: .iso8601)

    print(exampleDate.daysSince(epoch: .j2000))
    let lst = exampleDate.localSiderealTime(longitude: birminghamUKLoc.longitude)
    print(lst)

    let hourAngle = hourAngle(of: m13Coordinates.rightAscension, location: birminghamUKLoc, date: exampleDate)
    print(hourAngle)

    let (alt, az) = altAz(of: m13Coordinates, location: birminghamUKLoc, date: exampleDate)
    print(alt * 180 / .pi)
    print(az * 180 / .pi)
  }
}

func hourAngle(of ra: RightAscension, location: CLLocationCoordinate2D, date: Date) -> Double {
  let lst = date.localSiderealTime(longitude: location.longitude)
  var angle = lst - ra.degrees
  if angle < 0 { angle += 360 }
  return angle
}

func altAz(of coordinates: EquatorialCoordinates, location: CLLocationCoordinate2D, date: Date) -> (Double, Double) {
  let hourAngle = hourAngle(of: coordinates.rightAscension, location: location, date: date)

  let haRad = hourAngle * .pi / 180
  let decRad = coordinates.declination.degrees * .pi / 180
  let latRad = location.latitude * .pi / 180

  let sinAlt = sin(decRad) * sin(latRad) + cos(decRad) * cos(latRad) * cos(haRad)
  let alt = asin(sinAlt)

  let cosA = (sin(decRad) - sin(alt) * sin(latRad)) / (cos(alt) * cos(latRad))
  let a = acos(cosA)

  var az: Double
  if sin(haRad) < 0 {
    az = a
  } else {
    az = (2 * .pi) - a
  }
  return (alt, az)
}
