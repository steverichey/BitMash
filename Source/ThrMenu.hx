package;

import flash.events.Event;

class ThrMenu extends ThrSprite {
	private var _text:ThrBitmapText;
	private var _bg:ThrBitmap;
	
	public function new() {
		super();
	}
	
	override private function init( ?e:Event ):Void {
		super.init( e );
		
		_bg = new ThrBitmap( 600, 600, 4 );
		add( _bg );
		
		_text = new ThrBitmapText( "bit-thrash", 8, 0, 4 );
		_text.x = 4;
		_text.y = 4;
		add( _text );
		
		ready = true;
	}
	
	override private function update( ?e:Event ):Void {
		super.update( e );
		
		if ( ready ) {
			_bg.regenerate();
		}
	}
}