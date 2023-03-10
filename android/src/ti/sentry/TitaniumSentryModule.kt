/**
 * This file was auto-generated by the Titanium Module SDK helper for Android
 * TiDev Titanium Mobile
 * Copyright TiDev, Inc. 04/07/2022-Present
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 *
 */

package ti.sentry

import io.sentry.Sentry
import io.sentry.protocol.User
import org.appcelerator.kroll.KrollDict
import org.appcelerator.kroll.KrollModule
import org.appcelerator.kroll.annotations.Kroll

@Kroll.module(name = "TitaniumSentry", id = "ti.sentry")
class TitaniumSentryModule: KrollModule() {

	// Methods

	@Kroll.method
	fun captureMessage(message: String) {
		Sentry.captureMessage(message)
	}

	@Kroll.method
	@Kroll.setProperty
	fun setContext(context: KrollDict) {
		val key = context["key"] as String
		val value = context["value"] as Any

		Sentry.configureScope {
			it.setContexts(key, value)
		}
	}

	@Kroll.method
	@Kroll.setProperty
	fun setUser(params: KrollDict) {
		val user = User()
		user.id = params.getString("userId")
		user.username = params.getString("username")
		user.ipAddress = params.getString("ipAddress")
		user.email = params.getString("email")
		user.segment = params.getString("segment")
		user.data = params["data"] as? Map<String, String>

		Sentry.setUser(user)
	}
}
