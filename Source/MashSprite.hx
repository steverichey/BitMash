package;

import flash.display.DisplayObject;
import flash.geom.Rectangle;
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
	}
	
	public function update( ?e:Event ):Void {
		
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
		var i:Int = members.length - 1;
		
		while ( i >= 0 ) {
			remove( members[i] );
			i--;
		}
	}
	
	public inline function getRectangle():Rectangle {
		return new Rectangle( this.x, this.y, this.width, this.height );
	}
	
	private inline function center( obj:DisplayObject ):Void {
		obj.x = Math.round( ( BitMash.getWidth() - obj.width ) / 2 );
	}
}