# Defaults Used

## Settings

### Global
- UsrName
  - String, contains the user set display name
- UsrPronoun
  - String, contains the user set pronoun
- UsrDeviceName
  - String, contains the user set device name (for ios 16 not allowing this)
- ShowPfp
  - Bool, stores the user's preference on showing their pfp
- ShowPronoun
  - Bool, stores the user's preference on showing their pronoun
- SendDeviceName
  - Bool, stores the user's preference on sending their device name
- SendDeviceModel 
  - Bool, stores the user's preference on sending their device model
- SelectedServiceType
  - String, stores the user's preference on which service (discord, telegram, etc) they want to use. Must be selected from a predefined list. See serviceTypes array in WebhookSettingsView.swift

### Automations
- MacSendOnPluggedIn
  - Bool, stores whether the user has chosen to send battery info when plugging in their Mac (false by default)
- MacSendOnUnplugged
  - Bool, stores whether the user has chosen to send battery info when unolugging their Mac (false by default)
- MacSendOnHitFullCharge
  - Bool, stores whether the user has chosen to send battery info when their Mac hits 100% charge (false by default as not yet implemented)

### Service Specific Settings
The way these are constructed is as follows:
```swift
selectedServiceType + "WebhookUrl"
selectedServiceType + "WebhookUserPfpUrl"
```
#### Discord
- DiscordWebhookUrl
  - String, contains the Discord Webhook URL
- DiscordUserPfpUrl
  - String, contains the URL of the user's avatar image
  
#### Discord2
- Discord2WebhookUrl
  - String, contains the Discord Webhook URL
- Discord2UserPfpUrl
  - String, contains the URL of the user's avatar image

## Internal Use
- SavedDate
  - Date, stores a date to be used for other stuff
- AutomationSavedDate
  - Date, stores a date for use with automation actions (comparisons and etc)
- showMenuBarExtra
  - Bool, stores whether the user has chosen to show or hide the menu bar extra (true by default)
- hideMainWindow
  - Bool, stores whether the user has chosen to hide or show the main window and dock icon (false by default)
- shouldDisableMenuItem
  - Bool, stores whether the command menu item/menu bar extra can be used to send battery info
- IsFirstLaunch
  - Bool, set to True after the first time the app is launched.
  - Gets reset to false if UserDefaults are cleared

