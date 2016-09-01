

describe DATPages::Driver do

  it 'should respond to #self.instance' do
    expect(DATPages::Driver.respond_to? :instance).to be true
  end

  before :all do
    DATPages.configure do |config|
          config.os = 'ios'
          config.desired_caps.autoAcceptAlerts = true
          config.desired_caps.fullReset = true
          config.desired_caps.platformName = 'ios'
          config.desired_caps.deviceName = 'iPhone 6'
          config.desired_caps.platformVersion = '9.3'
          config.desired_caps.app = '/Users/jakesa/Library/Developer/Xcode/DerivedData/mobile-fexownuxytnyvddyyujpnerxqobm/Build/Products/Debug-iphonesimulator/Trucker.app'
        end
    @driver = DATPages::Driver.instance
  end

  after :all do
    @driver.stop
  end

  it 'should respond to #start' do
    expect(@driver.respond_to? :start).to be true
  end

  it 'should respond to #stop' do
    expect(@driver.respond_to? :stop).to be true
  end

  it 'should respond to #open_app' do
    expect(@driver.respond_to? :open_app).to be true
  end

  it 'should respond to #close_app' do
    expect(@driver.respond_to? :close_app).to be true
  end

  it 'should respond to #wait_for' do
    expect(@driver.respond_to? :wait_for).to be true
  end

  it 'should respond to #find_element' do
    expect(@driver.respond_to? :find_element).to be true
  end

  it 'should not start the driver if it is already started' do
    expect(@driver.start).to be false
  end

  it 'should stop the driver if it is already started' do
    expect(@driver.stop).to be true
  end

  it 'should start the driver if it is not started' do
    expect(@driver.start).to be true
  end

  it 'should not open the app if it is already started' do
    expect(@driver.open_app).to be false
  end

  it 'should close the app if it is open' do
    expect(@driver.close_app).to be true
  end

  it 'should open the app if it is closed' do
    expect(@driver.open_app).to be true
  end



end