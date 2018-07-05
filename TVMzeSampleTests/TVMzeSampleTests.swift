//
//  TVMzeSampleTests.swift
//  TVMzeSampleTests
//
//  Created by Dylan Bruschi on 7/3/18.
//  Copyright © 2018 Dylan Bruschi. All rights reserved.
//

import XCTest
@testable import TVMazeSample

class TVMzeSampleTests: XCTestCase {
    
    var apiClient: APIClient!
    let session = MockURLSession()
    
    override func setUp() {
        super.setUp()
        apiClient = APIClient(session: session)
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetRequestWithURL() {
        
        
        guard let url = URL(string: apiUrlString) else {
            fatalError("URL can't be empty")
        }
        
        apiClient.get(url: url) { (data, response) in
            // data here
        }
        
        XCTAssert(session.lastURL == url)
        
    }
    
    func testGetResumeCalled() {
        
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        guard let url = URL(string: apiUrlString) else {
            fatalError("URL can't be empty")
        }
        
        apiClient.get(url: url) { (success, response) in
            // Return data
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)
        
        session.nextData = expectedData
        
        var actualData: Data?
        
        guard let url = URL(string: apiUrlString) else {
            fatalError("URL can't be empty")
        }
        
        apiClient.get(url: url) { (data, error) in
            actualData = data
        }
        
        XCTAssertNotNil(actualData)
    }
    
}
