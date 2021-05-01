//
//  AirportViewModelTests.swift
//  AirportAppUnitTests
//
//  Created by Leonardo Maia Pugliese on 01/05/21.
//
@testable import AirportApp
import XCTest
import Combine

class AirportMapViewModelTests: XCTestCase {

    var sut: AirportsMapBaseViewModel!
        
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_ShouldReturnAnnotationPublisherWithThreeAirportAnnotations() {
        
        sut = AirportsMapViewModel(airportManager: AirportGenerator.generateAirportManagerSuccesfullReturn(), coordinator: AirportGenerator.generateAirportCoordinatorMock())
        let expectation = XCTestExpectation(description: "Publishes until value isn't nil")
        var currentAirportAnnotationValues: [AirportAnnotation] = []
        var bindings = Set<AnyCancellable>()

        sut.getAnnotationPublisher().sink(
            receiveValue: { value in
                currentAirportAnnotationValues.append(contentsOf: value)
                if !currentAirportAnnotationValues.isEmpty {
                    expectation.fulfill()
                }
            }
        )
        .store(in: &bindings)
        
        wait(for: [expectation], timeout: 1)
        let resultList = AirportGenerator.generateAirportListAnnotationWithThreeElements()
        
        for airportAnnotation in currentAirportAnnotationValues {
            XCTAssertTrue(resultList.contains {$0.airport.id == airportAnnotation.airport.id } )
        }
    }
    
    func test_ShouldReturnAirportMapViewModelStatePublisher() {
        
        sut = AirportsMapViewModel(airportManager: AirportGenerator.generateAirportManagerSuccesfullReturn(), coordinator: AirportGenerator.generateAirportCoordinatorMock())
        let expectation = XCTestExpectation(description: "Publishes until value isn't nil")
        var stateValues: [ViewModelLoadingState] = []
        var currentAirportAnnotationValues: [AirportAnnotation] = []
        var bindings = Set<AnyCancellable>()
        
        sut.getAirportsMapViewModelStatePublisher().sink { viewModelLoadingState in
            stateValues.append(viewModelLoadingState)
        }.store(in: &bindings)
        
        sut.getAnnotationPublisher().sink(
            receiveValue: { value in
                currentAirportAnnotationValues.append(contentsOf: value)
                if !currentAirportAnnotationValues.isEmpty {
                    expectation.fulfill()
                }
            }
        )
        .store(in: &bindings)
        
        wait(for: [expectation], timeout: 1)
        
        XCTAssertEqual(stateValues.count, 2)
    }
    
    func test_ShouldTheFirstLoadingStateAlwaysBeLoading() {
        
        sut = AirportsMapViewModel(airportManager: AirportGenerator.generateAirportManagerSuccesfullReturn(), coordinator: AirportGenerator.generateAirportCoordinatorMock())
        let expectation = XCTestExpectation(description: "Publishes until value isn't nil")
        var stateValues: [ViewModelLoadingState] = []
        var currentAirportAnnotationValues: [AirportAnnotation] = []
        var bindings = Set<AnyCancellable>()
        
        sut.getAirportsMapViewModelStatePublisher().sink { viewModelLoadingState in
            stateValues.append(viewModelLoadingState)
        }.store(in: &bindings)
        
        sut.getAnnotationPublisher().sink(
            receiveValue: { value in
                currentAirportAnnotationValues.append(contentsOf: value)
                if !currentAirportAnnotationValues.isEmpty {
                    expectation.fulfill()
                }
            }
        )
        .store(in: &bindings)
        
        wait(for: [expectation], timeout: 1)
        
        switch stateValues[0] {
        case .loading:
            break
        case .finishedLoading,.error(_):
            XCTFail("Expected to receive only one value, got another (\(stateValues[0]))")
        }
    }
    
    func test_ShouldTheSecondLoadingStateBeFinished() {
        
        sut = AirportsMapViewModel(airportManager: AirportGenerator.generateAirportManagerSuccesfullReturn(), coordinator: AirportGenerator.generateAirportCoordinatorMock())
        let expectation = XCTestExpectation(description: "Publishes until value isn't nil")
        var stateValues: [ViewModelLoadingState] = []
        var currentAirportAnnotationValues: [AirportAnnotation] = []
        var bindings = Set<AnyCancellable>()
        
        sut.getAirportsMapViewModelStatePublisher().sink { viewModelLoadingState in
            stateValues.append(viewModelLoadingState)
        }.store(in: &bindings)
        
        sut.getAnnotationPublisher().sink(
            receiveValue: { value in
                currentAirportAnnotationValues.append(contentsOf: value)
                if !currentAirportAnnotationValues.isEmpty {
                    expectation.fulfill()
                }
            }
        )
        .store(in: &bindings)
        
        wait(for: [expectation], timeout: 1)
        
        switch stateValues[1] {
        case .finishedLoading:
            break
        case .loading,.error(_):
            XCTFail("Expected to receive only one value, got another (\(stateValues[0]))")
        }
    }
    
    func test_AirportPassthroughtSubjectShouldNotSendErrorState() {
        sut = AirportsMapViewModel(airportManager: AirportGenerator.generateAirportManagerSuccesfullReturn(), coordinator: AirportGenerator.generateAirportCoordinatorMock())
        
        let expectation = XCTestExpectation(description: "Should not be more than 1 state sended")
        var bindings = Set<AnyCancellable>()
        var stateValues: [ViewModelLoadingState] = []
        var currentAirportAnnotationValues: [AirportAnnotation] = []

        sut.getAirportsMapViewModelStatePublisher().sink { viewModelLoadingState in
            stateValues.append(viewModelLoadingState)
        }.store(in: &bindings)
        
        sut.getAnnotationPublisher().sink(
            receiveValue: { value in
                currentAirportAnnotationValues.append(contentsOf: value)
                if !currentAirportAnnotationValues.isEmpty {
                    expectation.fulfill()
                }
            }
        )
        .store(in: &bindings)
        
        wait(for: [expectation], timeout: 1)
        
        print(stateValues,"💮💮💮💮")
                
        XCTAssertEqual(stateValues.count, 2)
        
        sut.getAirportPassthroughSubject().send(AirportGenerator.generateAirportListWithThreeElements()[1])
        
        XCTAssertEqual(stateValues.count, 2)
    }
    
    func test_AirportPassthroughtSubjectShouldSendErrorState() {
        sut = AirportsMapViewModel(airportManager: AirportGenerator.generateAirportManagerEmptyReturn(), coordinator: AirportGenerator.generateAirportCoordinatorMock())
        
        let expectation = XCTestExpectation(description: "Should not be more than 1 state sended")
        var bindings = Set<AnyCancellable>()
        var stateValues: [ViewModelLoadingState] = []
        
        sut.getAirportsMapViewModelStatePublisher().sink { viewModelLoadingState in
            stateValues.append(viewModelLoadingState)
            switch viewModelLoadingState {
            case .loading, .finishedLoading:
                break
            case .error(_):
                expectation.fulfill()
            }
        }.store(in: &bindings)
        
        sut.getAirportPassthroughSubject().send(AirportGenerator.generateAirportListWithThreeElements()[1])
        
        
        wait(for: [expectation], timeout: 2)
                
        XCTAssertEqual(stateValues.count, 2)
    }
}
