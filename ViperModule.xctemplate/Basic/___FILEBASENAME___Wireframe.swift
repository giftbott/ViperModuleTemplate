//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ___FILEBASENAMEASIDENTIFIER___Wireframe: ___FILEBASENAMEASIDENTIFIER___WireframeProtocol {
  weak var view: UIViewController?
    
  static func create___FILEBASENAMEASIDENTIFIER___Module() -> UIViewController {
    let view = ___FILEBASENAMEASIDENTIFIER___ViewController()
    let wireframe = ___FILEBASENAMEASIDENTIFIER___Wireframe()
    let presenter = ___FILEBASENAMEASIDENTIFIER___Presenter()
        
    view.presenter = presenter
    presenter.view = view
    presenter.wireframe = wireframe
        
    return view
  }
}
