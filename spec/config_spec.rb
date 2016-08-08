

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

end