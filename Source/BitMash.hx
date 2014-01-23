package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.Lib;
import flash.text.TextField;
import haxe.Log;

/**
 * Main BitMash game class.
 * 
 * @author Steve Richey
 */
class BitMash extends MashSprite {
	private var _title:MashTitle;
	private var _game:MashGame;
	private var _input:MashInput;
	
	public static var gameWidth:Int;
	public static var gameHeight:Int;
	
	public function new() {
		super();
	}
	
	override private function init( ?e:Event ):Void {
		super.init( e );
		
		gameWidth = Std.int( this.width );
		gameHeight = Std.int( this.height );
		
		MashRandom.seed = 1;
		_input = new MashInput();
		
		//_title = new MashTitle();
		//addChild( _title );
		
		createLevel();
		
		if ( _title != null ) {
			_title.addEventListener( Event.COMPLETE, onBeginGame, false, 0, true );
		}
	}
	
	override public function update( ?e:Event ):Void {
		super.update(e);
		
		if ( _game != null ) {
			_game.update(e);
		}
	}
	
	private function onBeginGame( ?e:Event ):Void {
		_title.removeEventListener( Event.COMPLETE, onBeginGame );
		
		// We get the seed from how long (in frames) the player stays on the main screen. Until then, it's 1.
		
		MashRandom.seed = _title.getTime();
		
		removeChild( _title );
		_title.destroy();
		_title = null;
		
		createLevel();
	}
	
	private function createLevel():Void {
		_game = new MashGame();
		addChild( _game );
		
		_game.addEventListener( Event.COMPLETE, levelEnd );
	}
	
	private function levelEnd( ?e:Event ):Void {
		_game.removeEventListener( Event.COMPLETE, levelEnd );
		removeChild( _game );
		_game.destroy();
		_game = null;
		
		MashLevels.level ++;
		
		createLevel();
	}
	
	public static inline function getWidth():Int {
		var w:Int = 0;
		
		if ( gameWidth == 0 ) {
			w = 300;
		} else {
			w = gameWidth;
		}
		
		return w;
	}
	
	public static inline function getHeight():Int {
		return gameHeight;
	}
}