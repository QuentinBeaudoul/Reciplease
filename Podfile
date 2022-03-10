platform :ios, '15.2'
workspace 'Reciplease.xcworkspace'
inhibit_all_warnings!

abstract_target 'Shared' do
use_frameworks!

	pod 'SwiftLint'
	pod 'R.swift'
	pod 'Alamofire'

	target 'RSearch' do
		project 'Frameworks/RSearch/RSearch.xcodeproj'

		pod 'LoadableViews'

		target 'RSearchTests' do
			inherit! :complete
        		end
	end

	target 'RFavorite' do 
		project 'Frameworks/RFavorite/RFavorite.xcodeporj'		
	
		pod 'LoadableViews'

		target 'RFavoriteTests' do
			inherit! :complete
		end
	end

	target 'RExtension' do
		project 'Frameworks/RExtension/RExtension.xcodeproj'
	end

	target 'RNetwork' do
		project 'Frameworks/RNetwork/RNetwork.xcodeproj'
	end

	target 'RStorage' do
		project 'Frameworks/RStorage/RStorage.xcodeproj'
	end		

	target 'Reciplease' do
		pod 'LoadableViews'
		project 'Reciplease/Reciplease.xcodeproj'
	end
end
