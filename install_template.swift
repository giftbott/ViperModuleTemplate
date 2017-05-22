//
//  install_template.swift
//  Install VIPER Template
//
//  Created by giftbott on 17/02/2017.
//  Copyright © 2017 giftbott. All rights reserved.
//

//=============
//MARK: Declare
//=============
import Foundation


let fileManager = FileManager.default

/// Select template
func setup() {
  let contentsFilter = try? fileManager
    .contentsOfDirectory(atPath: ".")
    .filter { $0.hasSuffix(".xctemplate") }
  
  guard let templates = contentsFilter, templates.count > 0 else {
    printInConsole("xctemplate directory does not exist")
    return
  }

  guard templates.count > 1 else {
      installTemplate(templates[0])
      return
  }
  
  /// Show xctemplates in current directory
  print(String(repeating: "#", count:30))
  let _ = templates.enumerated().map { print("\($0): \($1)") }
  print(String(repeating: "#", count:30), terminator: "\n\n")
  
  
  /// User select xctemplate
  var templateName: String = templates[0]
 
  while true {
    print("Select template number : ", terminator: "")
    let input = readLine() ?? "0"
    guard let num = Int(input), num >= 0, num < templates.count else {
      print("Wrong Value\n")
      continue
    }
    
    templateName = templates[num]
    printInConsole("\(templateName) is selected")
    break
  }

  /// Copy template!
  installTemplate(templateName)
}


/// Copy template
func installTemplate(_ templateName: String) {
  let pathEndPoint = "/Library/Developer/Xcode/Templates/File Templates/Custom"
  let directoryPath = "/Users/".appending(bash(command: "whoami", arguments: [])).appending(pathEndPoint)

  //Uncomment this, if you want to add your template to Xcode system templates. then your templates will be shown at Topside
  //Info : 1. This needs admin authority  2. Change directoryPath (let -> var)
  //directoryPath = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project Templates/iOS/Application"

  let filePath = directoryPath.appending("/\(templateName)")

  do {
    let _ = bash(command: "mkdir", arguments: ["-p", directoryPath])
    
    printInConsole(".....")
    defer { print() }
    
    if !fileManager.fileExists(atPath: filePath){
      try fileManager.copyItem(atPath: templateName, toPath: filePath)
      
      printInConsole("Template installed succesfully.")
      
    }
    else{
      try _ = fileManager.removeItem(atPath: filePath)
      try fileManager.copyItem(atPath: templateName, toPath: filePath)
      
      printInConsole("Template has been replaced succesfully.")
    }
  }
  catch let error as NSError {
    printInConsole("Ooops! Something went wrong: \(error.localizedFailureReason!)")
  }
}


/// Bash Shell Command
func bash(command: String, arguments: [String]) -> String {
  let commandPath = shell(launchPath: "/bin/bash", arguments: ["-c", "which \(command)" ])
  return shell(launchPath: commandPath, arguments: arguments)
}

func shell(launchPath: String, arguments: [String]) -> String {
  let task = Process()
  task.launchPath = launchPath
  task.arguments = arguments
  
  let pipe = Pipe()
  task.standardOutput = pipe
  task.launch()
  
  let data = pipe.fileHandleForReading.readDataToEndOfFile()
  let output = String(data: data, encoding: String.Encoding.utf8)!
  
  return output.trimmingCharacters(in: .newlines)
}


/// Print Helper
func printInConsole(_ message: String) {
  print(">>>>", message)
}



//===============
//MARK: - Execute
//===============
setup()
