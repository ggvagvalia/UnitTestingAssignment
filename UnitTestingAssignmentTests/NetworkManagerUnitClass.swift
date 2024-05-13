//
//  UnitClassForNetworkManager.swift
//  UnitTestingAssignmentTests
//
//  Created by gvantsa gvagvalia on 5/13/24.
//

import XCTest
@testable import UnitTestingAssignment

final class NetworkManagerUnitClass: XCTestCase {
    func testFetchedProducts() {
        
        let expectation = self.expectation(description: "fetching products from API")
        let apiURL = URL(string: "https://dummyjson.com/products")!
        
        URLSession.shared.dataTask(with: apiURL) { data, response, error in
            XCTAssertNil(error, "მოხდა შეცდომა \(error?.localizedDescription ?? "")")
            XCTAssertNotNil(data, "no data")
            
            do {
                let decoder = JSONDecoder()
                let productsResponce = try decoder.decode(Sasass.self, from: data!)
                XCTAssertFalse(productsResponce.products.isEmpty, "no produts")
                for product in productsResponce.products {
                    print(product.title ?? "xxx")
                    XCTAssertNotNil(product.id, "id should not be nil")
                }
                expectation.fulfill()
            } catch {
                XCTFail("couldn't decode - \(error.localizedDescription)")
            }
        }.resume()
        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
