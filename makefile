NAME = firstapp
Configuration = "Debug"

dev: install-prod start
all: install release

install:
	@npm i
	@react-native upgrade
install-prod:
	@npm i --only=production

start: start-ios start-android
start-ios:
	@npm run ios
start-android:
	@npm run android

release: release-ios release-android

release-ios:
	@echo "iOS build start"
	@mkdir -p release
	@rm -f release/$(NAME)-release.ipa
# xcodebuild [-project name.xcodeproj] [[-target targetname] … | -alltargets] [-configuration configurationname] [-sdk [sdkfullpath | sdkname]] [action …] [buildsetting=value …] [-userdefault=value …]
	@xcodebuild archive -project ios/$(NAME).xcodeproj -scheme $(NAME) -configuration $(Configuration) -archivePath ios/build/$(NAME).xcarchive
	@xcodebuild -exportArchive -archivePath ios/build/$(NAME).xcarchive -exportFormat ipa -exportPath ios/build/$(NAME)
	@cp -f ios/build/$(NAME).ipa release/$(NAME)-release.ipa
	@cd ..
	@echo 'iOS build complete: /release/$(NAME)-release.ipa'
