package;

import flash.events.Event;

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
		_input = new MashInput();
		createLevel();
	}
	
	override private function update( ?e:Event ):Void {
		super.update( e );
	}
	
	private function createLevel():Void {
		_game = new MashGame();
		add( _game );
		_game.addEventListener( Event.COMPLETE, levelEnd );
	}
	
	private function levelEnd( ?e:Event ):Void {
		_game.removeEventListener( Event.COMPLETE, levelEnd );
		remove( _game );
		MashLevels.level ++;
		createLevel();
	}
}