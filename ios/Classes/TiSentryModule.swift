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

  public let testProperty: String = "Hello World"
  
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
    
    NSLog("[WARN] INIT: \(params)")

    SentrySDK.start { options in
      options.dsn = TiUtils.stringValue("dsn", properties: params)
      options.debug = TiUtils.boolValue("debugEnabled", properties: params, def: false)
      options.enableAppHangTracking = TiUtils.boolValue("enableAppHangTracking", properties: params, def: false)
      options.attachScreenshot = TiUtils.boolValue("attachScreenshot", properties: params, def: false)
      options.attachStacktrace = TiUtils.boolValue("attachStacktrace", properties: params, def: false)
      options.attachViewHierarchy = TiUtils.boolValue("attachViewHierarchy", properties: params, def: false)
      options.enableAutoPerformanceTracking = TiUtils.boolValue("enableAutoPerformanceTracking", properties: params, def: true)
      
      NSLog("[WARN] DSN: \(options.dsn ?? "n/a")")
    }
  }
  
  @objc(captureMessage:)
  func captureMessage(params: [Any]) {
    guard let message = params.first as? String else { fatalError("Missing required first parameter" ) }

      SentrySDK.capture(message: message)
  }
}
