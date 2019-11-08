# CheckNonceGUI

GUI for my Checkm8 based APNonce Setter. This is a very simple swift app that will place your device into PWNDFU mode using ipwndfu/checkm8, let the user pick a valid previously saved SHSH file and grab the generator from it, place the device into PWNDREC mode and set the generator to that found in the SHSH file. This allows for downgrades/upgrades to unsiged iOS versions for compatible devices, limited to versions with a signed compatible SEP/Baseband for now. 

## Usage
As of version 0.6.5, you can run the app from any location (Thanks @tie1r on twitter!). It no longer needs to be placed in "/Applications" to work! ~~Place the .app into "/Applications" and run it from there. If that's too complicated for you then I don't know what to say~~

## Building the project

1. Clone the repo
2. Open the xcode workspace (CheckNonceGUI.xcworkspace)
3. Add your Apple ID for signing
4. Run
5. Do whatever you want =)

## Running the app

1. Download latest release
2. Run the app

The app has only been tested and confirmed to work on Mojave, it should work fine on Catalina but High Sierra and lower I don't know and can't be bothered testing at this stage.

## Issues

- If the app gives an error about being damaged please run - 

`xattr -cr Path/To/CheckNonceGUI.app` 

And try again. 

- If the app doesn't run at all, try opening a terminal window and running - 

`sudo open Path/To/CheckNonceGUI.app/Contents/MacOS/CheckNonceGUI`

This will allow you to see what is happening when the app is launched and for you to take a screen shot of the output in the terminal window that this command opens to send to me so I can help fix the issue.

## Device Support

iPhone 5s

iPhone 7

iPhone 7 Plus

iPhone X

------------------------------------------
<br/>

iPad Air 1

iPad Mini 2

iPad 6th Gen (2018)

iPad Mini 3

iPad 7th Gen (2019) (Thanks to @RazMashat on twitter for keys =) )

------------------------------------------
<br/>

iPod Touch 7th Gen (2019)
<br/>
<br/>
## SUPPORT COMING FOR:

iPad Pro (10.5 Inch) (Need firmware keys)

iPad Pro (12.9 Inch 2nd Gen) (Need firmware keys)

## Me and my stuff

[My twitter](https://www.twitter.com/mosk_i "My twitter")

[My reddit account](https://www.reddit.com/user/_Matty "My reddit account")

[My github](https://www.github.com/MatthewPierson "My github")


## Credits

Me =)

Kare Morstol (kareman) - [SwiftShell](https://github.com/kareman/SwiftShell "SwiftShell")
