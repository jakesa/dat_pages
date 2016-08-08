
module DATPages
  class Capabilities

    attr_reader :os

    def initialize(os)
      @os = os
      @caps = []
      define_object(os)
      @newCommandTimeout = 999999
    end

    # convert the capabilities into a hash
    # @return [Hash] the object as a hash
    def to_hash
      hash = {}
      @caps.each do |variable_name|
        hash[variable_name.to_sym] = send(variable_name.to_sym) unless send(variable_name.to_sym).nil?
      end
      {:caps => hash }
    end


    private
    # create methods on this object specific to the os that is passed in
    def define_object(os)
      common_caps.each do |cap|
        create_set_get cap
      end

      if os.to_s.downcase == 'ios'
        ios_caps.each do |cap|
          create_set_get cap
        end

      elsif os.to_s.downcase == 'android'
        android_caps.each do |cap|
          create_set_get cap
        end
      end

    end

    # create setters and getters for each of the capabilities
    def create_set_get(name)

      raise "setters and getters have already been created for #{name}" if self.respond_to? name.to_sym
      # store the created method names for later use in converting this to a Hash
      @caps << name.to_sym
      instance_eval("def #{name.to_s}=(value); @#{name.to_s}=(value);end;")
      instance_eval("def #{name.to_s}; @#{name.to_s};end;")
      instance_eval("instance_variables << @#{name.to_s}")
    end


    # capabilities found for both ios and android
    def common_caps

      [:automationName,
       :platformName,
       :platformVersion,
       :deviceName,
       :app,
       :browserName,
       :newCommandTimeout,
       :language,
       :locale,
       :udid,
       :orientation,
       :autoWebview,
       :noReset,
       :fullReset]
    end

    # capabilities specifically for android
    def android_caps
      [:appActivity,
       :appPackage,
       :appWaitActivity,
       :appWaitPackage,
       :deviceReadyTimeout,
       :androidCoverage,
       :enablePerformanceLogging,
       :androidDeviceReadyTimeout,
       :adbPort,
       :androidDeviceSocket,
       :avd,
       :avdLaunchTimeout,
       :avdReadyTimeout,
       :avdArgs,
       :useKeystore,
       :keystorePath,
       :keystorePassword,
       :keyAlias,
       :keyPassword,
       :chromedriverExecutable,
       :autoWebviewTimeout,
       :intentAction,
       :intentCategory,
       :intentFlags,
       :optionalIntentArguments,
       :dontStopAppOnReset,
       :unicodeKeyboard,
       :resetKeyboard,
       :noSign,
       :ignoreUnimportantViews,
       :disableAndroidWatchers,
       :chromeOptions,
       :recreateChromeDriverSessions,
       :nativeWebScreenshot]
    end

    # capabilities specifically for ios
    def ios_caps
      [:calendarFormat,
       :bundleId,
       :launchTimeout,
       :locationServicesEnabled,
       :locationServicesAuthorized,
       :autoAcceptAlerts,
       :autoDismissAlerts,
       :nativeInstrumentsLib,
       :nativeWebTap,
       :safariInitialUrl,
       :safariAllowPopups,
       :safariIgnoreFraudWarning,
       :safariOpenLinksInBackground,
       :keepKeyChains,
       :localizableStringsDir,
       :processArguments,
       :interKeyDelay,
       :showIOSLog,
       :sendKeyStrategy,
       :screenshotWaitTimeout,
       :waitForAppScript,
       :webviewConnectRetries,
       :appName]
    end

  end



end
