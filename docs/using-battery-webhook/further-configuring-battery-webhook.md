---
description: A detailed explanation for all of Battery Webhook's settings
---

# Further configuring Battery Webhook

### Webhook

**Webhook Service Type** allows you to change which type of webhook you'd like to send battery info to. To see what services are supported, see [Supported Services](supported-services/).

### Identity

**Display Name** gives you a way to identify yourself on the webhook, in the case of multiple people using it. You can use any name you'd like; it doesn't need to be a real name or username.

**Pronoun** is where you provide a singular pronoun for yourself, and Battery Webhook uses it for automations. For example, if you provide **her** as your pronoun, Battery Webhook will say "\[name] plugged in **her** iPhone".

**Device Name** is where you can customize the name of your device. Battery Webhook gets the device name automatically, but you can still customize it if you don't want to send your device's actual name.

**Show specified avatar image** controls whether Battery Webhook will send the avatar image to the webhook. If disabled, Battery Webhook will substitute a generic avatar image (usually provided by the service you are sending to) instead of the one you have provided.

**Show specified pronoun** controls whether Battery Webhook will send your set pronoun to the webhook. This effect of this option is only seen in automations.

### Privacy

**Send Device Name** and **Send Device Model** will control whether Battery Webhook will send your device's name/model to the webhook. These can be disabled if you would like greater privacy.

### Mac Settings

{% hint style="info" %}
Only available when running Battery Webhook on a Mac
{% endhint %}

**Automatically launch Battery Webhook when logging in** will register the app as a login item withh macOS, so it'll be opened automatically when you log in.\
Enabling this is recommended if you use automations so the app is always running and ready to send battery info.

**Show Menu Bar Extra** will put a Battery Webhook icon in the menu bar so you can control the app from a more minimal UI, right from the menu bar!

**Hide main window and the dock icon** will hide the app's main window and stop it from appearing in the Dock. This is the most minimal Battery Webhook experience, but you'll still be able to control the app from the Menu Bar Extra.\
Combining this option with launching on login is highly recommended.

### Settings Utilities

**Reset All Settings** will reset all of Battery Webhook's settings to their defaults. For best results, you should quit Battery Webhook and reopen it after clicking this button.
