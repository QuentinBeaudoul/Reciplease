platform :ios, '15.2'
workspace 'Reciplease.xcworkspace'

abstract_target 'Shared' do
use_frameworks!

	pod 'SwiftLint'
	pod 'R.swift'
	pod 'Alamofire'

	target 'RSearch' do
		project 'Frameworks/RSearch/RSearch.xcodeproj'

		target 'RSearchTests' do
        		end
	end

	target 'RFavorite' do 
		project 'Frameworks/RFavorite/RFavorite.xcodeporj'		
	
		target 'RFavoriteTests' do
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
		project 'Reciplease/Reciplease.xcodeproj'
	end
end
