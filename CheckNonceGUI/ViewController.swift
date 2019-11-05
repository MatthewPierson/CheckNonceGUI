//
//  ViewController.swift
//  CheckNonceGUI
//
//  Created by matty on 1/11/19.
//  Copyright © 2019 matty. All rights reserved.
//

import Cocoa
import SwiftShell

class ViewController: NSViewController {

    var path = ("null")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.window?.level = .floating
        let alert = NSAlert.init()
        alert.messageText = "Information"
        alert.informativeText = "Press OK to continue to the app\n\nAPP MUST BE INSTALLED TO '/Applications' !!! IF IT IS NOT INSTALLED THERE, CLOSE THE APP AND MOVE IT THERE\n\nPlease try using your brain before you spam me on twitter/github/discord asking stupid questions."
        alert.addButton(withTitle: "OK")
        alert.runModal()
        
    }
    
    @IBOutlet weak var filename_field: NSTextField!
    
    @IBOutlet weak var apnonce_field: NSTextField!
    
    @IBAction func helpButton(_ sender: NSButton) {
        let alert = NSAlert.init()
        alert.messageText = "Version 0.1.1"
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
            let result = dialog.url
            
            if (result != nil) {
                let path = result!.path
                filename_field.stringValue = path
                print("SHSH location is:", path)
                var finalgenerator = getGenerator(shshPath: path)
                apnonce_field.stringValue = finalgenerator
            }
            
        } else {
            print("Why'd you cancel me =(")
            let path = "Why'd you cancel me =("
            filename_field.stringValue = path
            apnonce_field.stringValue = ""
            return
        }
        
    }
   
    func irecoveryStuff(argu: String) -> Bool {
        
        let alert = NSAlert.init()
        let test = try? runAndPrint("/Applications/CheckNonceGUI.app/Contents/Resources/irecovery", "\(argu)")
        if test != nil {
            print("Worked")
            alert.messageText = "irecovery"
            alert.informativeText = "Device succeded with \(argu) command."
            alert.runModal()
            print("Entered PWNDFU mode")
            return true
        } else {
            print("Get fucked")
            alert.messageText = "irecovery"
            alert.informativeText = "Something went wrong and irecovery failed on 'irecovery \(argu)' command. Please re-enter DFU mode and try again from the beginning."
            alert.runModal()
            print("Gave error")
            return false
        }
    }

    func getGenerator(shshPath: String) -> String {
        if shshPath != nil {
        do {
                let contents = try String(contentsOfFile: shshPath)
                var noGenerator = contents.contains("generator")
                if noGenerator == true {
                    print("SHSH contains generator, is valid for this tool")
                    let resourceFileDictionary = NSDictionary(contentsOfFile: shshPath)
                    let s = resourceFileDictionary?.object(forKey: "generator")
                    guard let finalGenerator: String = resourceFileDictionary?.object(forKey: "generator") as? String else {
                        return ""
                    }
                    
                } else {
                    print("Invalid SHSH, no generator found")
                    let alert = NSAlert.init()
                    alert.messageText = "Error"
                    alert.informativeText = "No generator found. Please pick an SHSH file with a generator."
                    alert.addButton(withTitle: "Go Back")
                    alert.runModal()
                    filename_field.stringValue = "Please choose a valid SHSH file..."
                    return ""
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
        let resourceFileDictionary = NSDictionary(contentsOfFile: shshPath)
        let s = resourceFileDictionary?.object(forKey: "generator")
        guard let finalGenerator: String = resourceFileDictionary?.object(forKey: "generator") as? String else {
            return "null"
        }
        return finalGenerator
    }

    @IBAction func setGenerator(_ sender: NSButton) {
    
        print("Entering recovery mode")
        let alert = NSAlert.init()
        let test = try? runAndPrint("/bin/sh", "/Applications/CheckNonceGUI.app/Contents/Resources/rec.sh")
        if test != nil {
            print("Worked")
            alert.messageText = "irecovery"
            alert.informativeText = "Device is now in pwndrec mode."
            alert.runModal()
            print("Entered PWNDFU mode")
        } else {
            print("Get fucked")
            alert.messageText = "irecovery"
            alert.informativeText = "Something went wrong and irecovery failed. Please re-enter DFU mode and try again from the beginning."
            alert.runModal()
            print("Gave error")
            return
        }
        print("Getting generator from SHSH ")
        let shshLocation = filename_field.stringValue
        
        var finalgenerator = getGenerator(shshPath: shshLocation)
        if finalgenerator == "null" {
            print("No generator found")
            return
        } else {
            print("Your generator is: \(finalgenerator)")
        }
        apnonce_field.stringValue = finalgenerator
        var irec1 = irecoveryStuff(argu: "-c setenv com.apple.System.boot-nonce \(finalgenerator)")
        if irec1 == true {
            alert.messageText = "iRecovery stuff pt2"
            alert.informativeText = "Set generator"
            alert.runModal()
            sleep(5)
            var irec2 = irecoveryStuff(argu: "-c saveenv")
            if irec2 == true {
                alert.messageText = "iRecovery stuff pt2"
                alert.informativeText = "Saved environment"
                alert.runModal()
                sleep(3)
                var rec3 = irecoveryStuff(argu: "-c setenv auto-boot false")
                if rec3 == true {
                    alert.messageText = "iRecovery stuff pt2"
                    alert.informativeText = "Set Auto-boot to false"
                    alert.runModal()
                    sleep(3)
                    var irec4 = irecoveryStuff(argu: "-c saveenv")
                    if irec4 == true {
                        alert.messageText = "iRecovery stuff pt2"
                        alert.informativeText = "Saved environment"
                        alert.runModal()
                        sleep(3)
                        var irec5 = irecoveryStuff(argu: "-c reset")
                        if irec5 == true {
                            alert.messageText = "iRecovery stuff pt2"
                            alert.informativeText = "All done! Device will now reboot into recovery mode with the correct APNonce"
                            alert.runModal()
                        }
                    else {print("errored on restarting device")}
                    }
                else {print("errored on saving environment the second time")}
                }
            else {print("errored on setting auto-boot to false")}
            }
        else {print("errored on saving envirnoment")}
        }
    else {print("errored on setting generator")}
    }
    
    @IBAction func enterPWNDFUMode(_ sender: NSButton) {
        
        let alert = NSAlert.init()
        alert.messageText = "IMPORTANT"
        alert.informativeText = "Please make sure you are in DFU mode before pressing continue.\n\nipwndfu will loop until it puts the device in PWNDFU mode so just keep trying whenever the device reboots."
        alert.addButton(withTitle: "Continue")
        alert.runModal()
        
        let test = try? runAndPrint("/bin/sh", "/Applications/CheckNonceGUI.app/Contents/Resources/pwn.sh")
        if test != nil {
            print("Worked")
            alert.messageText = "ipwndfu"
            alert.informativeText = "Device is now in PWNDFU mode."
            alert.runModal()
            print("Entered PWNDFU mode")
        } else {
            print("Get fucked")
            alert.messageText = "ipwndfu"
            alert.informativeText = "Something went wrong and ipwndfu failed. Please re-enter DFU mode and try again."
            alert.runModal()
            print("Gave error")
        }
    }
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
