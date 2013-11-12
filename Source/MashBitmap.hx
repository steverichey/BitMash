package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.geom.Matrix;
import flash.events.TimerEvent;
import flash.utils.Timer;

class MashBitmap extends Bitmap {
	private var _pixelSize:Int;
	private var _regenTimer:Timer;
	
	public function new( Width:Int, Height:Int, PixelSize:Int = 1 ) {
		_pixelSize = PixelSize;
		super( generate( Width, Height ), PixelSnapping.ALWAYS, false );
	}
	
	public function setInterval( desired:Int ):Void {
		if ( _regenTimer != null ) {
			unsetInterval();
		}
		
		_regenTimer = new Timer( desired );
		_regenTimer.addEventListener( TimerEvent.TIMER, regenerate );
		_regenTimer.start();
	}
	
	public function unsetInterval():Void
	{
		if ( _regenTimer != null ) {
			_regenTimer.stop();
			_regenTimer.removeEventListener( TimerEvent.TIMER, regenerate );
			_regenTimer = null;
		}
	}
	
	public inline function regenerate( ?t:TimerEvent ):Void {
		this.bitmapData = generate();
	}
	
	public var gx(get, null):Int;
	
	private inline function get_gx():Int {
		return Std.int( this.x );
	}
	
	public var gy(get, null):Int;
	
	private inline function get_gy():Int {
		return Std.int( this.y );
	}
	
	public var gw(get, null):Int;
	
	private inline function get_gw():Int {
		return Std.int( this.width );
	}
	
	public var gh(get, null):Int;
	
	private inline function get_gh():Int {
		return Std.int( this.height );
	}
	
	public var mx(get, null):Int;
	
	private inline function get_mx():Int {
		return Std.int( this.x + this.width / 2 );
	}
	
	public var my(get, null):Int;
	
	private inline function get_my():Int {
		return Std.int( this.y + this.height / 2 );
	}
	
	public var fx(get, null):Int;
	
	private inline function get_fx():Int {
		return Std.int( this.x + this.width );
	}
	
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
	
	private function randomInt( lo:Int, hi:Int, step:Int = 1 ):Int {
		return step * Std.int( Math.random() * ( ( hi / step ) - ( lo / step ) ) + ( lo / step ) );
	}
}