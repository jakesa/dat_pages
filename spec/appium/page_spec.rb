

describe DATPages::Appium::PageObjects::Page do

  it 'should respond to #self.element' do
    expect(DATPages::Appium::PageObjects::Page.respond_to? :element).to eq true
  end

  it 'should respomd to #self.page' do
    expect(DATPages::Appium::PageObjects::Page.respond_to? :page).to eq true
  end

  it 'should respond to #self.section' do
    expect(DATPages::Appium::PageObjects::Page.respond_to? :section).to eq true
  end


  it 'should respond to #displayed?' do
    expect(DATPages::Appium::PageObjects::Page.new.respond_to? :displayed?).to be true
  end

  it 'should raise an error if #displayed? is called and a selector is not set' do
    begin
      section = DATPages::Appium::PageObjects::Page.new
      section.displayed?
    rescue => e
      @e = e
    end
    expect(@e).to_not be nil
  end


end