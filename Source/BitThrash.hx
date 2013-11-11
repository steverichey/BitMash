package;

import flash.events.Event;

class BitThrash extends ThrSprite {
	
	private var _menu:ThrMenu;
	private var _game:ThrGame;
	
	public function new() {
		super();
	}
	
	override private function init( ?e:Event ):Void {
		_menu = new ThrMenu();
		addChild( _menu );
		_menu.addEventListener( Event.COMPLETE, onEndMenu );
		
		super.init( e );
	}
	
	override private function update( ?e:Event ):Void {
		super.update( e );
	}
	
	private function onEndMenu( ?e:Event ):Void {
		_menu.removeEventListener( Event.COMPLETE, onEndMenu );
		removeChild( _menu );
		_menu.destroy();
		_menu = null;
		
		_game = new ThrGame();
		//addChild( ThrGame );
	}
}