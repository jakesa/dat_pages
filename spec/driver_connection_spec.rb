
describe DATPages::DriverConnection do


  it 'should initialize appium' do
    DATPages.reset
    DATPages.configure do |config|
      config.driver_for = :appium
      config.os = 'android'
      config.desired_caps.fullReset = true
      config.desired_caps.platformName = 'android'
      config.desired_caps.deviceName = 'android_6'
      config.desired_caps.app = '/Users/jakesa/Downloads/fm-beta.apk'
    end
    DATPages::DriverConnection.initialize_driver
    DATPages.driver.start
    result = DATPages.driver.stop
    expect(result).to be true
  end



  it 'should raise an error if driver_for is not specified' do
    expect(begin
      DATPages::DriverConnection.initialize_driver
    rescue DATPages::Errors::NoDriverSpecified
      true
    end).to be_truthy
  end

  it 'should raise an error if the driver specified is not supported' do
    DATPages.configure do |config|
      config.driver_for = :appium
    end
    expect(begin
             DATPages::DriverConnection.initialize_driver
           rescue DATPages::Errors::DriverNotFound
             true
           end).to be_truthy
    DATPages.reset
  end


end