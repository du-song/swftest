package air.io;

import air.io.FileInput;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

class File {
	static public function read(fs):haxe.io.Input {
		var f = new FileStream();
		f.open(fs, FileMode.READ);
		//return new FileInput(f);
		var b = new flash.utils.ByteArray();
		f.readBytes(b);
		return new haxe.io.BytesInput(haxe.io.Bytes.ofData(b));
	}
}