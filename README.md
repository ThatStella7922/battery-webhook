# Battery Webhook
Send your battery info to popular services using webhooks!

## Usage
Install and run, then configure in the Settings page:

<img src="img/app.png" alt="alt text" title="image Title" width="250"/>
<br><br>

Once that's done, you can manually send the battery info to your configured webhook:

<img src="img/output.png" alt="alt text" title="image Title" width="350"/>

## wyd
- [x] UI (SwiftUI ig)
- [x] Device info functions
- [x] Work around iOS 16+ not giving the user-set device name by letting the user set a device name in Battery Webhook
- [x] Date saving, formatting, comparison, etc
- [x] Building Discord embed with JSON 
- [x] HTTP interaction with Discord webhook
- [x] Manual sending of battery info
- [ ] Allow user to change embed color (right now is #e872e2 for >20% and #ff0000 for ≤20% battery)
- [ ] Preview how the embed will show (lots of work and im lazy)
- [ ] Support services other than Discord (config infra is there but need to create constructors for whatever format other services expect)
- [ ] Automated sending of battery info (Siri Shortcuts support for use with power automations? Making the app always run in the background to detect power events?)
- [ ] probably more stuff idk

## Compatibility and Dependencies
iOS/tvOS/macCatalyst 15.0 or later

<sub>(macCatalyst 15.0 = macOS Monterey 12.0) </sub>

## Building
Open in Xcode, set codesign identity, then build.

Documentation is provided as DocC for most functions, or code comments