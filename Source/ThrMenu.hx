package;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Point;

class ThrMenu extends ThrSprite {
	private var _text:ThrBitmapText;
	private var _bg:ThrBitmap;
	private var _instructions:ThrBitmapText;
	private var _player:ThrBitmap;
	private var _goal:ThrBitmap;
	private var _input:ThrInput;
	
	private static inline var MOVE_DIST:Int = 4;
	
	public function new() {
		super();
	}
	
	override private function init( ?e:Event ):Void {
		super.init( e );
		
		_text = new ThrBitmapText( "bit-thrash", 8, 3, 4 );
		_text.x = 4;
		_text.y = 4;
		add( _text );
		
		_bg = new ThrBitmap( 200, 200, 4 );
		_bg.x = Std.int( _text.x + _text.width + 4 );
		add( _bg );
		
		_instructions = new ThrBitmapText( "input-up    left  down  right space", 4, 6, 2 );
		_instructions.x = Std.int( _bg.x + _bg.width + 4 );
		_instructions.y = Std.int( _bg.y + 4 );
		add( _instructions );
		
		_goal = new ThrBitmap( 8, 8, 8 );
		_goal.x = Std.int( _bg.x + _bg.width - _goal.width );
		_goal.y = Std.int( _bg.y + _bg.height - _goal.height );
		add( _goal );
		
		_player = new ThrBitmap( 8, 8, 8 );
		_player.x = _bg.x;
		_player.y = _bg.y;
		add( _player );
		
		ready = true;
	}
	
	override private function update( ?e:Event ):Void {
		super.update( e );
		
		if ( ready ) {
			_bg.regenerate();
			
			var tempPlayerX:Int = Std.int( _player.x );
			var tempPlayerY:Int = Std.int( _player.y );
			
			if ( ThrInput.UP ) {
				tempPlayerY -= MOVE_DIST;
			}
			
			if ( ThrInput.DOWN ) {
				tempPlayerY += MOVE_DIST;
			}
			
			if ( ThrInput.LEFT ) {
				tempPlayerX -= MOVE_DIST;
			}
			
			if ( ThrInput.RIGHT ) {
				tempPlayerX += MOVE_DIST;
			}
			
			if ( tempPlayerX >= _bg.x && tempPlayerX + _player.width <= _bg.x + _bg.width ) {
				_player.x = tempPlayerX;
			}
			
			if ( tempPlayerY >= _bg.y && tempPlayerY + _player.height <= _bg.y + _bg.height ) {
				_player.y = tempPlayerY;
			}
			
			if ( _player.x == _goal.x && _player.y == _goal.y ) {
				ready = false;
			}
		}
	}
	
	override private function destroy():Void {
		_input.destroy();
		
		super.destroy();
	}
}