package;

import flash.events.Event;

class BitMash extends MashSprite {
	private var _menu:MashMenu;
	private var _game:MashGame;
	private var _input:MashInput;
	
	public function new() {
		super();
	}
	
	override private function init( ?e:Event ):Void {
		super.init( e );
		
		_input = new MashInput();
		
		_menu = new MashMenu();
		add( _menu );
		_menu.addEventListener( Event.COMPLETE, onEndMenu );
	}
	
	override private function update( ?e:Event ):Void {
		super.update( e );
	}
	
	private function onEndMenu( ?e:Event ):Void {
		_menu.removeEventListener( Event.COMPLETE, onEndMenu );
		remove( _menu );
		
		//_game = new MashGame();
		//add( _game );
	}
}