# RecentPhotos

The RecentPhotos app for iOS will allow you to browse the most recent Flickr images and their captions.

## Project Setup

1. Install Homebrew

		/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		
1. Install rbenv via Homebrew
	 
		 brew install rbenv
 
1. Add rbenv script to `~/.bash_profile`

		#Rbenv
		eval "$(rbenv init -)"
		
1. Install the Ruby version listed in the project's `.ruby-version` file via rbenv. Example:

		rbenv install 2.6.2
		
1. Install Bundler with RubyGems

		gem install bundler
		
1. Install RubyGems listed in Gemfile via Bundler

		bundle install
	
	**Note**: From this point on use `bundle exec` to run any of the RubyGems. Example: `bundle exec pod install`
	
1.	Install dependencies via CocoaPods
	
		bundle exec pod install
		


