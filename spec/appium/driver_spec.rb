

describe DATPages::Driver do

  it 'should respond to #self.instance' do
    expect(DATPages::Driver.respond_to? :instance).to be true
  end

  before :all do
    DATPages.configure do |config|
      config.os = 'android'
      config.driver_for = :appium
      config.desired_caps.fullReset = true
      config.desired_caps.platformName = 'android'
      config.desired_caps.deviceName = 'emulator-5554'
      config.desired_caps.avd = 'API22'
      config.desired_caps.app = 'spec/appium/apk/trucker-debug.apk'
      config.desired_caps.appActivity = 'com.dat.trucker.views.activities.LoginActivity'
      config.appium_port = '4723'
      config.emulator_port = 5544
      config.bootstrap_port = 6000
    end
    @server = DATPages::Appium::AppiumServer.new
    @server.start
    @driver = DATPages::Driver.instance
  end

  before :each do
    DATPages::Driver.reset
  end

  after :all do
    @driver.stop
    @server.stop
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

  it 'should respond to set_location' do
    expect(@driver.respond_to? :set_location).to be true
  end

  it 'should raise an error if :lat and :long are not passed in as argument keys' do
    result = false
    begin
      @driver.set_location({})
    rescue
      result = true
    end
    expect(result).to be true
  end

  specify '#parse_element_args should take 1 argument' do
    expect(@driver.send(:parse_element_args, ['locator'])).to be_truthy
  end

  specify '#parse_element_args should take 2 argument' do
    expect(@driver.send(:parse_element_args, ['locator', :id])).to be_truthy
  end

  specify '#parse_element_args should not take 3 arguments' do
    result = (
    begin
      @driver.send(:parse_element_args, ['locator', :id, 'bad param'])
      false
    rescue
      true
    end
    )
    expect(result).to be true
  end




end