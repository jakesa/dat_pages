
describe DATPages::Appium::PageObjects::Section do


  it 'should take selector' do
    result = nil
    begin
      DATPages::Appium::PageObjects::Section.new('this_is_a_selector')
      result = true
    rescue
      result = false
    end
    expect(result).to eq true
  end

  it 'should respond to #displayed?' do
    expect(DATPages::Appium::PageObjects::Section.new('selector').respond_to? :displayed?).to be true
  end

  it 'should raise an error if #displayed? is called and a selector is not set' do
    begin
      section = DATPages::Appium::PageObjects::Section.new('selector')
      section.displayed?
    rescue => e
      @e = e
    end
    expect(@e).to_not be nil
  end

end