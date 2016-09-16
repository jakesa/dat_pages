

describe DATPages::WebDriver::PageObjects::Page do

  # before(:all) do
  #   DATPages.reset
  #   @server = DATPages.server
  #   @server.start
  #   DATPages.configure do |config|
  #     config.os = 'ios'
  #     config.desired_caps.autoAcceptAlerts = true
  #     config.desired_caps.fullReset = true
  #     config.desired_caps.platformName = 'ios'
  #     config.desired_caps.deviceName = 'iPhone 6'
  #     config.desired_caps.platformVersion = '9.3'
  #     config.desired_caps.app = '/Users/jakesa/Library/Developer/Xcode/DerivedData/mobile-fexownuxytnyvddyyujpnerxqobm/Build/Products/Debug-iphonesimulator/Trucker.app'
  #   end
  #   DATPages.start_driver
  # end
  #
  # after(:all) do
  #   @server.stop
  # end

  it 'should respond to #self.element' do
    expect(DATPages::WebDriver::PageObjects::Page.respond_to? :element).to eq true
  end

  it 'should respomd to #self.page' do
    expect(DATPages::WebDriver::PageObjects::Page.respond_to? :page).to eq true
  end

  it 'should respond to #self.section' do
    expect(DATPages::WebDriver::PageObjects::Page.respond_to? :section).to eq true
  end

  # it 'should respond to #ios_element' do
  #   expect(DATPages::PageObjects::Page.respond_to? :ios_element).to eq true
  # end

  it 'should take selector' do
    result = nil
    begin
      DATPages::WebDriver::PageObjects::Page.new('this_is_a_selector')
      result = true
    rescue
      result = false
    end
    expect(result).to eq true
  end

  it 'should respond to #displayed?' do
    expect(DATPages::WebDriver::PageObjects::Page.new('selector').respond_to? :displayed?).to be true
  end

  it 'should raise an error if #displayed? is called and a selector is not set' do
    begin
      section = DATPages::WebDriver::PageObjects::Page.new 'selector'
      section.displayed?
    rescue => e
      @e = e
    end
    expect(@e).to_not be nil
  end


end