

describe DATPages::WebDriver::PageObjects::Page do

  it 'should respond to #self.element' do
    expect(DATPages::WebDriver::PageObjects::Page.respond_to? :element).to eq true
  end

  it 'should respond to #self.page' do
    expect(DATPages::WebDriver::PageObjects::Page.respond_to? :page).to eq true
  end

  it 'should respond to #self.section' do
    expect(DATPages::WebDriver::PageObjects::Page.respond_to? :section).to eq true
  end


end