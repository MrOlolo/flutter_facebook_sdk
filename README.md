# Facebook Sdk For Flutter

`facebook_sdk_flutter` allows you to fetch `deep links`, `deferred deep links`
and `log facebook app events`.

## Prerequisites

First of all, if you don't have one already, you must first create an app at Facebook
developers: https://developers.facebook.com/

Get your app id, client token and app name
(referred to as [APP_ID], [APP_NAME], [CLIENT_TOKEN] below)

# For IOS

* If your code does not have CFBundleURLTypes, add the following just before the final </dict>
  element:

```
 <key>CFBundleURLTypes</key>
    <array>
      <dict>
      <key>CFBundleURLSchemes</key>
      <array>
        <string>fb[APP_ID]</string>
      </array>
      </dict>
    </array>
    <key>FacebookAppID</key>
    <string>[APP_ID]</string>
    <key>FacebookClientToken</key>
    <string>[CLIENT_TOKEN]</string>
    <key>FacebookDisplayName</key>
    <string>[APP_NAME]</string>
	<key>FacebookAutoLogAppEventsEnabled</key>
	<true/>
	<key>FacebookAdvertiserIDCollectionEnabled</key>
	<false/>
	<key>CADisableMinimumFrameDurationOnPhone</key>
	<true/>
```

# For Android

* Add the following to your strings.xml file

```

<string name="facebook_app_id">[APP_ID]</string>
<string name="facebook_client_token">[CLIENT_TOKEN]</string>

```

* Add the following `meta-data` to the `application` element in AndroidManifest.xml

```

<application android:label="@string/app_name" ...>
    ...
    <meta-data android:name="com.facebook.sdk.ApplicationId" android:value="@string/facebook_app_id"/><meta-data android:name="com.facebook.sdk.ClientToken" android:value="@string/facebook_client_token"/>
    ...
</application>

```

* Add the following `uses-permission` element after `application` element in AndroidManifest.xml

```

<uses-permission android:name="android.permission.INTERNET"/>

```

* Don't forget to replace [APP_ID], [APP_NAME], [CLIENT_TOKEN] with your data from Facebook

