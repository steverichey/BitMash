package;

import flash.Lib;
import flash.events.Event;
import flash.events.KeyboardEvent;

class ThrGame extends ThrSprite {
	private var _player:ThrBitmap;
	private var _goal:ThrBitmap;
	private var _level:ThrBitmap;
	
	public function new() {
		super();
	}
	
	override private function init( ?e:Event ):Void {
		super.init( e );
		
		_player = new ThrBitmap( 16, 16 );
		_goal = new ThrBitmap( 16, 16 );
		_goal.x = randomize( 0, Std.int( 300 - _goal.width ) );
		_goal.y = randomize( 0, Std.int( 300 - _goal.height ) );
		_level = new ThrBitmap( 300, 300 );
		
		add( _level );
		add( _goal );
		add( _player );
		
		addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
		
		ready = true;
	}
	
	override private function update( ?e:Event ):Void {
		if ( ready ) {
			super.update( e );
			_level.regenerate();
		}
	}
	
	private function onKeyDown( k:KeyboardEvent ):Void {
		if ( k.keyCode == 37 ) {
			_player.x --;
		}
		
		if ( k.keyCode == 39 ) {
			_player.x ++;
		}
		
		if ( k.keyCode == 38 ) {
			_player.y --;
		}
		
		if ( k.keyCode == 40 ) {
			_player.y ++;
		}
	}
	
	private function randomize( lo:Int, hi:Int ):Int {
		return Std.int( Math.random() * ( hi - lo ) + lo );
	}
}