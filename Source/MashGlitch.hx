package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.PixelSnapping;
import flash.display.Sprite;
import flash.events.Event;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import haxe.io.Input;
import haxe.io.Output;
import haxe.macro.Format;

// see
// http://blog.soulwire.co.uk/laboratory/flash/as3-bitmapdata-glitch-generator
// https://github.com/Hugosslade/smackmyglitchupjs
// https://github.com/snorpey/jpg-glitch
class MashGlitch extends Bitmap {
	/*private var _image:BitmapData;
	private var _source:ByteArray;
	
	public function new( Width:Int, Height:Int ) {
		_image = new BitmapData( Width, Height, false, 0xff00FF00 );
		_source = new ByteArray();
		super( _image, PixelSnapping.ALWAYS, false );
	}
	
	public function update( Source:Sprite ):Void {
		_image.dispose();
		_image.draw( Source );
		_source.position = 0;
		//var f:File = File.write( "bib.png", true );
		//new Writer( f ).write( getpng() );
		//f.close();
		
		//_source.position = 0;
		//_image.setPixels( _image.rect, _source );
		bitmapData = _image;
	}
	
	public function getpng():Data {
		var bo = new haxe.io.BytesOutput();
		for ( pixel in pixels ) {
			for ( channel in pixel ) {
				bo.writeByte(channel);
			}
		}
		var bytes = bo.getBytes();
		return bytes;
	}*/
}