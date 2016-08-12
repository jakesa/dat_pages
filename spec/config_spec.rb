

describe DATPages::Config do

  it 'should respond to #desired_caps' do
    expect(DATPages::Config.new.respond_to? :desired_caps).to eq true
  end

  it 'should respond to #os' do
    expect(DATPages::Config.new.respond_to? :os).to eq true
  end

  it 'should respond to #server_address' do
    expect(DATPages::Config.new.respond_to? :server_address).to eq true
  end

  it 'should respond to #server_port' do
    expect(DATPages::Config.new.respond_to? :server_port).to eq true
  end

  it 'should respond to #url' do
    expect(DATPages::Config.new.respond_to? :url).to eq true
  end

  it 'should default the os to android' do
    config = DATPages::Config.new
    expect(config.os).to eq 'android'
  end

  it 'should default to localhost for the server address' do
    expect(DATPages::Config.new.server_address).to eq 'localhost'
  end

  it 'should default to 4723 for the server port' do
    expect(DATPages::Config.new.server_port).to eq 4723
  end

  it 'should set the os to the os specified' do
    config = DATPages::Config.new('ios')
    expect(config.os).to eq 'ios'
  end

  it 'should change the capabilities when the os is changed' do
    config = DATPages::Config.new
    config.os = 'ios'
    expect(config.desired_caps.respond_to? :bundleId).to eq true
    expect(config.desired_caps.respond_to? :appActivity).to eq false
  end

  it 'should return a url' do
    config = DATPages::Config.new
    expect(config.url).to eq 'http://localhost:4723/wd/hub'
  end

  it 'should return the correct url when the server address and port are changed' do
    server_address = '127.0.0.1'
    server_port = 4455
    config = DATPages::Config.new
    config.server_address = server_address
    config.server_port = server_port
    expect(config.url).to eq "http://#{server_address}:#{server_port}/wd/hub"
  end

  it 'should respond to #server_wait_time' do
    expect(DATPages::Config.new.respond_to? :server_wait_time).to eq true
  end

  specify 'the server_wait_time should default to 3' do
    expect(DATPages::Config.new.server_wait_time).to eq 3
  end

  specify 'I should be able to set the server_wait_time' do
    config = DATPages::Config.new
    config.server_wait_time = 10
    expect(config.server_wait_time).to eq 10
  end

  it 'should create a method if it is missing and follows the name= pattern' do
    config = DATPages::Config.new
    expect(begin
      config.cucumber_options = ['these', 'are', 'the', 'options']
      true
    rescue => e
      puts e
      puts e.backtrace
      false
    end).to be true
    expect(config.respond_to? :cucumber_options=).to eq true
    expect(config.respond_to? :cucumber_options).to eq true
    expect(config.cucumber_options).to eq ['these', 'are', 'the', 'options']
  end

  it 'should raise a no method error if the method name doesnt have an = at the end' do
    config = DATPages::Config.new
    error = (
    begin
      config.this_should_not_work
    rescue =>e
     e
    end
    )
    expect(error.class).to eq NoMethodError
  end

end