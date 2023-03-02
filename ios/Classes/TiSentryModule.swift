//
//  TiSentryModule.swift
//  titanium-sentry
//
//  Created by Your Name
//  Copyright (c) 2023 Your Company. All rights reserved.
//

import UIKit
import TitaniumKit
import Sentry

@objc(TiSentryModule)
class TiSentryModule: TiModule {

  @objc public static let LEVEL_DEBUG = SentryLevel.debug.rawValue

  @objc public static let LEVEL_INFO = SentryLevel.info.rawValue

  @objc public static let LEVEL_WARN = SentryLevel.warning.rawValue

  @objc public static let LEVEL_ERROR = SentryLevel.error.rawValue

  @objc public static let LEVEL_FATAL = SentryLevel.fatal.rawValue

  func moduleGUID() -> String {
    return "3ee7b011-e64d-49fd-9832-1bbf19bb824c"
  }
  
  override func moduleId() -> String! {
    return "ti.sentry"
  }

  @objc(start:)
  func start(params: [Any]) {
    guard let params = params.first as? [String: Any] else {
      SentrySDK.start()
      return
    }
    
    SentrySDK.start { options in
      options.dsn = TiUtils.stringValue("dsn", properties: params)
      options.debug = TiUtils.boolValue("debugEnabled", properties: params, def: false)
      options.enableAppHangTracking = TiUtils.boolValue("enableAppHangTracking", properties: params, def: false)
      options.attachScreenshot = TiUtils.boolValue("attachScreenshot", properties: params, def: false)
      options.attachStacktrace = TiUtils.boolValue("attachStacktrace", properties: params, def: false)
      options.attachViewHierarchy = TiUtils.boolValue("attachViewHierarchy", properties: params, def: false)
      options.enableAutoPerformanceTracking = TiUtils.boolValue("enableAutoPerformanceTracking", properties: params, def: true)
    }
  }
  
  @objc(captureMessage:)
  func captureMessage(params: [Any]) {
    guard let message = params.first as? String else { fatalError("Missing required first parameter" ) }

      SentrySDK.capture(message: message)
  }
  
  @objc(setContext:)
  func setContext(params: [Any]) {
    guard let key = params.first as? String,
          let value = params[1] as? [String: Any] else { fatalError("Missing context" ) }

    SentrySDK.configureScope { scope in
      scope.setContext(value: value, key: key)
    }
  }
  
  @objc(setUser:)
  func setUser(args: Any) {
    guard let params = args as? [String: Any] else {
      fatalError("Missing parameters")
    }
    
    let user = User()
    user.email = params["email"] as? String
    user.userId = params["userId"] as? String
    user.username = params["username"] as? String
    user.ipAddress = params["ipAddress"] as? String
    user.segment = params["segment"] as? String
    user.data = params["data"] as? [String: Any]

    SentrySDK.setUser(user)
  }
  
  @objc(addBreadcrumb:)
  func addBreadcrumb(args: Any) {
    guard let params = args as? [String: Any] else {
      fatalError("Missing parameters")
    }
    
    let crumb = Breadcrumb()
    crumb.level = SentryLevel(rawValue: UInt(TiUtils.intValue("level", properties: params)))!
    crumb.category = params["category"] as! String
    crumb.message = params["message"] as? String

    SentrySDK.addBreadcrumb(crumb: crumb)
  }
}
