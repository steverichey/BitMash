package;

import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Point;

/**
 * A playable MashSprite class that will eventually be fully customizable via XML or some junk.
 * 
 * @author Steve Richey
 */
class MashGame extends MashSprite {
	private var _text:MashBitmapText;
	private var _bg:MashBitmap;
	private var _level:MashTiles;
	private var _instructions:MashBitmapText;
	private var _player:MashBitmap;
	private var _goal:MashBitmap;
	
	private static inline var SIZE:Int = 3;
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
		/*
		_bg = new MashBitmap( 200, 200, MOVE_DIST );
		_bg.x = _text.gx + _text.gw + 4;
		_bg.setInterval( 400 );
		add( _bg );
		*/
		
		_level = new MashTiles( [ 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1 ], 5 );
		_level.x = _text.fx + 4;
		add( _level );
		
		_instructions = new MashBitmapText( MashLevels.getText(), 4, 6, 2 );
		_instructions.x = _bg.gx + _bg.gw + 4;
		_instructions.y = _bg.gy + 4;
		add( _instructions );
		
		_goal = new MashBitmap( MOVE_DIST * SIZE, MOVE_DIST * SIZE, MOVE_DIST );
		_goal.x = randomize( _bg.mx, _bg.fx - _goal.gw, MOVE_DIST );
		_goal.y = randomize( _bg.my, _bg.fy - _goal.gh, MOVE_DIST );
		_goal.setInterval( 17 );
		add( _goal );
		
		_player = new MashBitmap( MOVE_DIST * SIZE, MOVE_DIST * SIZE, MOVE_DIST );
		_player.x = randomize( _bg.gx, _bg.mx - _player.gw, MOVE_DIST );
		_player.y = randomize( _bg.gy, _bg.my - _player.gh, MOVE_DIST );
		_player.setInterval( 34 );
		add( _player );
		
		ready = true;
	}
	
	override private function update( ?e:Event ):Void {
		super.update( e );
		
		if ( ready ) {
			//_bg.regenerate();
			
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