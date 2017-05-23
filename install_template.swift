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

/// Select Template, only if more than one template
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
  print("Select Template")
  print(String(repeating: "#", count:30))
  print(templates.enumerated().map { String(describing: "\($0): \($1)") }.joined(separator: "\n"))
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
    print()
    break
  }

  
  installTemplate(templateName)
}


/// Copy template
func installTemplate(_ templateName: String) {

  // Print Target Directory Path
  print("Select Directory Path to Install Template")
  print(String(repeating: "#", count:40))
  print("0: Custom File Template")
  print("1: Custom Project Template")
  print("2: Xcode File Template (admin only)")
  print("3: Xcode Project Template (admin only)")
  print(String(repeating: "#", count:40), terminator: "\n\n")


  // Select Target
  let customTemplatePath = "/Users/".appending(bash(command: "whoami", arguments: []))
  let XcodeTemplatePath = bash(command: "xcode-select", arguments: ["--print-path"])

  // Default Path
  var directoryPath = customTemplatePath
  var pathEndPoint = "/Library/Developer/Xcode/Templates/File Templates/Custom"

  while true {
    print("Select Target Path Number : ", terminator: "")
    let input = readLine() ?? "0"
    guard let num = Int(input), num >= 0, num < 4 else {
      print("Wrong Value\n")
      continue
    }

    switch num {
    case 0:
      if isRootUserWithSudoCommand(selectNumber: 0) {
        print("CustomTemplate must be executed without sudo command")
        return
      }
      break
    case 1:
      if isRootUserWithSudoCommand(selectNumber: 1) {
        print("CustomTemplate must be executed without sudo command")
        return
      }
      pathEndPoint = "/Library/Developer/Xcode/Templates/Project Templates/Custom"
      directoryPath = customTemplatePath
    case 2:
      if !isRootUserWithSudoCommand(selectNumber: 2) {
        print("XcodeTemplatePath need to be executed with sudo command")
        return
      }
      pathEndPoint = "/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/File Templates/Source"
      directoryPath = XcodeTemplatePath
    case 3:
      if !isRootUserWithSudoCommand(selectNumber: 3) {
        print("XcodeTemplatePath need to be executed with sudo command")
        return
      }
      pathEndPoint = "/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Templates/Project Templates/iOS/Application"
      directoryPath = XcodeTemplatePath
    default:
      break
    }

    directoryPath.append(pathEndPoint)

    printInConsole("Template will be installed at \(directoryPath)")
    break
  }


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

func isRootUserWithSudoCommand(selectNumber: Int) -> Bool {
  return bash(command: "whoami", arguments: []) == "root"
}

/// Print Helper
func printInConsole(_ message: String) {
  print(">>>>", message)
}



//===============
//MARK: - Execute
//===============
setup()
