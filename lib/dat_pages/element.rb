require 'appium_lib'

module DATPages

  module Element

    Appium.promote_singleton_appium_methods self

    def self.element(name, selector)
      define_method(name) do
        $driver.find_element(selector)
      end
    end

  end

end