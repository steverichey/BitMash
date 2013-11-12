package;

import flash.display.BlendMode;
import flash.geom.Matrix;
import flash.geom.Transform;
import flash.Lib;
import flash.geom.Rectangle;
import flash.events.Event;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageQuality;
import flash.display.StageScaleMode;

class Main extends Sprite {
	static public function main():Void {	
		Lib.current.addChild( new Main() );
	}
	
	private var _game:MashSprite;
	
	public function new() {
		super();
		
		if (stage != null) {
			init();
		} else {
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
	}
	
	private function init(?E:Event):Void {
		if ( hasEventListener( Event.ADDED_TO_STAGE ) ) {
			removeEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		initialize();
		
		_game = new BitMash();
		_game.scaleX = 2.0;
		_game.scaleY = 2.0;
		addChild( _game );
		
		addEventListener( Event.ENTER_FRAME, update );
	}
	
	private function update( ?e:Event ) {
		/*var rand = Math.random();
		
		if ( rand < 0.1 ) {
			_game.blendMode = BlendMode.INVERT;
		} else if ( _game.blendMode != BlendMode.NORMAL ) {
			_game.blendMode = BlendMode.NORMAL;
		}
		
		if ( rand < 0.2 ) {
			_game.transform.matrix = new Matrix( 2, 0, Math.random() * 2 - 1, 2 );
			_game.x = ( Lib.current.stage.stageWidth - _game.width ) / 2;
		} else if ( _game.transform.matrix != new Matrix(2,0,0,2) ) {
			_game.transform.matrix = new Matrix(2,0,0,2);
		}
		*/
		_game.update( e );
	}
	
	private function initialize():Void {
		Lib.current.stage.align = StageAlign.TOP;
		Lib.current.stage.scaleMode = StageScaleMode.SHOW_ALL;
		
		// Allows hardware-accelerated fullscreen, which is smoother (but "fuzzy").
		
		#if flash
		Lib.current.stage.fullScreenSourceRect = new Rectangle( 0, 0, 800, 400 );
		#end
	}
}