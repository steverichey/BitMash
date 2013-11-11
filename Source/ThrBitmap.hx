package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.PixelSnapping;
import flash.geom.Matrix;

class ThrBitmap extends Bitmap {
	private var _pixelSize:Int;
	
	public function new( Width:Int, Height:Int, PixelSize:Int = 1 ) {
		_pixelSize = PixelSize;
		super( generate( Width, Height ), PixelSnapping.ALWAYS, false );
	}
	
	public inline function regenerate():Void {
		this.bitmapData = generate();
	}
	
	private inline function generate( ?w:Int, ?h:Int ):BitmapData {
		var temp:BitmapData;
		
		if ( w != null ) {
			temp = new BitmapData( Std.int( w / _pixelSize ), Std.int( h / _pixelSize ), false, 0xff000000 );
		} else {
			temp = new BitmapData( getWidth(), getHeight(), false, 0xff000000 );
		}
		
		for ( X in 0...temp.width ) {
			for ( Y in 0...temp.height ) {
				temp.setPixel( X, Y, randomColor() );
			}
		}
		
		if ( _pixelSize > 1 ) {
			var bacon:BitmapData = new BitmapData( Std.int( temp.width * _pixelSize ), Std.int( temp.height * _pixelSize ), false, 0xff000000 );
			bacon.draw( temp, new Matrix( 2, 0, 0, 2 ) );
			temp = bacon;
		}
		
		return temp;
	}
	
	private inline function randomColor():UInt {
		return Std.int( Math.random() * ( 0xffFFFFFF - 0xff000000 ) );
	}
	
	private inline function getWidth():Int {
		return Std.int( this.width / _pixelSize );
	}
	
	private inline function getHeight():Int {
		return Std.int( this.height / _pixelSize );
	}
}