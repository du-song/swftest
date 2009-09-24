all:		release

release:	build
	cd output && adt -package -storetype pkcs12 -keystore ../../cert/codecert.p12 swftest.air ../swftest.xml .

debug:		build
	adl swftest.xml output/

build:
	haxe -swf-header 256:256:15:eeeeee -debug -lib air -lib format -swf9 output/swftest.swf -cp . -main org.rollingcode.app.Swftest org.rollingcode.app.Swftest

clean:
	rm -rf output/*