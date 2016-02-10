//
//  KidTrackerTests.swift
//  KidTrackerTests
//
//  Created by 3delrb on 2/2/16.
//  Copyright © 2016 Ryan Burton. All rights reserved.
//

import XCTest
@testable import KidTracker

class KidTrackerTests: XCTestCase {
    
    // Tests to confirm that the Moment initializer returns when no name or a negative rating is provided.
    func testMealInitialization() {
        // Success case.
        let potentialItem = Moment(name: "Newest moment", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        // Failure cases.
        let noName = Moment(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Moment(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating)
        
        
    }
    
}
