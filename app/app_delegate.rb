class AppDelegate
  # iOS entry point
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    return true if RUBYMOTION_ENV == 'test'

    true
  end

  # OS X entry point
  def applicationDidFinishLaunching(notification)
  end
end
