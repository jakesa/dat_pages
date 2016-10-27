

describe DATPages::Appium::PageObjects::Element do

  it 'should be able to be initialized with just a selector' do
    expect(DATPages::Appium::PageObjects::Element.new('this')).to be_truthy
  end

  it 'should be able to be initialized with a selector, parent and find_by' do
    expect(DATPages::Appium::PageObjects::Element.new('this', nil, :id)).to be_truthy
  end

  it 'should respond to #swipe' do
    expect(DATPages::Appium::PageObjects::Element.new('this').respond_to? :swipe).to be true
  end

  it 'should respond to #type' do
    expect(DATPages::Appium::PageObjects::Element.new('this').respond_to? :type).to be true
  end

  it 'should respond to #click' do
    expect(DATPages::Appium::PageObjects::Element.new('this').respond_to? :click).to be true
  end

  it 'should respond to #send_keys' do
    expect(DATPages::Appium::PageObjects::Element.new('this').respond_to? :send_keys).to be true
  end

  it 'should respond to #text' do
    expect(DATPages::Appium::PageObjects::Element.new('this').respond_to? :text).to be true
  end

  it 'should respond to #name' do
    expect(DATPages::Appium::PageObjects::Element.new('this').respond_to? :name).to be true
  end

  it 'should respond to #displayed?' do
    expect(DATPages::Appium::PageObjects::Element.new('this').respond_to? :displayed?).to be true
  end

  it 'should respond to #clear' do
    expect(DATPages::Appium::PageObjects::Element.new('this').respond_to? :clear).to be true
  end

  it 'should respond to #selected?' do
    expect(DATPages::Appium::PageObjects::Element.new('this').respond_to? :selected?).to be true
  end

  it 'should respond to #exists?' do
    expect(DATPages::Appium::PageObjects::Element.new('this').respond_to? :exists?).to be true
  end

  it 'should respond to #press_keycode' do
    expect(DATPages::Appium::PageObjects::Element.new('this').respond_to? :press_keycode).to be true
  end

end