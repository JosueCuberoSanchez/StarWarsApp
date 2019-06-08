This project uses Ruby and CocoaPods. We use `rvm` to manage the Ruby version, and `bundler` to manage the CocoaPods version (among other dependencies), to ensure everyone uses the same versions without affecting their system and/or other projects.

## Installation
1. Install `rvm` (Ruby version manager) from https://rvm.io/ if you don't have it already
2. Make sure you `cd` to the project directory with the `Gemfile` and `Podfile`
3. Install the correct Ruby version using: `rvm install $(< .ruby-version)`
4. Update the current shell session to use the correct Ruby version using: `rvm use`
5. Install `bundler` using: `gem install bundler`
6. Install gem dependencies (including cocoapods) using: `bundle install`
7. Install pod dependencies using: `bundle exec pod install`

## Update Gem
1. Update Gemfile
2. Update the current shell session to use the correct Ruby version using: `rvm use`
3. Make sure you `cd` to the project directory with the `Gemfile`
4. Update gem dependencies (including cocoapods) using: `bundle update <GemName>`

## Update Pod
1. Update Podfile
2. Update the current shell session to use the correct Ruby version using: `rvm use`
3. Make sure you `cd` to the project directory with the `Podfile`
4. Update pod dependencies using: `bundle exec pod update <PodName>`

## Xcode Ruby build scripts
When running a Ruby script through Xcode build scripts, it should use the same Ruby version. To ensure this, you must:

1. Change the Shell to: `/bin/bash -l`
2. At the top of the script, update the shell session to use the correct Ruby version using: `rvm use`