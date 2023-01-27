# Sentry for Titanium SDK

<img src="./.github/sentry-logo.png" height="80" />

Use the native Sentry SDKs (iOS & Android) in the Titanium SDK.

## Sponsor

<img src="./.github/sponsor-logo.jpg" height="60" />

This module was sponsored by [Korelogic](https://www.korelogic.co.uk). Go check them out today!

## Requirements

- [x] A valid Sentry API key (create a new project [here](https://sentry.io/organizations/lambus/projects/new/))
- [x] Titanium SDK 11.0.0+

## Setup

### iOS

1. Import the module at the earliest possible place (e.g. app.js for classic projects or alloy.js for Alloy projects):
```js
import Sentry from 'ti.sentry';
```
2. Start the crash monitoring with additional options (or no options for the default behavior):
```js
Sentry.start({
  dsn: 'https://examplePublicKey@o0.ingest.sentry.io/0', // required (!)
  debugEnabled: true, // default: false
  enableAppHangTracking: true, // default: false
  attachScreenshot: true, // default: false
  attachStacktrace: true, // default: false
  attachViewHierarchy: true, // default: false
  enableAutoPerformanceTracking: true, // default: true
});
```
You can find all available options [here](https://docs.sentry.io/platforms/apple/guides/ios/configuration/options/).
If you need additional options, feel free to file an issue on Github and I'll try to look into it. Alternatively,
can can always open a pull request (remember to bump the module version in the `manifest`).

### Android

The SDK is initialized automatically after adding the following key in the `<application />` tag (in your manifest inside the tiapp.xml):
```xml
<meta-data android:name="io.sentry.dsn" android:value="https://examplePublicKey@o0.ingest.sentry.io/0" />
```
All additional options (like on iOS) are configured the same way, e.g ANR tracking.:
```xml
<meta-data android:name="io.sentry.anr.enable" android:value="false" />
```
You can find all available options [here](https://docs.sentry.io/platforms/android/configuration/options/).

## Additional APIs

### Methods

- `setContext('key', { value1: 'hello', value2: 'world' })` -> iOS only
- `setUser({ email, userId, username, ipAddress, segment, data })` -> iOS only
- `addBreadcrumb({ level: Sentry.LEVEL_INFO, category: 'my_category', message: 'Hello world' })` -> iOS only

## Author

Hans Knöchel

## License

MIT
