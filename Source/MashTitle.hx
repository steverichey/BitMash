package;
import flash.events.Event;

class MashTitle extends MashSprite {
	private var _title:MashBitmapText;
	private var _start:MashBitmapText;
	private var _time:Int;
	
	private static inline var TITLE:String = "BITMASH";
	private static inline var START:String = "PRESS SPACE TO START";
	
	public function new() {
		super();
	}
	
	override public function init( ?e:Event ):Void {
		super.init(e);
		
		_title = new MashBitmapText( TITLE, 16, TITLE.length, 4 );
		center( _title );
		_start = new MashBitmapText( START, 8, START.length, 4 );
		_start.y = 100;
		_time = 1;
		
		add( _title );
		add( _start );
		
		ready = true;
	}
	
	override public function update( ?e:Event ):Void {
		super.update(e);
		
		_time ++;
		
		if ( _time > MashRandom.MODULUS ) {
			_time = 1;
		}
	}
	
	public function getTime():Int {
		return _time;
	}
}