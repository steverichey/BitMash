package;

import flash.display.Sprite;
import flash.events.Event;

/**
 * Minimalist preloader, based on NMEPreloader and BunPreloader (from OpenGNOP).
 * 
 * @author Steve Richey
 */
class MashPreloader extends Sprite {
	private var _progress:Sprite;
	private static inline var BAR_WIDTH:Int = 600;
	private static inline var BAR_HEIGHT:Int = 80;
	private static inline var BAR_X:Int = 100;
	private static inline var BAR_Y:Int = 160;
	private static inline var BORDER_THICKNESS:Int = 4;
	private static inline var COLOR_BORDER:Int = 0xff32EC04;
	private static inline var COLOR_PROGRESS_BG:Int = 0xffF10B07;
	private static inline var COLOR_PROGRESS:Int = 0xff5604ED;
	
	public function new() {
		super();
		if ( stage != null ) {
			onInit();
		} else {
			addEventListener( Event.ADDED_TO_STAGE, onInit );
		}
	}
	
	public function onInit( ?e:Event ):Void {
		var outer:Sprite = drawRect( BAR_WIDTH, BAR_HEIGHT, COLOR_BORDER );
		var inner:Sprite = drawRect( BAR_WIDTH - 2 * BORDER_THICKNESS, BAR_HEIGHT - 2 * BORDER_THICKNESS, COLOR_PROGRESS_BG );
		_progress = drawRect( Std.int( inner.width ), Std.int( inner.height ), COLOR_PROGRESS );
		outer.x = BAR_X;
		outer.y = BAR_Y;
		inner.x = outer.x + BORDER_THICKNESS;
		inner.y = outer.y + BORDER_THICKNESS;
		_progress.x = inner.x;
		_progress.y = inner.y;
		_progress.scaleX = 0;
		addChild( outer );
		addChild( inner );
		addChild( _progress );
	}
	
	public function onLoaded():Void {
		dispatchEvent ( new Event ( Event.COMPLETE ) );
	}
	
	public function onUpdate( bytesLoaded:Int, bytesTotal:Int ):Void {
		_progress.scaleX = bytesLoaded / bytesTotal;
	}
	
	private function drawRect( Width:Int, Height:Int, Color:Int ):Sprite {
		var s:Sprite = new Sprite();
		s.graphics.beginFill( Color );
		s.graphics.drawRect( 0, 0, Width, Height );
		s.graphics.endFill();
		return s;
	}
}