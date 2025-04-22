import XCTest

@testable import func src_sample_library.MyFunction

class SampleLibraryTests: XCTestCase {
    func testExample() {
        // Given
        let expected_output = "Hello from a bazelized MacOS Swift App!"

        // When
        let result = MyFunction()

        // Then
        XCTAssertEqual(result, expected_output, "MyFunction should return the correct string")
    }
}
