package;

class MashRect {
	public var x:Int;
	public var y:Int;
	public var width:Int;
	public var height:Int;
	
	public function new( X:Int, Y:Int, Width:Int, Height:Int ) {
		this.x = X;
		this.y = Y;
		this.width = Width;
		this.height = Height;
	}
	
	inline public function intersects( OtherRect:MashRect ):Bool {
		var doesIntersect:Bool = false;
		
		if ( gx < OtherRect.fx ) {
			if ( gy < OtherRect.fy ) {
				if ( fx > OtherRect.gx ) {
					if ( fy > OtherRect.gy ) {
						doesIntersect = true;
					}
				}
			}
		}
		
		return doesIntersect;
	}
	
	inline public function intersection( OtherRect:MashRect ):MashRect {
		var rx:Int = 0;
		var ry:Int = 0;
		var rw:Int = 0;
		var rh:Int = 0;
		
		if ( gx < OtherRect.gx ) {
			rx = OtherRect.gx;
		} else {
			rx = gx;
		}
		
		if ( fx < OtherRect.fx ) {
				rw = fx - rx;
			} else {
				rw = OtherRect.fx - rx;
			}
		
		if ( gy < OtherRect.gy ) {
			ry = OtherRect.gy;
		} else {
			ry = gy;
			rh = OtherRect.fy - ry;
		}
		
		if ( fy < OtherRect.fy ) {
			rh = fy - ry;
		} else {
			rh = OtherRect.fy - ry;
		}
		
		return new MashRect( rx, ry, rw, rh );
	}
	
	/**
	 * This object's x position, as an integer.
	 */
	public var gx(get, null):Int;
	
	private inline function get_gx():Int {
		return Std.int( this.x );
	}
	
	/**
	 * This object's y position, as an integer.
	 */
	public var gy(get, null):Int;
	
	private inline function get_gy():Int {
		return Std.int( this.y );
	}
	
	/**
	 * This object's width, as an integer.
	 */
	public var gw(get, null):Int;
	
	private inline function get_gw():Int {
		return Std.int( this.width );
	}
	
	/**
	 * This object's height, as an integer.
	 */
	public var gh(get, null):Int;
	
	private inline function get_gh():Int {
		return Std.int( this.height );
	}
	
	/**
	 * The x value at the horizontal middle of this object.
	 */
	public var mx(get, null):Int;
	
	private inline function get_mx():Int {
		return Std.int( this.x + this.width / 2 );
	}
	
	/**
	 * The y value at the vertical middle of this object.
	 */
	public var my(get, null):Int;
	
	private inline function get_my():Int {
		return Std.int( this.y + this.height / 2 );
	}
	
	/**
	 * The x value at the far right of this object.
	 */
	public var fx(get, null):Int;
	
	private inline function get_fx():Int {
		return Std.int( this.x + this.width );
	}
	
	/**
	 * The y value at the far bottom of this object.
	 */
	public var fy(get, null):Int;
	
	private inline function get_fy():Int {
		return Std.int( this.y + this.height );
	}
}