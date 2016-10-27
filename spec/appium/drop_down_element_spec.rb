describe DATPages::Appium::PageObjects::DropDownElement do


  it 'should respond to #select' do
    element = DATPages::Appium::PageObjects::DropDownElement.new('this', nil, :id)
    expect(element.respond_to? :select).to be true
  end


end