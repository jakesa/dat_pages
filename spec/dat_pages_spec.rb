

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

end