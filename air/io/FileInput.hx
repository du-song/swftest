package air.io;
import haxe.io.Input;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

/**
	Use [air.io.File.read] to create a [FileInput]
**/
class FileInput extends Input {

	private var f : FileStream;

	public function new(_f) {
		f = _f;
	}

	public override function readByte() : Int {
		try {
			return (f.readByte() + 256) & 255;
		} catch (e:Dynamic) {
			throw new haxe.io.Eof();
		}
	}

	public override function readFloat() : Float {
		trace(4);
		return f.readFloat();
	}
	
	public override function close() {
		super.close();
		f.close();
	}
}