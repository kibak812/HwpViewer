import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  private var pendingFileUrl: URL?
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Set up method channel for file handling
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(
      name: "com.hwpviewer/file_handler",
      binaryMessenger: controller.binaryMessenger
    )
    
    channel.setMethodCallHandler { [weak self] (call, result) in
      if call.method == "getPendingFile" {
        if let url = self?.pendingFileUrl {
          result(url.path)
          self?.pendingFileUrl = nil
        } else {
          result(nil)
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    
    // Check if app was launched with a file URL
    if let url = launchOptions?[.url] as? URL {
      pendingFileUrl = url
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // Handle file opening when app is already running
  override func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    // Notify Flutter about the new file
    if let controller = window?.rootViewController as? FlutterViewController {
      let channel = FlutterMethodChannel(
        name: "com.hwpviewer/file_handler",
        binaryMessenger: controller.binaryMessenger
      )
      channel.invokeMethod("fileOpened", arguments: url.path)
    }
    return true
  }
  
  // Handle Universal Links / Document Provider
  override func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
  ) -> Bool {
    if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
       let url = userActivity.webpageURL {
      if let controller = window?.rootViewController as? FlutterViewController {
        let channel = FlutterMethodChannel(
          name: "com.hwpviewer/file_handler",
          binaryMessenger: controller.binaryMessenger
        )
        channel.invokeMethod("fileOpened", arguments: url.path)
      }
    }
    return true
  }
}
