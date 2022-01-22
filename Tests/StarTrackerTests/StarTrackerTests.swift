import XCTest
import StarTracker

final class StarTrackerTests: XCTestCase {
  private func validate(_ instruction: AzimuthInstruction, _ heading: CardinalDirection, _ shouldRotateClockwise: Bool, _ adjustedAngle: Double) {
    XCTAssertEqual(instruction.heading, heading)
    XCTAssertEqual(instruction.shouldRotateClockwise, shouldRotateClockwise)
    XCTAssertEqual(instruction.adjustedAngle, adjustedAngle)
  }

  func testAzimuthInstruction() throws {
    validate(AzimuthInstruction(angle: 45), .east, false, 45)
    validate(AzimuthInstruction(angle: 0), .north, true, 0)
    validate(AzimuthInstruction(angle: 215), .south, true, 215 - 180)
    validate(AzimuthInstruction(angle: 359), .north, false, 1)
    validate(AzimuthInstruction(angle: 271), .west, true, 1)
    validate(AzimuthInstruction(angle: 5), .north, true, 5)
  }
}
