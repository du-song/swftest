package org.rollingcode.app;

import flash.display.Sprite;
import flash.display.Stage;
import flash.display.Bitmap;

import flash.display.NativeWindow;
import flash.display.NativeMenu;
import flash.display.NativeMenuItem;

import flash.events.InvokeEvent;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.NativeWindowDisplayStateEvent;
import flash.events.NativeWindowBoundsEvent;

import flash.events.IOErrorEvent;

import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;

import flash.desktop.Clipboard;
import flash.desktop.ClipboardFormats;

import flash.desktop.NativeDragManager;
import flash.events.NativeDragEvent;

import flash.net.URLRequest;

import flash.data.EncryptedLocalStore;

import flash.desktop.NativeApplication;

import air.net.URLMonitor;
import flash.events.StatusEvent;

class Swftest {
	static function makeBtn(): Sprite {
		var btn = new Sprite();
		var width = 288;
		var height = 256;
		btn.graphics.beginFill(0xFFCC00);
		btn.graphics.drawRoundRect(0, 0, width, height, 3);
		return btn;
	}
	
	static public function main() {
		var app = NativeApplication.nativeApplication;
		app.addEventListener(InvokeEvent.INVOKE, function (e: InvokeEvent) {
			//trace("swftest");
		});
		var btn = makeBtn();
		btn.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, function (e: NativeDragEvent) {
				NativeDragManager.acceptDragDrop(btn);
			});
		btn.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, function (e: NativeDragEvent) {
				var files: Array<File> = e.clipboard.getData(flash.desktop.ClipboardFormats.FILE_LIST_FORMAT);
				for (f in files) {
					trace(f.nativePath);
					try {
						var s = f.nativePath;
						var d = (new format.swf.Reader(air.io.File.read(f))).read();
						var v = d.header.version;
						var fps = d.header.fps;
						var m = false;
						var t;
						for (t in d.tags) {
							//if (t is TActionScript3) m = true;
							switch (t) {
								case TActionScript3(data, ctx):
									m = true;
								default:
							}
						}
						trace("application/flash-swf-"+v+(v>8 ? "-as"+(m?3:2) : ""));
						trace("fps: "+(fps/256));
					} catch (e:Dynamic) {
						trace("Error: "+e);
					}
				}
			});
		flash.Lib.current.addChild(btn);
	}
}