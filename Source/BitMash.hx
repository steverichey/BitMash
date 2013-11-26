package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.text.TextField;
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
	
	// seed test
	private var lkj:TextField;
	private var asdf:Bitmap;
	
	public function new() {
		super();
	}
	
	override private function init( ?e:Event ):Void {
		super.init( e );
		
		_input = new MashInput();
		lkj = new TextField();
		addChild( lkj );
		asdf = new Bitmap( new BitmapData( 50, 50, false, 0 ) );
		asdf.y = 40;
		addChild( asdf );
		/*
		//_displayed = new MashGlitch( this.getWidth(), this.getHeight() );
		//addChild( _displayed );
		_test = new Glitchmap( "C:/Users/Steve/Documents/Development/BitMash/Assets/test.jpg" );
		addChild( _test );
		//_test.addEventListener( Event.CHANGE, onChange );
		createLevel();*/
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
		
		if ( MashInput.up.pressed ) {
			lkj.text = Std.string( MashRandom.int() );
			asdf.bitmapData = new BitmapData( 50, 50, false, MashRandom.int() );
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