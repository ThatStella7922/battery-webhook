# Setting up automations

### macOS

Battery Webhook on macOS uses IOPowerManagement events and IOKit queries to directly talk to your Mac's hardware, which provides _highly_ power-efficient and fast automations.

To take advantage of automations on macOS, just open the app and toggle the desired events in the **Automations** section.

The automations will not be triggered if your configuration is invalid, so just ensure that it's valid before enabling them.

<figure><img src="../../../.gitbook/assets/image (26).png" alt=""><figcaption></figcaption></figure>

Battery Webhook on macOS also supports launching itself when you log in, showing a Menu Bar Extra for quick and easy control, and hiding the main window + dock icon for a cleaner experience.

<figure><img src="../../../.gitbook/assets/image (27).png" alt=""><figcaption></figcaption></figure>

Just head into **Settings**, scroll down and choose the options you'd like.

{% hint style="success" %}
Hiding the main window and dock icon + automatically launching Battery Webhook when logging in is **highly** recommended if you use automations.
{% endhint %}

### iOS, iPadOS and visionOS

On these platforms, Battery Webhook uses the Shortcuts Automations feature built into the Shortcuts app. As such, we add the **Send Battery Info** action to Shortcuts. This action requires a valid configuration in the app.

<figure><img src="../../../.gitbook/assets/image (15).png" alt="" width="375"><figcaption></figcaption></figure>

With the action, you can report to the webhook that you've plugged in, unplugged or fully charged your device.

When set up with Shortcuts Automations, you can report battery info as seen on the [Introduction](../../introduction/#why-should-i-use-this) page:

<figure><img src="../../../.gitbook/assets/image (17).png" alt="" width="188"><figcaption></figcaption></figure>

***

Let's get started setting it up. Open the **Shortcuts** app, then switch to the **Automations tab**.

Tap **New Automation**, then select the **Charger** personal automation. Make sure that **When** is set to "Is Connected", **Run Immediately** is selected and **Notify When Run** is turned off, then tap **Next**.\
![](<../../../.gitbook/assets/image (24).png>)

Tap **New Blank Automation** and add Battery Webhook's **Send Battery Info** action. Make sure to enable **Report that the device was plugged in** and that **Show When Run** is off, then press **Done** to create it.\
![](<../../../.gitbook/assets/image (25).png>)

For the next one, create another **Charger** personal automation. Ensure that **When** is _only_ set to "Is Disconnected", **Run Immediately** is checked and **Notify When Run** is turned off. Tap **Next**, add the **Send Battery Info** action, enable **Report that the device was unplugged** and disable **Show When Run**.

Last one. Create a **Battery Level** personal automation and change it to trigger at exactly **100%**. Again, ensure that **Runs Immediately** is checked and **Notify When Run** is turned off. Tap **Next** and add the **Send Battery Info** action, enable **Report that the device reached full charge** and disable **Show When Run**.

{% hint style="warning" %}
If you forget to disable **Notify When Run** or **Show When Run** when setting up any of the above automations, you may see notifications on your device when plugging in, unplugging or fully charging your device. Disabling these means that no notifications will be shown.
{% endhint %}

Once you've set the automations up, they should appear like below:

<figure><img src="../../../.gitbook/assets/image (19).png" alt="" width="375"><figcaption></figcaption></figure>

At this point, plug in/unplug/let your device hit 100% and Battery Webhook will automatically send the batteyr info according to your configuration. If there's a configuration error, the Shortcuts app will let you know so you that can fix it in Battery Webhook.
