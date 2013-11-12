package;

import flash.display.DisplayObject;
import flash.Lib;
import flash.display.Sprite;
import flash.events.Event;

/**
 * This class is generally used for a master playstate-type class, as you can add() and remove() displayobjects.
 * 
 * @author Steve Richey
 */
class MashSprite extends Sprite {
	private var members:Array<DisplayObject>;
	private var ready:Bool;
	
	public function new() {
		super();
		
		if (stage != null) {
			init();
		} else {
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
	}
	
	private function init( ?e:Event ):Void {
		if ( hasEventListener( Event.ADDED_TO_STAGE ) ) {
			removeEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		members = [];
		ready = false;
		
		addEventListener( Event.ENTER_FRAME, update );
	}
	
	private function update( ?e:Event ):Void {
		
	}
	
	private function add( d:DisplayObject ):Void {
		members.push( d );
		addChild( d );
	}
	
	private function remove( d:DisplayObject ):Void {
		removeChild( d );
		members.remove( d );
		d = null;
	}
	
	private function destroy():Void {
		removeEventListener( Event.COMPLETE, update );
		
		var i:Int = members.length;
		
		while ( i >= 0 ) {
			removeChild( members[i] );
			members[i] = null;
			members.splice( i, 1 );
			i--;
		}
	}
	
	private inline function getWidth():Int {
		return Std.int( this.width );
	}
	
	private inline function getHeight():Int {
		return Std.int( this.height );
	}
	
	private function randomize( lo:Int, hi:Int, step:Int = 1 ):Int {
		return step * Std.int( Math.random() * ( ( hi / step ) - ( lo / step ) ) + ( lo / step ) );
	}
}