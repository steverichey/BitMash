package;

import flash.events.KeyboardEvent;
import flash.Lib;

class MashInput {
	public static var UP:Bool;
	public static var LEFT:Bool;
	public static var DOWN:Bool;
	public static var RIGHT:Bool;
	public static var SPACE:Bool;
	
	public function new() {
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true );
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp, false, 0, true );
	}
	
	private function onKeyDown( ?k:KeyboardEvent ):Void {
		if ( k.keyCode == 37 ) LEFT = true;
		if ( k.keyCode == 39 ) RIGHT = true;
		if ( k.keyCode == 38 ) UP = true;
		if ( k.keyCode == 40 ) DOWN = true;
		if ( k.keyCode == 32 ) SPACE = true;
	}
	
	private function onKeyUp( ?k:KeyboardEvent ):Void {
		if ( k.keyCode == 37 ) LEFT = false;
		if ( k.keyCode == 39 ) RIGHT = false;
		if ( k.keyCode == 38 ) UP = false;
		if ( k.keyCode == 40 ) DOWN = false;
		if ( k.keyCode == 32 ) SPACE = false;
	}
	
	public function destroy():Void {
		Lib.current.stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		Lib.current.stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
	}
}