<h1>first try on CoreNFC for iOS 11 beta</h1>

<h3>Requirements</h3>

<ul>
<li>iPhone 7 or iPhone 7 Plus</li>
<li>iOS 11 Beta</li>
<li>Xcode 9 Beta</li>
<li>Apple Developer Account</li>
<li>Getting Started</li>
</ul>

<h3>Tested on:</h3>
iPhone 6 (7.6.2017 Feature not supported)<br>
iPhone 6s (7.6.2017 Feature not supported)<br>
<br>
<div>
The CoreNFC framework requires an App ID with the NFC Tag Read permission set in your Apple Developer Account.
Head over to https://developer.apple.com and create an App ID and Provisioning Profile with the aforementioned permission.
Then select the profile in Xcode or hope that Xcode will select the right profile (didn't work out for me).
You will also have to add NFC entitlement to your .entitlemens file
</div>
