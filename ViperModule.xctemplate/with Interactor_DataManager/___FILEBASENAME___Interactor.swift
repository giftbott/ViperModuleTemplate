//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class ___FILEBASENAMEASIDENTIFIER___Interactor {
  weak var presenter: ___FILEBASENAMEASIDENTIFIER___InteractorOutputProtocol!
  let dataManager: ___FILEBASENAMEASIDENTIFIER___DataManagerInputProtocol

  init(dataManager: ___FILEBASENAMEASIDENTIFIER___DataManagerInputProtocol) {
    self.dataManager = dataManager
  }
}


//MARK: InteractorInputProtocol
extension ___FILEBASENAMEASIDENTIFIER___Interactor: ___FILEBASENAMEASIDENTIFIER___InteractorInputProtocol {
	
}

//MARK: DataManagerOutputProtocol
extension ___FILEBASENAMEASIDENTIFIER___Interactor: ___FILEBASENAMEASIDENTIFIER___DataManagerOutputProtocol {

}
