package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.KeyboardEvent;
import flash.geom.Point;

/**
 * A playable MashSprite class that will eventually be fully customizable via XML or some junk.
 * 
 * @author Steve Richey
 */
class MashGame extends MashSprite {
	private var _superBG:MashBitmap;
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
		
		//_superBG = new MashBitmap( 400, 200, MOVE_DIST );
		//add( new Bitmap( new BitmapData( 400, 200, false, 0xff000000 ) ) );
		
		_text = new MashBitmapText( "bitmash", 8, 2, MOVE_DIST, new ColorBounds( new ColorBound( 128,240 ), new ColorBound( 128,240), new ColorBound( 230,255 ) ) );
		_text.x = MOVE_DIST;
		_text.y = MOVE_DIST;
		_text.setInterval( 500 );
		add( _text );
		
		_bg = new MashBitmap( 200, 200, MOVE_DIST, new ColorBounds( new ColorBound(0,100), new ColorBound(0,100), new ColorBound( 0, 100 ) ) );
		_bg.x = _text.fx + MOVE_DIST;
		_bg.setInterval( 250 );
		add( _bg );
		
		//_level = new MashTiles( MashTiles.generateEmptySquare( 12, 12 ), 12, MOVE_DIST, MOVE_DIST );
		//_level.x = _text.fx + MOVE_DIST;
		//_level.y = MOVE_DIST;
		//add( _level );
		
		_instructions = new MashBitmapText( MashLevels.getText(), 4, 6, MOVE_DIST, new ColorBounds( new ColorBound(0,1), new ColorBound(0,1) ) );
		_instructions.x = _bg.fx + MOVE_DIST;
		_instructions.y = MOVE_DIST;
		_instructions.setInterval( 1000 );
		add( _instructions );
		
		_goal = new MashBitmap( MOVE_DIST * SIZE, MOVE_DIST * SIZE, MOVE_DIST, new ColorBounds( null, new ColorBound( 0, 1 ) ) );
		_goal.x = MashRandom.intRangedStep( _bg.mx, _bg.fx - _goal.gw, MOVE_DIST );
		_goal.y = MashRandom.intRangedStep( _bg.my, _bg.fy - _goal.gh, MOVE_DIST );
		_goal.setInterval( 17 );
		add( _goal );
		
		_player = new MashBitmap( MOVE_DIST * SIZE, MOVE_DIST * SIZE, MOVE_DIST, new ColorBounds( new ColorBound( 0, 1) ) );
		_player.x = MashRandom.intRangedStep( _bg.gx, _bg.mx - _player.gw, MOVE_DIST );
		_player.y = MashRandom.intRangedStep( _bg.gy, _bg.my - _player.gh, MOVE_DIST );
		_player.setInterval( 17 );
		_player.moves = true;
		add( _player );
		
		ready = true;
	}
	
	override public function update( ?e:Event ):Void {
		super.update( e );
		
		if ( ready ) {
			
			var tempPlayerX:Int = _player.gx;
			var tempPlayerY:Int = _player.gy;
			
			if ( MashInput.up.pressed ) {
				tempPlayerY -= MOVE_DIST;
			}
			
			if ( MashInput.down.pressed ) {
				tempPlayerY += MOVE_DIST;
			}
			
			if ( MashInput.left.pressed ) {
				tempPlayerX -= MOVE_DIST;
			}
			
			if ( MashInput.right.pressed ) {
				tempPlayerX += MOVE_DIST;
			}
			
			if ( MashInput.space.pressed ) {
				haxe.Log.trace( "Player at: " + _player.x + ", " + _player.y );
			}
			
			if ( tempPlayerX >= _bg.x && tempPlayerX + _player.width <= _bg.x + _bg.width ) {
				_player.x = tempPlayerX;
			}
			
			if ( tempPlayerY >= _bg.y && tempPlayerY + _player.height <= _bg.y + _bg.height ) {
				_player.y = tempPlayerY;
			}
			
			_player.x = tempPlayerX;
			_player.y = tempPlayerY;
			
			//MashTools.collide( _player, _level );
			
			if ( MashTools.overlap( _player, _goal ) ) {
				ready = false;
				dispatchEvent( new Event( Event.COMPLETE ) );
			}
		}
	}
}