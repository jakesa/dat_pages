

describe 'Capabilities' do

  it 'should set the os to android' do
    caps = DATPages::Capabilities.new('android')
    expect(caps.os).to eq 'android'
  end

  it 'should create setters and getters for android capabilities' do
    caps = DATPages::Capabilities.new('android')
    expect(caps.respond_to? :appActivity).to eq true
  end

  it 'should create setters and getters for ios capabilities' do
    caps = DATPages::Capabilities.new('ios')
    expect(caps.respond_to? :bundleId).to eq true
  end

  it 'should respond to #to_hash' do
    expect(DATPages::Capabilities.new('android').respond_to? :to_hash).to eq true
  end

  it 'should return a hash with the capabilities' do
    caps = DATPages::Capabilities.new('android')
    caps.appActivity = true
    caps.app = 'path/to/app'
    expect(caps.to_hash.is_a? Hash).to eq true
    expect(caps.to_hash[:caps][:appActivity]).to eq true
    expect(caps.to_hash[:caps][:app]).to eq 'path/to/app'
  end


end