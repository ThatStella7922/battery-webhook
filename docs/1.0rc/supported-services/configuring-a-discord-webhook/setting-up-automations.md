# Setting up automations

Battery Webhook supports the Shortcuts app, where it provides the **Send Battery Info** action. This action depends on the app's configure being valid, so ensure you've configured it properly before using the action.

<figure><img src="../../../.gitbook/assets/image (13).png" alt="" width="375"><figcaption></figcaption></figure>

You can report to the webhook that you've plugged in, unplugged or fully charged your device.

### iOS and iPadOS

You can combine this action with Shortcuts Automations to have a setup just like the example shown on the [Introduction](../../introduction/#why-should-i-use-this) page:

<figure><img src="../../../.gitbook/assets/image (15).png" alt="" width="188"><figcaption></figcaption></figure>

Let's get started setting it up. Open the **Shortcuts** app, then switch to the **Automations tab**. Tap **New Automation**, then open the **Charger** personal automation. Ensure it **Runs Immediately**, then tap **Next**. Tap **New Blank Automation** and add Battery Webhook's **Send Battery Info** action. Make sure to enable **Report that the device was plugged in** and that **Show When Run** is off.

For the next one, create another **Charger** personal automation, but ensure that **When** is _only_ set to **Is Disconnected**, and that **Run Immediately** is checked. Tap **Next**, add the **Send Battery Info** action and enable **Report that the device was unplugged** as well as disabling **Show When Run**.

Last one. Create a **Battery Level** personal automation and change it to trigger at exactly **100%**. Again, ensure it **Runs Immediately.** Tap **Next** and add the **Send Battery Info** action, then enable **Report that the device reached full charge** as well as disabling **Show When Run**.

Once you've set the automations up, they should appear like below:

<figure><img src="../../../.gitbook/assets/image (17).png" alt="" width="375"><figcaption></figcaption></figure>

At this point, plug in/unplug/let your device hit 100% and Battery Webhook will automatically send the batteyr info according to your configuration. If there's a configuration error, the Shortcuts app will let you know so you that can fix it in Battery Webhook
