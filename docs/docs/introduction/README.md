---
description: >-
  Battery Webhook is an app that lets you send your battery info to popular
  services using webhooks.
---

# Introduction

To use it, you'll need to configure Battery Webhook with a webhook to push to, as well as filling out some basic info on how you would like to appear to the webhook (such as a display name).

If you already have a webhook you want to provide to Battery Webhook and know it is fully supported, see [Quick Start](quick-start.md). Otherwise, continue reading.

### What is a webhook?

A **webhook** is a method of communication to a web application. It allows an application to send real-time data to another application whenever a specific event occurs.

In the case of Battery Webhook, the real-time data is your device's battery information, and the event is either manual or automated. The services we support sending to are documented in another page, [Supported Services](../supported-services/).

### Why should I use this?

Battery Webhook can send something like the following whenever you open the app and manually tap Send Battery Info:

<div data-full-width="false">

<figure><img src="../../.gitbook/assets/image (11).png" alt="" width="563"><figcaption><p>Battery Webhook's output to a Discord webhook when manually triggered</p></figcaption></figure>

</div>

That's fine and all, but not very useful unless you feel like opening the app every time you want to report battery info. **However**, Battery Webhook supports power-efficient automations! So you can have it send battery info whenever you plug in, unplug or fully charge your device, as seen below:

<figure><img src="../../.gitbook/assets/image (13).png" alt="" width="563"><figcaption><p>Battery Webhook's output to a Discord webhook when triggered by plugging in, fully charging, then unplugging the device</p></figcaption></figure>

Automations allow Battery Webhook to inform you about power state changes for devices that you may want to be informed about, such as:

* A MacBook that you need on and charged at all times and want to know if it loses power
* A Mac with a UPS attached and you want to know if it ever loses power (useful for knowing if there's a power outage or similar)
* An old iPhone or iPad being used as an indoor camera and you must know if it gets unplugged
* How long your phone took to charge overnight
* Friend's devices, just for fun

### What about my privacy?

Battery Webhook collects the following information automatically:&#x20;

* Battery level (example: 15%)
* Device model (example: iPhone 15 Pro Max)
* Device name (example: iPhone - but can be customized)
* OS version (example: 17.2)
* Date and time

It also has you provide the following information:

* Display Name (required, doesn't need to be a real name or username)
* Pronoun (optional, only used for automations)

You can opt out of sending some of the collected into to webhooks, which is covered in [Further configuring Battery Webhook](../supported-services/discord/further-configuring-battery-webhook.md). For most users, however, this isn't needed.

To get started with using Battery Webhook, head over to the [Compatibility](../compatibility.md) page to learn what devices, features and operating systems are supported by Battery Webhook.
