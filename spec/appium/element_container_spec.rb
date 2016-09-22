
describe DATPages::Appium::PageObjects::ElementContainer do

  class DummyDriver
    def find_element(by, selector)
      if by.class != Symbol
        puts "#{by} needs to be a Symbol"
        false
      else
        true
      end
    end

    def ele_by_json_visible_exact(ui_element, value)
      true
    end

    def button(value)
      true
    end

    def find(text)
      true
    end

  end

  class DummySection
    def initialize(*args)
    end
  end
  class DummyPage < DummySection
  end

  class DummyClass
    extend DATPages::Appium::PageObjects::ElementContainer
    element(:test, :id, 'selector')
    element(:test_by_text, :text, 'text')
    section(:section_1, DummySection, 'selector')
    page(:page_1, DummyPage, 'url?')
    locator 'this is a locator'
    find_by :id
  end

  def check_for_private_method?(klass, name)
    begin
      klass.send(name)
      true
    rescue =>e
      puts e
      puts e.backtrace
      false
    end
  end

  before :all do
    @old_driver = $driver
    $driver = DummyDriver.new
  end

  after :all do
    $driver = @old_driver
  end


  it 'should add #self.element to a class' do
    expect(DummyClass.respond_to? :element).to eq true
  end

  # it 'should add #self.ios_element to a class' do
  #   expect(DummyClass.respond_to? :ios_element).to eq true
  # end

  it 'should add #self.section to a class' do
    expect(DummyClass.respond_to? :section).to eq true
  end

  it 'should add #self.page to a class' do
    expect(DummyClass.respond_to? :page).to eq true
  end

  it 'should add the #test private instance method to the class' do
    expect(check_for_private_method?(DummyClass.new, :test)).to eq true
  end

  it 'should add the #section_1 private instance method to the class' do
    expect(check_for_private_method? DummyClass.new, :section_1).to eq true
  end

  specify '#section_1 should return an instance of DummySection' do
    expect(DummyClass.new.send(:section_1).class).to eq DummySection
  end

  it 'should add the #page_1 private instance method to the class' do
    expect(check_for_private_method? DummyClass.new, :page_1).to eq true
  end

  specify '#page_1 should return an instance of DummyPage' do
    expect(DummyClass.new.send(:page_1).class).to eq DummyPage
  end

  # it 'should add the #test_2 private instance method to the class' do
  #   expect(check_for_private_method? DummyClass.new, :test_2).to eq true
  # end

  # it 'should add the #submit private instance method to the class' do
  #   expect(check_for_private_method? DummyClass.new, :submit).to eq true
  # end

  specify 'An element defined using :text as the selector type should work' do
    expect(check_for_private_method? DummyClass.new, :test_by_text).to eq true
  end

  it 'should respond to locator' do
    expect(DummyClass.respond_to? :locator).to eq true
  end

  it 'should respond to find_by' do
    expect(DummyClass.respond_to? :find_by).to eq true
  end

  it 'should return a locator' do
    expect(DummyClass.new.locator).to eq 'this is a locator'
  end

  it 'should return the find_by value' do
    expect(DummyClass.new.find_by.to_sym).to eq :id
  end






end