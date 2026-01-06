//
//  KixTests.swift
//  KixTests
//
//  Created by Konstanty Halets on 06/01/2026.
//

import XCTest
@testable import Kix

final class KixTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testCartCalculations() throws {
        let cartManager = CartManager()
        let product1 = Product(id: UUID(), name: "Test Shoe 1", brand: "BrandA", price: 100, imageName: "", isFavorite: false, description: "")
        let product2 = Product(id: UUID(), name: "Test Shoe 2", brand: "BrandB", price: 200, imageName: "", isFavorite: false, description: "")
        cartManager.addToCart(product: product1)
        cartManager.addToCart(product: product2)
        cartManager.addToCart(product: product2)
        XCTAssertEqual(cartManager.items.count, 2)
        XCTAssertEqual(cartManager.items.first(where: { $0.product.id == product1.id })?.quantity, 1)
        XCTAssertEqual(cartManager.items.first(where: { $0.product.id == product2.id })?.quantity, 2)
        XCTAssertEqual(cartManager.totalPrice(), 500)
        cartManager.decreaseQuantity(item: cartManager.items.first(where: { $0.product.id == product2.id })!)
        XCTAssertEqual(cartManager.items.first(where: { $0.product.id == product2.id })?.quantity, 1)
        cartManager.clearCart()
        XCTAssertEqual(cartManager.items.count, 0)
    }

    func testFavoritesLogic() throws {
        let favoritesManager = FavoritesManager()
        let product = Product(id: UUID(), name: "Test Shoe", brand: "BrandA", price: 100, imageName: "", isFavorite: false, description: "")
        XCTAssertFalse(favoritesManager.isFavorite(product))
        favoritesManager.toggleFavorite(product)
        XCTAssertTrue(favoritesManager.isFavorite(product))
        favoritesManager.toggleFavorite(product)
        XCTAssertFalse(favoritesManager.isFavorite(product))
    }

    func testNotesCRUD() throws {
        let notesManager = NotesManager()
        notesManager.addNote(text: "First note")
        XCTAssertEqual(notesManager.notes.count, 1)
        let note = notesManager.notes.first!
        notesManager.updateNote(note, newText: "Updated note")
        XCTAssertEqual(notesManager.notes.first?.text, "Updated note")
        notesManager.deleteNote(note)
        XCTAssertEqual(notesManager.notes.count, 0)
    }

}
