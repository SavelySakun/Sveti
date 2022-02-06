import XCTest
@testable import Sveti

class BackupTests: XCTestCase {

  private let sut = BackupManager()
  private let backgroundQueue = DispatchQueue.global(qos: .background)

  private func checkResult(expectedBackupState: BackupState?, expectedError: String?, testResult: (BackupInfo?, String?), file: StaticString = #file, line: UInt = #line) {

    let resultBackupInfo = testResult.0
    let resultError = testResult.1

    if let expectedBackupState = expectedBackupState {
      XCTAssertEqual(expectedBackupState, resultBackupInfo?.state)
    } else if let expectedError = expectedError {
      XCTAssertEqual(expectedError, resultError)
    }
  }

  private func runInAsyncQueueWithExpectation(expectationDescription: String = "Background API call finished", timeout: TimeInterval = 5, delayForOperation: TimeInterval = 0, operation: @escaping ((XCTestExpectation) -> Void)) {
    let expectation = XCTestExpectation(description: expectationDescription)
    backgroundQueue.asyncAfter(deadline: .now() + delayForOperation) {
      operation(expectation)
    }
    wait(for: [expectation], timeout: timeout)
  }

  func testA_loadNotExistingBackup() {
    runInAsyncQueueWithExpectation { expectation in
      self.sut.loadBackupFromCloudKit { backupInfo, error in
        self.checkResult(expectedBackupState: .noBackupFound,
                    expectedError: nil, testResult: (backupInfo, error))
        expectation.fulfill()
      }
    }
  }

  func testB_createBackup() {
    runInAsyncQueueWithExpectation(timeout: 10) { expectation in
      self.sut.createBackupInCloudKit { backupInfo, error in
        self.checkResult(expectedBackupState: .successBackupedToCloud,
                    expectedError: nil, testResult: (backupInfo, error))
        expectation.fulfill()
      }
    }
  }

  func testC_loadExistingBackup() {
    runInAsyncQueueWithExpectation(delayForOperation: 2) { expectation in
      self.sut.loadBackupFromCloudKit { backupInfo, error in
        self.checkResult(expectedBackupState: .readyToRestoreBackup,
                    expectedError: nil, testResult: (backupInfo, error))
        expectation.fulfill()
      }
    }
  }

  func testD_updateBackup() {
    runInAsyncQueueWithExpectation { expectation in
      self.sut.updateExistingBackupRecord { backupInfo, error in
        self.checkResult(expectedBackupState: .successBackupedToCloud,
                    expectedError: nil, testResult: (backupInfo, error))
        expectation.fulfill()
      }
    }
  }

  func testE_restoreBackup() {
    runInAsyncQueueWithExpectation { expectation in
      self.sut.restoreBackup { backupInfo, error in
        self.checkResult(expectedBackupState: .successDataRestore,
                    expectedError: nil, testResult: (backupInfo, error))
        expectation.fulfill()
      }
    }
  }

  func testH_deleteBackupFromCloudKit() {
    runInAsyncQueueWithExpectation { expectation in
      self.sut.deleteBackupFromCloudKit { backupInfo, error in
        self.checkResult(expectedBackupState: .backupDeleted,
                    expectedError: nil, testResult: (backupInfo, error))
        expectation.fulfill()
      }
    }
  }
}
