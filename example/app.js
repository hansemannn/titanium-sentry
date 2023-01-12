import Sentry from 'ti.sentry';

/**
 * Android: Make sure to have (at least) the following config in your tiapp.xml:
 	<android xmlns:android="http://schemas.android.com/apk/res/android">
		<manifest xmlns:android="http://schemas.android.com/apk/res/android" android:versionCode="1">
			<application>
				<meta-data android:name="io.sentry.dsn" android:value="https://examplePublicKey@o0.ingest.sentry.io/0" />
				<!-- Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
				We recommend adjusting this value in production. -->
				<meta-data android:name="io.sentry.traces.sample-rate" android:value="1.0" />
				<!-- Enable user interaction tracing to capture transactions for various UI events (such as clicks or scrolls). -->
				<meta-data android:name="io.sentry.traces.user-interaction.enable" android:value="true" />
			</application>
		</manifest>
	</android>
 */

// Android starts automatically, so this is iOS only:
Sentry.start && Sentry.start({
    dsn: 'https://examplePublicKey@o0.ingest.sentry.io/0', // required (!)
    debug: true,
    enableAppHangTracking: true,
    attachScreenshot: true,
    attachStacktrace: true,
    attachViewHierarchy: true,
    enableAutoPerformanceTracking: true
});

// Test a log message
Sentry.captureMessage('READY! Platform = ' + Ti.Platform.osname);

const win = Ti.UI.createWindow();
const btn = Ti.UI.createButton({ title: 'Trigger crash' });

btn.addEventListener('click', () => {
	// Test crash reporting (it takes some time to show in the dashboard)
    crash(Ti.Test());
});

win.add(btn);
win.open();