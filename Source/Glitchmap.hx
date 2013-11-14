package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.FileFilter;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.ByteArray;

/**
 * http://blog.soulwire.co.uk/laboratory/flash/as3-bitmapdata-glitch-generator
	 * 
	 * proper attribution to come later computer dying tho
 */
class Glitchmap extends Sprite {
	private static inline var NULL_BYTE:Int = 0;
	private static inline var MAX_ITERATIONS:Int = 417;
	private static inline var MAX_GLITCHINESS:Float = 1.0;
	private static inline var MAX_SEED:Int = 1000;
	private static inline var HEADER_SIZE:Int = 417;
	
	private var _bytesSource:ByteArray;
	private var _bytesGlitch:ByteArray;
	
	private var _imageLoader:URLLoader;
	private var _bytesLoader:Loader;
	
	private var _output:Bitmap;
	
	private var _seed:Float;
	private var _maxIterations:Int;
	private var _glitchiness:Float;
	private var _lastPosition:Int;
	
	public function new( path:String ) {
		super();
		_bytesGlitch = new ByteArray();
		_bytesLoader = new Loader();
		_seed = 1.0;
		_maxIterations = 417;
		_glitchiness = 0.5;
		
		_imageLoader = new URLLoader();
		_imageLoader.addEventListener( IOErrorEvent.IO_ERROR, onLoadIOError );
		_imageLoader.addEventListener( ProgressEvent.PROGRESS, onLoadProgress );
		_imageLoader.addEventListener( Event.COMPLETE, onLoadComplete );
		_imageLoader.dataFormat = URLLoaderDataFormat.BINARY;
		_imageLoader.load( new URLRequest( path ) );
	}
	
	private function onLoadIOError( e:IOErrorEvent ):Void {
		trace("Error");
		dispatchEvent( e );
	}
	
	private function onLoadProgress( e:ProgressEvent ):Void {
		dispatchEvent( e );
	}
	
	private function onLoadComplete( e:Event ):Void {
		_imageLoader.removeEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
		_imageLoader.removeEventListener(ProgressEvent.PROGRESS, onLoadProgress);
		_imageLoader.removeEventListener(Event.COMPLETE, onLoadComplete);
		
		_bytesSource = cast( _imageLoader.data, ByteArray );
		
		dispatchEvent( e );
		
		//draw();
	}
	
	public function draw( Source:MashSprite ):Void {
		if ( _bytesSource == null ) {
			return;
		}
		
		var dataToGlitch:BitmapData = new BitmapData( Source.getWidth(), Source.getHeight(), false );
		dataToGlitch.draw( Source );
		_bytesSource.position = 0;
		_bytesSource = dataToGlitch.encode( Source.getRectangle(),  );
		
		// save to file:
		//var f = neko.io.File.write('test.png', true);
		//f.writeString(byteArray.asString());
		//f.close(); 
		
		_seed = Std.int( Math.random() * MAX_SEED );
		
		_bytesLoader.unload();
		_bytesSource.position = 0;
		
		_bytesGlitch.length = 0;
		_bytesGlitch.writeBytes( _bytesSource, 0, _bytesSource.bytesAvailable );
		
		if( _glitchiness > 0.0 ) {
			var length:Int = _bytesGlitch.length - HEADER_SIZE - 2;
			var amount:Int = Std.int( _glitchiness * _maxIterations );
			var random:Float = _seed;
			
			for ( i in 0...1 ) {
				random = ( random * 16807 ) % 2147483647;
				
				_bytesGlitch.position = HEADER_SIZE + Std.int( length * random * 4.656612875245797e-10 );
				_lastPosition = _bytesGlitch.position;
				_bytesGlitch.writeByte( NULL_BYTE );
			}
		}
		
		_bytesLoader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onBytesLoadError );
		_bytesLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, onBytesLoaded );
		_bytesLoader.loadBytes( _bytesGlitch );
	}
	
	private function onBytesLoadError( e:IOErrorEvent ):Void {
		trace( "Error loading bytes: " + _lastPosition );
	}

	private function onBytesLoaded( e:Event ):Void {
		if( _output == null ) {
			_output = cast( _bytesLoader.content, Bitmap );
			addChild( _output );
		} else {
			//_output.bitmapData.dispose();
			_output.bitmapData.draw( cast( _bytesLoader.content, Bitmap ) );
		}
		
		_bytesLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onBytesLoadError);
		_bytesLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onBytesLoadError);
		dispatchEvent( new Event( Event.CHANGE ) );
	}
}