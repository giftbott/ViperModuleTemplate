//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ___FILEBASENAMEASIDENTIFIER___WireframeProtocol: class {
  // Presenter -> Wireframe
}

final class ___FILEBASENAMEASIDENTIFIER___Wireframe {
  weak var view: ___FILEBASENAMEASIDENTIFIER___ViewController!
  
  static func createModule() -> ___FILEBASENAMEASIDENTIFIER___ViewController {
    let view = ___FILEBASENAMEASIDENTIFIER___ViewController()
    let wireframe = ___FILEBASENAMEASIDENTIFIER___Wireframe()
    let presenter = ___FILEBASENAMEASIDENTIFIER___Presenter(view: view, wireframe: wireframe)
    
    view.presenter = presenter
    wireframe.view = view
    
    return view
  }
}

// MARK: - WireframeProtocol

extension ___FILEBASENAMEASIDENTIFIER___Wireframe: ___FILEBASENAMEASIDENTIFIER___WireframeProtocol {
  
}
