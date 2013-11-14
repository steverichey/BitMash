package;
import flash.display.BitmapData;
import flash.geom.Point;
import haxe.Log;

class MashTools {
	/**
	 * Collide any two MashBitmap objects. INCOMPLETE
	 * 
	 * @param	Object1
	 * @param	Object2
	 */
	inline static public function collide( Object1:MashBitmap, Object2:MashBitmap ):Void {
		var rect1:MashRect = new MashRect( Object1.gx, Object1.gy, Object1.gw, Object2.gh );
		var rect2:MashRect = new MashRect( Object2.gx, Object2.gy, Object2.gw, Object2.gh );
		
		if ( rect1.intersects( rect2 ) ) {
			var dist:Point = new Point(0, 0);
			
			if ( Object1.mx < Object2.mx ) {
				dist.x = rect2.gx - rect1.gx - rect1.width;
			} else {
				dist.x = rect1.gx - rect2.gx - rect1.width;
			}
			
			if ( Object1.my < Object2.my ) {
				dist.y = rect2.gy - rect1.gy - rect1.height;
			} else {
				dist.y = rect1.gy - rect2.gy - rect1.height;
			}
			Log.trace( "C 1 (" + rect1.gx + "," + rect1.gy + ") 2 (" + rect2.gx + "," + rect2.gy + ") D " + dist );
			if ( Object1.moves && !Object2.moves ) {
				Object1.x += dist.x;
				Object1.y += dist.y;
			} else if ( !Object1.moves && Object2.moves ) {
				Object2.x += dist.x;
				Object2.y += dist.y;
			} else if ( Object1.moves && Object2.moves ) {
				Object1.x += Std.int( dist.x / 2 );
				Object1.y += Std.int( dist.y / 2 );
				Object2.x += Std.int( dist.x / 2 );
				Object2.y += Std.int( dist.y / 2 );
			} else {
				// why are you colliding?!
			}
		}
	}
	
	/**
	 * Returns true if these MashBitmap objects overlap.
	 * 
	 * @param	Object1
	 * @param	Object2
	 */
	inline static public function overlap( Object1:MashBitmap, Object2:MashBitmap ):Bool {
		var rect1:MashRect = new MashRect( Object1.gx, Object1.gy, Object1.gw, Object2.gh );
		var rect2:MashRect = new MashRect( Object2.gx, Object2.gy, Object2.gw, Object2.gh );
		var overlaps:Bool = false;
		
		if ( rect1.intersects( rect2 ) ) {
			overlaps = true;
		}
		
		return overlaps;
	}
}