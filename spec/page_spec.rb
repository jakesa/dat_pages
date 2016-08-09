

describe DATPages::Page do

  before(:all) do
    DATPages.reset
    @server = DATPages.server
    @server.start
    DATPages.configure do |config|
      config.os = 'ios'
      config.desired_caps.autoAcceptAlerts = true
      config.desired_caps.fullReset = true
      config.desired_caps.platformName = 'ios'
      config.desired_caps.deviceName = 'iPhone 6'
      config.desired_caps.platformVersion = '9.3'
      config.desired_caps.app = '/Users/jakesa/Library/Developer/Xcode/DerivedData/mobile-fexownuxytnyvddyyujpnerxqobm/Build/Products/Debug-iphonesimulator/Trucker.app'
    end
    DATPages.start_driver
  end

  after(:all) do
    @server.stop
  end

  it 'should respond to #self.element' do
    expect(DATPages::Page.respond_to? :element).to eq true
  end

  it 'should respomd to #self.page' do
    expect(DATPages::Page.respond_to? :page).to eq true
  end

  it 'should respond to #self.section' do
    expect(DATPages::Page.respond_to? :section).to eq true
  end


end