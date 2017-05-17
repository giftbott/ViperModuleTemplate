//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

//MARK: View
protocol ___FILEBASENAMEASIDENTIFIER___ViewProtocol: class {
  var presenter: ___FILEBASENAMEASIDENTIFIER___PresenterProtocol?  { get set }

  // Presenter -> View
}

//MARK: Wireframe
protocol ___FILEBASENAMEASIDENTIFIER___WireframeProtocol: class {
  static func createModule() -> UIViewController

  // Presenter -> Wireframe
}

//MARK: Presenter
protocol ___FILEBASENAMEASIDENTIFIER___PresenterProtocol: class {
  var view: ___FILEBASENAMEASIDENTIFIER___ViewProtocol? { get set }
  var interactor: ___FILEBASENAMEASIDENTIFIER___InteractorInputProtocol? { get set }
  var wireframe: ___FILEBASENAMEASIDENTIFIER___WireframeProtocol? { get set }
  
  // View -> Presenter
  func viewDidLoad()
}

//MARK: Interactor
protocol ___FILEBASENAMEASIDENTIFIER___InteractorOutputProtocol: class {
  // Interactor -> Presenter
}

protocol ___FILEBASENAMEASIDENTIFIER___InteractorInputProtocol: class {
  var presenter: ___FILEBASENAMEASIDENTIFIER___InteractorOutputProtocol?  { get set }
  var dataManager: ___FILEBASENAMEASIDENTIFIER___DataManagerInputProtocol? { get set }

  // Presenter -> Interactor
}

//MARK: DataManager
protocol ___FILEBASENAMEASIDENTIFIER___DataManagerInputProtocol: class {
  var dataHandler: ___FILEBASENAMEASIDENTIFIER___DataManagerOutputProtocol? { get set } 

  // INTERACTOR -> DATAMANAGER
}

protocol ___FILEBASENAMEASIDENTIFIER___DataManagerOutputProtocol: class {
  // DATAMANAGER -> INTERACTOR
}

