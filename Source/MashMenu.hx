package;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Point;

class MashMenu extends MashSprite {
	private var _text:MashBitmapText;
	private var _bg:MashBitmap;
	private var _instructions:MashBitmapText;
	private var _player:MashBitmap;
	private var _goal:MashBitmap;
	
	private static inline var MOVE_DIST:Int = 4;
	
	public function new() {
		super();
	}
	
	override private function init( ?e:Event ):Void {
		super.init( e );
		
		_text = new MashBitmapText( "bitmash", 8, 3, 4 );
		_text.x = 4;
		_text.y = 4;
		add( _text );
		
		_bg = new MashBitmap( 200, 200, 4 );
		_bg.x = _text.gx + _text.gw + 4;
		add( _bg );
		
		_instructions = new MashBitmapText( "input:up    left  down  right space", 4, 6, 2 );
		_instructions.x = _bg.gx + _bg.gw + 4;
		_instructions.y = _bg.gy + 4;
		add( _instructions );
		
		_goal = new MashBitmap( 4, 4, 1 );
		_goal.x = randomize( _bg.mx, _bg.fx - _goal.gw, MOVE_DIST );
		_goal.y = randomize( _bg.my, _bg.fy - _goal.gh, MOVE_DIST );
		add( _goal );
		
		_player = new MashBitmap( 4, 4, 1 );
		_player.x = randomize( _bg.gx, _bg.mx - _player.gw, MOVE_DIST );
		_player.y = randomize( _bg.gy, _bg.my - _player.gh, MOVE_DIST );
		add( _player );
		
		ready = true;
	}
	
	override private function update( ?e:Event ):Void {
		super.update( e );
		
		if ( ready ) {
			_bg.regenerate();
			
			var tempPlayerX:Int = _player.gx;
			var tempPlayerY:Int = _player.gy;
			
			if ( MashInput.UP ) {
				tempPlayerY -= MOVE_DIST;
			}
			
			if ( MashInput.DOWN ) {
				tempPlayerY += MOVE_DIST;
			}
			
			if ( MashInput.LEFT ) {
				tempPlayerX -= MOVE_DIST;
			}
			
			if ( MashInput.RIGHT ) {
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
				dispatchEvent( new Event( Event.COMPLETE ) );
			}
		}
	}
}