gen: 
	xcodegen
	swiftgen config run --config swiftgen.yml
	echo "Opening project..."
	open RickAndMorty.xcodeproj  
