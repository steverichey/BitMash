package;

import flash.Lib;
import flash.geom.Rectangle;
import flash.events.Event;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;

class Main extends Sprite
{
	static public function main():Void
	{	
		Lib.current.addChild( new Main() );
	}
	
	public function new() 
	{
		super();
		
		if (stage != null) {
			init();
		} else {
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
	}
	
	private function init(?E:Event):Void 
	{
		if ( hasEventListener( Event.ADDED_TO_STAGE ) ) {
			removeEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		initialize();
		
		var game:Sprite = new BitThrash();
		//game.width = Lib.current.stage.stageWidth;
		//game.height = Lib.current.stage.stageHeight;
		game.scaleX = 2.0;
		game.scaleY = 2.0;
		addChild( game );
	}
	
	private function initialize():Void 
	{
		Lib.current.stage.align = StageAlign.TOP;
		Lib.current.stage.scaleMode = StageScaleMode.SHOW_ALL;
		
		#if flash
		Lib.current.stage.fullScreenSourceRect = new Rectangle( 0, 0, 640, 480 );
		#end
	}
}