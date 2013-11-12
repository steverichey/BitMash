package;

import flash.events.KeyboardEvent;
import flash.Lib;

/**
 * A simple class to accept input; usually instantiated in the BitMash class, and used statically to check for key status in a MashGame class.
 * 
 * @author Steve Richey
 */
class MashInput {
	public static var up:MashButton;
	public static var left:MashButton;
	public static var down:MashButton;
	public static var right:MashButton;
	public static var space:MashButton;
	
	public function new() {
		up = new MashButton();
		left = new MashButton();
		down = new MashButton();
		right = new MashButton();
		space = new MashButton();
		
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown, false, 0, true );
		Lib.current.stage.addEventListener( KeyboardEvent.KEY_UP, onKeyUp, false, 0, true );
	}
	
	private function onKeyDown( ?k:KeyboardEvent ):Void {
		if ( k.keyCode == 37 ) left.pressed = true;
		if ( k.keyCode == 39 ) right.pressed = true;
		if ( k.keyCode == 38 ) up.pressed = true;
		if ( k.keyCode == 40 ) down.pressed = true;
		if ( k.keyCode == 32 ) space.pressed = true;
	}
	
	private function onKeyUp( ?k:KeyboardEvent ):Void {
		if ( k.keyCode == 37 ) left.pressed = false;
		if ( k.keyCode == 39 ) right.pressed = false;
		if ( k.keyCode == 38 ) up.pressed = false;
		if ( k.keyCode == 40 ) down.pressed = false;
		if ( k.keyCode == 32 ) space.pressed = false;
	}
	
	public function destroy():Void {
		Lib.current.stage.removeEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		Lib.current.stage.removeEventListener( KeyboardEvent.KEY_UP, onKeyUp );
	}
}