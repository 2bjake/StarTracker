import Foundation

public enum Epoch { case j2000 }

extension Date {
  public var julianDate: Double { timeIntervalSince1970 / 86400 + 2440587.5 }

  public func daysSince(epoch: Epoch) -> Double {
    switch epoch {
      case .j2000: return julianDate - 2451545.0
    }
  }

  //longitude is in decimal degrees, East is positive.
  public func localSiderealTimeDegrees(epoch: Epoch = .j2000, longitude: Double) -> Double {
    let components = Calendar.current.dateComponents(in: TimeZone(secondsFromGMT: 0)!, from: self)
    let universalTime = Double(components.hour!) + Double(components.minute!) / 60 + Double(components.second!) / 3600

    var angle: Double
    switch epoch {
      case .j2000: angle = 100.46 + 0.985647 * daysSince(epoch: epoch) + longitude + 15 * universalTime
    }

    while angle < 0 { angle += 360 }
    while angle > 360 { angle -= 360 }
    return angle
  }
}

//func calculateJD(year: Int, month: Int, day: Int, utcTime: Double) -> Double {
//  var result = Double(367 * year - 7 * (year + (month + 9) / 12) / 4)
//  result -= Double(3 * ((year + (month - 9) / 7) / 100 + 1) / 4)
//  result += Double(275 * month / 9 + day) + 1721028.5 + utcTime / 24
//  return result
//}
//
//func calculateJD(date: Date) -> Double {
//  let components = Calendar.current.dateComponents(in: TimeZone(secondsFromGMT: 0)!, from: date)
//  let day = components.day!
//  let month = components.month!
//  let year = components.year!
//  let time = Double(components.hour!) + Double(components.minute!) / 60 + Double(components.second!) / 3600
//
//  return calculateJD(year: year, month: month, day: day, utcTime: time)
//}
