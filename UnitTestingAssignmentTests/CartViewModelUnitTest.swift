//
//  CartViewModelUnitTest.swift
//  UnitTestingAssignmentTests
//
//  Created by gvantsa gvagvalia on 5/12/24.
//

import XCTest
@testable import UnitTestingAssignment

final class CartViewModelUnitTest: XCTestCase {
    var viewModel: CartViewModel!
    
    override func setUpWithError() throws {
        viewModel = CartViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testSelectedItemsQuantity() {
        viewModel.selectedProducts = [
            Product(id: 10, selectedQuantity: 1),
            Product(id: 20, selectedQuantity: 2),
            Product(id: 30, selectedQuantity: 1),
        ]
        XCTAssertEqual(viewModel.selectedItemsQuantity, 4)
    }
    
    func testTotalPrice() {
        viewModel.selectedProducts = [
            Product(id: 10, price: 10, selectedQuantity: 1),
            Product(id: 20, price: 20, selectedQuantity: 2),
            Product(id: 30, price: 10, selectedQuantity: 1),
        ]
        XCTAssertEqual(viewModel.totalPrice, 60)
    }
    
    func testAddProductWithID() {
        let product1 = Product(id: 10, selectedQuantity: 1)
        let product2 = Product(id: 20)
        
        viewModel.allproducts = [product1, product2]
        
        viewModel.addProduct(withID: 10)
        viewModel.addProduct(withID: 10)
        viewModel.addProduct(withID: 20)
        
        XCTAssertEqual(viewModel.selectedProducts.count, 2)
        XCTAssertEqual(viewModel.selectedProducts.first?.id, 10)
        XCTAssertEqual(viewModel.selectedProducts.first?.selectedQuantity, 2)
    }
    
    func testAddToSelectedProducts() {
        let product1 = Product(id: 10, selectedQuantity: 1)
        let product2 = Product(id: 20, selectedQuantity: 1)
        
        viewModel.selectedProducts = []
        
        viewModel.addProduct(product: product1)
        viewModel.addProduct(product: product2)
        viewModel.addProduct(product: product2)
        
        XCTAssertEqual(viewModel.selectedProducts.count, 2)
        XCTAssertEqual(viewModel.selectedProducts[1].selectedQuantity, 2)
        
    }
    
    func testAddRandomProduct() {
        let product1 = Product(id: 10)
        let product2 = Product(id: 20)
        
        viewModel.allproducts = [product1, product2,]
        viewModel.addRandomProduct()
        
        // fეილია - 50/50-ზე
        XCTAssertEqual(viewModel.selectedProducts.first?.id, 10)
        XCTAssertEqual(viewModel.selectedProducts.count, 1)
    }
    
    func testRemoveProductWithID() {
        let product1 = Product(id: 10)
        let product2 = Product(id: 20)
        
        viewModel.selectedProducts.append(product1)
        viewModel.selectedProducts.append(product2)
        viewModel.removeProduct(withID: 10)
        
        XCTAssertEqual(viewModel.selectedProducts.count, 1)
        XCTAssertEqual(viewModel.selectedProducts.first?.id, 20)
        XCTAssertNil(viewModel.selectedProducts.first {$0.id == 10 })
    }
    
    func testClearCart() {
        let product1 = Product(id: 10)
        let product2 = Product(id: 20)
        let product3 = Product(id: 30)
        
        viewModel.selectedProducts = [product1, product2, product3]
        viewModel.clearCart()
        
        XCTAssertTrue(viewModel.selectedProducts.isEmpty)
    }
    
}
