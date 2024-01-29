source "https://rubygems.org"

gem "fastlane", ">= 2.219"
gem "jazzy"
gem "cocoapods", ">= 1.14"
gem "plist"
gem 'mime-types'
gem 'xcode-install'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)