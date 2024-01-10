# Setting up automations

### macOS

Battery Webhook uses IOPowerManagement events and IOKit queries to directly talk to your Mac's hardware, which provides _highly_ power-efficient and fast automations.

To take advantage of automations on macOS, just open the app and toggle the desired events in the **Automations** section.

The automations will not be triggered if your configuration is invalid, so just ensure that it's valid before enabling them.

<figure><img src="../../../.gitbook/assets/image (1).png" alt=""><figcaption></figcaption></figure>

### iOS and iPadOS

Battery Webhook uses the Shortcuts Automations feature built into the Shortcuts app. As such, we add the **Send Battery Info** action to Shortcuts. This action depends on the app's configuration being valid, so ensure you've configured it properly before using the action.

<figure><img src="../../../.gitbook/assets/image (15).png" alt="" width="375"><figcaption></figcaption></figure>

With the action, you can report to the webhook that you've plugged in, unplugged or fully charged your device.

When set up with Shortcuts Automations, you can report battery info as seen on the [Introduction](../../introduction/#why-should-i-use-this) page:

<figure><img src="../../../.gitbook/assets/image (17).png" alt="" width="188"><figcaption></figcaption></figure>

Let's get started setting it up. Open the **Shortcuts** app, then switch to the **Automations tab**. Tap **New Automation**, then open the **Charger** personal automation. Ensure it **Runs Immediately**, then tap **Next**. Tap **New Blank Automation** and add Battery Webhook's **Send Battery Info** action. Make sure to enable **Report that the device was plugged in** and that **Show When Run** is off.

For the next one, create another **Charger** personal automation, but ensure that **When** is _only_ set to **Is Disconnected**, and that **Run Immediately** is checked. Tap **Next**, add the **Send Battery Info** action and enable **Report that the device was unplugged** as well as disabling **Show When Run**.

Last one. Create a **Battery Level** personal automation and change it to trigger at exactly **100%**. Again, ensure it **Runs Immediately.** Tap **Next** and add the **Send Battery Info** action, then enable **Report that the device reached full charge** as well as disabling **Show When Run**.

Once you've set the automations up, they should appear like below:

<figure><img src="../../../.gitbook/assets/image (19).png" alt="" width="375"><figcaption></figcaption></figure>

At this point, plug in/unplug/let your device hit 100% and Battery Webhook will automatically send the batteyr info according to your configuration. If there's a configuration error, the Shortcuts app will let you know so you that can fix it in Battery Webhook
