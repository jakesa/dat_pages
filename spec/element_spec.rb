
describe DATPages::PageObjects::Element do

  before :all do
    @server = Server.new false
    @server.start
    @driver = go_to '/'
  end

  after :all do
    @server.stop
  end

  it 'should find the element by css' do
    ele = DATPages::PageObjects::Element.new('#data', nil, :css)
    expect(ele.exists?).to eq true
  end

  it 'should find the element by xpath' do
    ele = DATPages::PageObjects::Element.new('//*[@id="data"]', nil, :xpath)
    expect(ele.exists?).to be true
  end

  it 'should convert convert css to xpath' do
    ele = DATPages::PageObjects::Element.new('#data', nil, :css)
    expect(ele.xpath).to eq "//*[@id = 'data']"
  end

  it 'should click the element' do
    expect(DATPages::PageObjects::Element.new('#submit', nil, :css).click).to be_truthy
  end

  it 'should double click the element' do
    expect(DATPages::PageObjects::Element.new('#submit').double_click).to be_truthy
  end

  it 'should respond to #click_at' do
    expect(DATPages::PageObjects::Element.new('#submit').respond_to?(:click_at)).to be_truthy
  end

  it 'should set the value' do
    ele = DATPages::PageObjects::Element.new('input')
    ele.set 'test'
    expect(ele.value).to eq 'test'
  end

  it 'should send keys' do
    ele = DATPages::PageObjects::Element.new('#name')
    ele.send_keys 'test2'
    expect(ele.value).to eq 'test2'
  end

  specify 'the element should exist' do
    ele = DATPages::PageObjects::Element.new('#name')
    expect(ele.exists?).to be_truthy
  end

  specify 'the element should be visible' do
    ele = DATPages::PageObjects::Element.new('#name')
    expect(ele.visible?).to be_truthy
  end

  specify 'the element should not be visible' do
    ele = DATPages::PageObjects::Element.new('#cell4')
    expect(ele.hidden?).to be_truthy
  end

  it 'should be disabled' do
    ele = DATPages::PageObjects::Element.new('#disabled')
    expect(ele.disabled?).to be_truthy
  end

  it 'should not be enabled' do
    ele = DATPages::PageObjects::Element.new('#submit')
    expect(ele.enabled?).to be_truthy
  end

  it 'should wait until it exists' do
    button = DATPages::PageObjects::Element.new('#add')
    ele = DATPages::PageObjects::Element.new('div[name="newDiv"]')
    button.click
    expect(ele.wait_until_exists(5)).to be true
  end

  it 'should wait until its gone' do
    @driver.visit('/')
    ele = DATPages::PageObjects::Element.new('div[name="newDiv"]')
    DATPages::PageObjects::Element.new('#add').click
    sleep 2
    DATPages::PageObjects::Element.new('#remove').click
    expect(ele.wait_until_gone(5)).to be true
  end

  it 'should wait until its visible' do
    @driver.visit('/')
    ele = DATPages::PageObjects::Element.new('div[name="newDiv"]')
    DATPages::PageObjects::Element.new('#add').click
    sleep 2
    DATPages::PageObjects::Element.new('#hide').click
    sleep 2
    DATPages::PageObjects::Element.new('#show').click
    expect(ele.wait_until_visible(5)).to be true
  end

  it 'should get the text' do
    expect(DATPages::PageObjects::Element.new('#story').text).to be_truthy
  end

  it 'should hover' do
    ele = DATPages::PageObjects::Element.new('#overlay')
    ele.hover
    expect(ele[:style].include?('cadetblue')).to be true

  end

end