

describe DATPages do

  before :each do
    DATPages.reset
  end

  it 'should respond to #config' do
    expect(DATPages.respond_to? :config).to eq true
  end

  it 'should return a DATPages::Config object when #config is called' do
    expect(DATPages.config.class).to eq DATPages::Config
  end

  it 'should respond to #configure' do
    expect(DATPages.respond_to? :configure).to eq true
  end
  
  it 'should set options though a block when calling #configure' do
    DATPages.configure do |config|
      config.os = 'ios'
      config.desired_caps.app = 'path/to/app'
    end
    expect(DATPages.config.os).to eq 'ios'
    expect(DATPages.config.desired_caps.app).to eq 'path/to/app'
  end

  it 'should respond to #reset' do
    expect(DATPages.respond_to? :reset).to eq true
  end

  it 'should reset the config' do
    DATPages.configure do |_config|
      _config.os = 'ios'
    end
    expect(DATPages.config.os).to eq 'ios'
    DATPages.reset
    expect(DATPages.config.os).to eq 'android'
  end

  it 'should respond to #server' do
    expect(DATPages.respond_to? :server).to eq true
  end

  # it 'should respond to #start_driver' do
  #   expect(DATPages.respond_to? :start_driver).to eq true
  # end

  # specify '#server should return a server object if the server address is set to localhost' do
  #   DATPages.start_server
  #   server_class = DATPages.server.class
  #   DATPages.stop_server
  #   expect(server_class).to eq DATPages::AppiumServer
  # end

  # specify '#remote_server should return a url if the server address is something other than localhost' do
  #   DATPages.configure do |config|
  #     config.server_address = '127.0.0.1'
  #   end
  #   expect(DATPages.remote_server).to eq DATPages.config.url
  # end

  # specify '#remote_server? should return true if the server address is something other than localhost' do
  #   DATPages.configure do |config|
  #     config.server_address = '127.0.0.1'
  #   end
  #   expect(DATPages.remote_server?).to eq true
  # end

  # specify '#start_server should start the server' do
  #   DATPages.start_server
  #   status = DATPages.server.status
  #   DATPages.stop_server
  #   expect(status).to eq 'running'
  # end

  # specify '#stop_server should stop the server' do
  #   DATPages.start_server
  #   begin
  #     status = DATPages.server.status
  #     expect(status).to eq 'running'
  #   rescue => e
  #     puts e
  #     puts e.backtrace
  #     server.stop
  #   end
  #   DATPages.stop_server
  #   expect(DATPages.server.status).to eq 'stopped'
  # end


  # Note: This test isnt one that should be run with every commit as it requires that an app be present and an emulator be running
  # specify '#start_driver should return true if the driver has started correctly' do
  #   DATPages.configure do |config|
  #     config.desired_caps.platformName = 'android'
  #     config.desired_caps.deviceName = 'android_6'
  #     config.desired_caps.app = '/Users/jakesa/mobile/android/trucker/build/outputs/apk/trucker-debug.apk'
  #   end
  #   server = DATPages.server
  #   result = DATPages.start_driver
  #   server.stop
  #   DATPages.stop_driver
  #   expect(result).to eq true
  # end

end