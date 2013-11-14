package;

import flash.events.Event;
import haxe.Log;

/**
 * Main BitMash game class.
 * 
 * @author Steve Richey
 */
class BitMash extends MashSprite {
	private var _game:MashGame;
	private var _displayed:MashGlitch;
	private var _input:MashInput;
	private var _test:Glitchmap;
	
	public function new() {
		super();
	}
	
	override private function init( ?e:Event ):Void {
		super.init( e );
		_input = new MashInput();
		//_displayed = new MashGlitch( this.getWidth(), this.getHeight() );
		//addChild( _displayed );
		_test = new Glitchmap( "C:/Users/Steve/Documents/Development/BitMash/Assets/test.jpg" );
		addChild( _test );
		//_test.addEventListener( Event.CHANGE, onChange );
		createLevel();
	}
	
	override public function update( ?e:Event ):Void {
		super.update(e);
		
		if ( _game != null ) {
			_game.update(e);
			//_displayed.update( _game );
		}
		
		if ( MashInput.space.pressed ) {
			if ( _game != null ) {
				_test.draw( _game );
			}
		}
	}
	
	private function createLevel():Void {
		_game = new MashGame();
		_game.visible = false;
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
}