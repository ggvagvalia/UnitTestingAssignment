//
//  UnitTestViewModelsNetworkManager.swift
//  UnitTestingAssignmentTests
//
//  Created by gvantsa gvagvalia on 5/13/24.
//

import XCTest
@testable import UnitTestingAssignment

protocol FetchProductNetworkManager {
    func fetchProducts(completion: @escaping (Result<[Product], Error>) -> Void)
}

class MockNetworkManager: FetchProductNetworkManager {
    func fetchProducts(completion: @escaping (Result<[UnitTestingAssignment.Product], any Error>) -> Void) {
        let product1 = Product(id: 10, title: "product1")
        let product2 = Product(id: 20, title: "product2")
        
        let products: [Product] = [product1, product2]
        completion(.success(products))
    }
}

final class UnitTestViewModelsNetworkManager: XCTestCase {
    var viewModel: CartViewModel!
    var fetchProductNetworkManager: FetchProductNetworkManager!
    
    override func setUpWithError() throws {
        viewModel = CartViewModel()
        fetchProductNetworkManager = MockNetworkManager()
        
        fetchProductNetworkManager.fetchProducts { result in
            switch result {
            case .success(let success):
                self.viewModel.allproducts = success
                print("\(String(describing: success.first?.title ?? ""))")
            case .failure(let failure):
                print("\(failure) - xxx")
            }
        }
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        fetchProductNetworkManager = nil
    }
    
    func testFetchedProducts() {
        XCTAssertEqual(viewModel.allproducts?.count, 2)
        XCTAssertEqual(viewModel.allproducts?[0].id, 10)
        XCTAssertEqual(viewModel.allproducts?[0].title, "product1")
    }
    
}

