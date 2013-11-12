package;
import flash.display.BitmapData;

class MashTools {
	/**
	 * Collide any two MashBitmap objects.
	 * 
	 * @param	Object1
	 * @param	Object2
	 */
	inline static public function collide( Object1:MashBitmap, Object2:MashBitmap ):Void {
		var rect1:MashRect = new MashRect( Object1.gx, Object1.gy, Object1.gw, Object2.gh );
		var rect2:MashRect = new MashRect( Object2.gx, Object2.gy, Object2.gw, Object2.gh );
		
		if ( !rect1.intersects( rect2 ) ) {
			return;
		}
		
		var overlapRect:MashRect = rect1.intersection( rect2 );
		//var bitmapA:BitmapData = Object1.bitmapData.
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