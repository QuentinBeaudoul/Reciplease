platform :ios, '15.2'
workspace 'Reciplease.xcworkspace'
use_frameworks!

# Globale Pods

pod 'SwiftLint'
pod 'R.swift'
pod 'Alamofire'

###############

target 'RExtension' do
	project 'Frameworks/RExtension/RExtension.xcodeproj'
end

target 'RFavorite' do 
	project 'Frameworks/RFavorite/RFavorite.xcodeporj'
	
	target 'RFavoriteTests' do
		inherit! :complete
	end
end

target 'RNetwork' do
	project 'Frameworks/RNetwork/RNetwork.xcodeproj'
end

target 'RSearch' do
	project 'Frameworks/RSearch/RSearch.xcodeproj'

	target 'RSearchTests' do
                inherit! :complete
        end
end

target 'RStorage' do
	project 'Frameworks/RStorage/RStorage.xcodeproj'
end		

target 'Reciplease' do
	project 'Reciplease/Reciplease.xcodeproj'
end
