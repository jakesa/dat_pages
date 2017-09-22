require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:all) do |task|
  task.pattern = 'spec/'
end

RSpec::Core::RakeTask.new(:appium) do |task|
  task.pattern = 'spec/appium'
end

RSpec::Core::RakeTask.new(:web_driver) do |task|
  task.pattern = 'spec/web_driver'
end

RSpec::Core::RakeTask.new(:top_level) do |task|
  task.pattern = 'spec/*_spec.rb/'
end

task default: :all
task travis: %i[web_driver top_level]
