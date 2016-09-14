
describe DATPages::DriverConnection do


  it 'should raise an error if driver_for is not specified' do
    expect(begin
      DATPages::DriverConnection.initialize_driver
    rescue DATPages::Errors::NoDriverSpecified
      true
    end).to be_truthy
  end

  it 'should raise an error if the driver specified is not supported' do
    DATPages.configure do |config|
      config.driver_for = :appium2
    end
    expect(begin
             DATPages::DriverConnection.initialize_driver
           rescue DATPages::Errors::DriverNotFound
             true
           end).to be_truthy
  end


  it 'should initialize appium' do
    DATPages.configure do |config|
      config.driver_for = :appium
      config.os = 'ios'
      config.desired_caps.autoAcceptAlerts = true
      config.desired_caps.fullReset = true
      config.desired_caps.platformName = 'ios'
      config.desired_caps.deviceName = 'iPhone 6'
      config.desired_caps.platformVersion = '9.3'
      config.desired_caps.app = '/Users/jakesa/Library/Developer/Xcode/DerivedData/mobile-fexownuxytnyvddyyujpnerxqobm/Build/Products/Debug-iphonesimulator/Trucker.app'
    end
    DATPages::DriverConnection.initialize_driver
    DATPages.driver.stop
  end


end