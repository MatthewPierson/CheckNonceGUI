//
//  ViewController.swift
//  CheckNonceGUI
//
//  Created by matty on 1/11/19.
//  Copyright © 2019 matty. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var path = ("null")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let alert = NSAlert.init()
        alert.messageText = "Information"
        alert.informativeText = "Press OK to continue to the app\n\nAPP MUST BE INSTALLED TO /Applications !!! IF IT IS NOT INSTALLED THERE, CLOSE THE APP AND MOVE IT THERE\n\nPlease try using your brain before you spam me on twitter/github/discord asking stupid questions."
        alert.addButton(withTitle: "OK")
        alert.runModal()
        view.window?.level = .floating
        
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var filename_field: NSTextField!
    
    
    @IBAction func helpButton(_ sender: NSButton) {
        let alert = NSAlert.init()
        alert.messageText = "Version 0.0.6"
        alert.informativeText = "Just a simple GUI for my Checkm8 Nonce Setter. Is mostly written in Swift, besides the stuff that interacts with the device as I am way too retarded to remake that in Swift. This is my first attempt at Swift so expect it to be broken and rubbish.\n\nCurrent device support is:\n\niPhone 5s, iPhone 7/7 Plus, iPhone X\niPad Mini 2, iPad Mini 3, iPad Air,\niPad 6th Gen, iPad 7th Gen\niPod Touch 7th Gen\n\nJust run each button in order and follow any prompts that pop up.\n\nIf the app looks frozen during the irecovery stuff, don't worry, it's most likely fine just freezes while it waits for irecovery to do its thing."
        alert.addButton(withTitle: "Go Back")
        alert.runModal()
    }
    
    @IBAction func browseFile(sender: AnyObject) {
        
        let dialog = NSOpenPanel();
        
        dialog.title                   = "Choose a .shsh or .shsh2 file";
        dialog.showsResizeIndicator    = true;
        dialog.showsHiddenFiles        = false;
        dialog.canChooseDirectories    = false;
        dialog.canCreateDirectories    = false;
        dialog.allowsMultipleSelection = false;
        dialog.allowedFileTypes        = ["shsh2", "shsh"];

        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.url // Pathname of the file
            
            if (result != nil) {
                let path = result!.path
                filename_field.stringValue = path
                    print("SHSH location is:", path)
                    
            }
            
        } else {
            print("Why'd you cancel me =(")
            return
        }
        
    }
   
    func irecoveryStuff(argu: String) {
        
        let process = Process()
        process.executableURL = URL(fileURLWithPath:"/Applications/CheckNonceGUI.app/Contents/Resources/irecovery")
        process.arguments = ["\(argu)"]
        process.terminationHandler = { (process) in
           print("\ndidFinish: \(!process.isRunning)")
        print("did \(argu)")
        }
        do {
          try process.run()
        } catch {}
    }

    
    @IBAction func setGenerator(_ sender: NSButton) {
        
        print("Entering PWNDFU mode")
        let path = "/bin/sh"
        let arguments = ["/Applications/CheckNonceGUI.app/Contents/Resources/rec.sh"]
        sender.isEnabled = false
        let task = Process.launchedProcess(launchPath: path, arguments: arguments)
        task.waitUntilExit()
        sender.isEnabled = true
        let alert = NSAlert.init()
        alert.messageText = "iRecovery"
        alert.informativeText = "iRecovery stuff should be done"
        alert.addButton(withTitle: "Continue")
        alert.runModal()
        print("Entered recovery mode")
        print("Getting generator from SHSH ")
        let shshLocation = filename_field.stringValue
        
        if shshLocation != nil {
            do {
                let contents = try String(contentsOfFile: shshLocation)
                var noGenerator = contents.contains("generator")
                if noGenerator == true {
                    print("SHSH contains generator, is valid for this tool")
                    let resourceFileDictionary = NSDictionary(contentsOfFile: shshLocation)
                    let s = resourceFileDictionary?.object(forKey: "generator")
                    guard let finalGenerator: String = resourceFileDictionary?.object(forKey: "generator") as? String else {
                        return
                    }
                    
                } else {
                    print("Invalid SHSH, no generator found")
                    let alert = NSAlert.init()
                    alert.messageText = "Error"
                    alert.informativeText = "No generator found. Please pick an SHSH file with a generator."
                    alert.addButton(withTitle: "Go Back")
                    alert.runModal()
                    return
                }
            } catch {
                print("Couldn't find shsh")
                let alert = NSAlert.init()
                alert.messageText = "Error"
                alert.informativeText = "No SHSH selected. Please locate your SHSH file and try again"
                alert.addButton(withTitle: "Go Back")
                alert.runModal()
               
            }
        } else {
            print("SHSH path not set properly. Please try again.")
            let alert = NSAlert.init()
            alert.messageText = "Error"
            alert.informativeText = "Somehow you managed to select something that isn't a .shsh or .shsh2 file even though you shouldn't be able to. Please tell me how tf you did that"
            alert.addButton(withTitle: "Go Back")
            alert.runModal()
        }
        let resourceFileDictionary = NSDictionary(contentsOfFile: shshLocation)
        let s = resourceFileDictionary?.object(forKey: "generator")
        guard let finalGenerator: String = resourceFileDictionary?.object(forKey: "generator") as? String else {
            return
        }
       
        irecoveryStuff(argu: "-c \"setenv com.apple.System.boot-nonce \(finalGenerator)\"")
        alert.messageText = "iRecovery stuff pt2"
        alert.informativeText = "Set generator"
        alert.runModal()
        sleep(5)
        irecoveryStuff(argu: "-c saveenv")
        
        
        alert.messageText = "iRecovery stuff pt2"
        alert.informativeText = "Saved environment"
        alert.runModal()
        sleep(3)
        irecoveryStuff(argu: "-c setenv auto-boot false")
        
        alert.messageText = "iRecovery stuff pt2"
        alert.informativeText = "Set Auto-boot to false"
        alert.runModal()
        sleep(3)
        irecoveryStuff(argu: "-c saveenv")
       
        
        alert.messageText = "iRecovery stuff pt2"
        alert.informativeText = "Saved environment"
        alert.runModal()
        sleep(3)
        irecoveryStuff(argu: "-c reset")

        
        alert.messageText = "iRecovery stuff pt2"
        alert.informativeText = "All done! Device will now reboot into recovery mode with the correct APNonce"
        alert.runModal()
    }
    
    
    
    @IBAction func enterPWNDFUMode(_ sender: NSButton) {
        
        
        print("Entering PWNDFU mode")
        let path = "/bin/sh"
        let arguments = ["/Applications/CheckNonceGUI.app/Contents/Resources/pwn.sh"]
        sender.isEnabled = false
        let task = Process.launchedProcess(launchPath: path, arguments: arguments)
        task.waitUntilExit()
        sender.isEnabled = true
        let alert = NSAlert.init()
        alert.messageText = "ipwndfu"
        alert.informativeText = "Device is now in PWNDFU mode."
        alert.addButton(withTitle: "OK")
        alert.runModal()
        print("Entered PWNDFU mode")
    }
    
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }



}
