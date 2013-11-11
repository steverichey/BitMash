package;

import flash.events.Event;

class BitThrash extends ThrSprite {
	private var _menu:ThrMenu;
	private var _game:ThrGame;
	private var _input:ThrInput;
	
	public function new() {
		super();
	}
	
	override private function init( ?e:Event ):Void {
		super.init( e );
		
		_input = new ThrInput();
		
		_menu = new ThrMenu();
		add( _menu );
		_menu.addEventListener( Event.COMPLETE, onEndMenu );
	}
	
	override private function update( ?e:Event ):Void {
		super.update( e );
	}
	
	private function onEndMenu( ?e:Event ):Void {
		_menu.removeEventListener( Event.COMPLETE, onEndMenu );
		remove( _menu );
		
		//_game = new ThrGame();
		//add( ThrGame );
	}
}