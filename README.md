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
- [x] Send battery info using Shortcuts
  - Automatable using Shortcuts Automations!
- [x] macOS-specific UI elements (CommandMenu and MenuBarExtra)
- [ ] Allow user to change embed color (right now is #e872e2 for >20% and #ff0000 for ≤20% battery)
- [ ] Preview how the embed will show (lots of work and im lazy)
- [ ] Support services other than Discord (config infra is there but need to create constructors for whatever format other services expect)
- [ ] probably more stuff idk

## Compatibility and Dependencies
- macOS 13.0 or later
  - Native (AppKit) macOS build
- iOS/iPadOS/tvOS/macCatalyst 15.0 or later
  - iOS/tvOS build or Mac Catalyst build
- watchOS 8 or later
- visionOS 1 or later

Support for the Shortcuts app requires iOS/iPadOS/watchOS 16 or later.

<sub>(macCatalyst 15.0 = macOS Monterey 12.0)</sub>

## Building
Open in Xcode, change PROJECT_IDENTIFIER at the bottom of project build settings, set codesign identity, then build.

Documentation is provided as DocC for most functions, or code comments