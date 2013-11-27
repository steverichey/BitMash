package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.text.TextField;
import haxe.Log;

/**
 * Main BitMash game class.
 * 
 * @author Steve Richey
 */
class BitMash extends MashSprite {
	private var _game:MashGame;
	private var _input:MashInput;
	
	public function new() {
		super();
	}
	
	override private function init( ?e:Event ):Void {
		super.init( e );
		
		MashRandom.seed = Math.round( Math.random() * MashRandom.MODULUS );
		_input = new MashInput();
		
		createLevel();
	}
	
	override public function update( ?e:Event ):Void {
		super.update(e);
		
		if ( _game != null ) {
			_game.update(e);
		}
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
		
		MashLevels.level 
		
		createLevel();
	}
}