package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.geom.Matrix;
import flash.events.TimerEvent;
import flash.utils.Timer;

/**
 * This is the cornerstone of BitMash; it creates a randomly-colored rectangle of the specified size.
 * 
 * @author Steve Richey
 */
class MashBitmap extends Bitmap {
	private var _pixelSize:Int;
	private var _regenTimer:Timer;
	private var _rect:MashRect;
	
	/**
	 * Create a shape of dimensions Width and Height with every PixelSize pixels colored the same.
	 * 
	 * @param	Width
	 * @param	Height
	 * @param	PixelSize
	 */
	public function new( Width:Int, Height:Int, PixelSize:Int = 1 ) {
		_pixelSize = PixelSize;
		super( generate( Width, Height ), PixelSnapping.ALWAYS, false );
	}
	
	/**
	 * Randomly re-color this MashBitmap every desired milliseconds.
	 * 
	 * @param	desired
	 */
	public function setInterval( desired:Int ):Void {
		if ( _regenTimer != null ) {
			unsetInterval();
		}
		
		_regenTimer = new Timer( desired );
		_regenTimer.addEventListener( TimerEvent.TIMER, regenerate );
		_regenTimer.start();
	}
	
	/**
	 * Stop randomly recoloring this item.
	 */
	public function unsetInterval():Void
	{
		if ( _regenTimer != null ) {
			_regenTimer.stop();
			_regenTimer.removeEventListener( TimerEvent.TIMER, regenerate );
			_regenTimer = null;
		}
	}
	
	private inline function regenerate( ?t:TimerEvent ):Void {
		this.bitmapData = generate();
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
	
	private function generate( ?w:Int, ?h:Int ):BitmapData {
		var temp:BitmapData;
		
		if ( w != null ) {
			temp = new BitmapData( Math.round( w / _pixelSize ), Math.round( h / _pixelSize ), false, 0xff000000 );
		} else {
			temp = new BitmapData( Std.int( gw / _pixelSize ), Std.int( gh / _pixelSize ), false, 0xff000000 );
		}
		
		for ( X in 0...temp.width ) {
			for ( Y in 0...temp.height ) {
				temp.setPixel( X, Y, randomColor() );
			}
		}
		
		if ( _pixelSize > 1 ) {
			var bacon:BitmapData = new BitmapData( Std.int( temp.width * _pixelSize ), Std.int( temp.height * _pixelSize ), false, 0xff000000 );
			bacon.draw( temp, new Matrix( _pixelSize, 0, 0, _pixelSize ) );
			temp = bacon;
		}
		
		return temp;
	}
	
	private inline function randomColor():UInt {
		return Std.int( Math.random() * ( 0xffFFFFFF - 0xff000000 ) );
	}
	
	private inline function randomInt( lo:Int, hi:Int, step:Int = 1 ):Int {
		return step * Std.int( Math.random() * ( ( hi / step ) - ( lo / step ) ) + ( lo / step ) );
	}
}