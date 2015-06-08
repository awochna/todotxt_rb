When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

Given /^I have a fresh temporary "([^"]*)" file$/ do |file|
  FileUtils.rm(file) if File.exist? file
  FileUtils.cp('spec/todo.txt', file)
end
