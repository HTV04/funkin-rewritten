lovefile:
	@rm -rf build/lovefile
	@mkdir -p build/lovefile
	
	@cd src/love; zip -r ../../build/lovefile/funkin-rewritten.love .
	@zip -0 build/lovefile/funkin-rewritten.love LICENSE

win64: lovefile
	@rm -rf build/win64
	@mkdir -p build/win64
	
	@cp dependencies/win64/love/OpenAL32.dll build/win64
	@cp dependencies/win64/love/SDL2.dll build/win64
	@cp dependencies/win64/love/license.txt build/win64
	@cp dependencies/win64/love/lua51.dll build/win64
	@cp dependencies/win64/love/mpg123.dll build/win64
	@cp dependencies/win64/love/love.dll build/win64
	@cp dependencies/win64/love/msvcp120.dll build/win64
	@cp dependencies/win64/love/msvcr120.dll build/win64
	
	@cat dependencies/win64/love/love.exe build/lovefile/funkin-rewritten.love > build/win64/funkin-rewritten.exe

macos: lovefile
	@rm -rf build/macos
	@mkdir -p build/macos
	
	@cp -r dependencies/macos/love.app "build/macos/Friday Night Funkin' Rewritten.app"
	
	@cp dependencies/macos/Info.plist "build/macos/Friday Night Funkin' Rewritten.app/Contents"
	@cp build/lovefile/funkin-rewritten.love "build/macos/Friday Night Funkin' Rewritten.app/Contents/Resources"

release: lovefile win64 macos
	@rm -rf build/release
	@mkdir -p build/release
	
	@cd build/lovefile; zip -9 -r ../release/funkin-rewritten-lovefile.zip .
	@cd build/win64; zip -9 -r ../release/funkin-rewritten-win64.zip .
	@cd build/macos; zip -9 -r ../release/funkin-rewritten-macos.zip .

clean:
	@rm -rf build
