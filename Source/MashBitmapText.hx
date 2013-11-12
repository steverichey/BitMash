package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;

class MashBitmapText extends MashBitmap {
	private var _w:Int;
	private var _h:Int;
	private var _text:String;
	private var _cpl:Int;
	private var _size:Int;
	
	private static inline var TILE_SIZE:Int = 4;
	private static inline var STD_WIDTH:Int = 3;
	private static inline var STD_HEIGHT:Int = 5;
	private static inline var N_WIDTH:Int = 4;
	private static inline var M_WIDTH:Int = 5;
	private static inline var Q_WIDTH:Int = 4;
	private static inline var W_WIDTH:Int = 5;
	
	public function new( text:String, size:Int = 0, charsPerLine:Int = 0, pixelSize:Int = 1 ) {
		if ( text == "" ) {
			_text = randomText( 10 );
		} else {
			_text = text.toUpperCase();
		}
		
		if ( size > 0 ) {
			_size = size;
		} else {
			_size = TILE_SIZE;
		}
		
		if ( charsPerLine > 0 ) {
			_cpl = charsPerLine;
		}
		
		if ( pixelSize > 1 ) {
			_pixelSize = pixelSize;
		} else {
			_pixelSize = 1;
		}
		
		_w = predictWidth();
		_h = predictHeight();
		
		super( _w, _h, _pixelSize );
	}
	
	private inline function predictWidth():Int {
		var w:Int = 0;
		
		if ( _cpl > 0 ) {
			var longest:Int = 0;
			var i:Int = 0;
			
			while ( i < _text.length ) {
				var thisLine:String = _text.substr( i, _cpl );
				var length:Int = lineWidth( thisLine );
				
				if ( length > longest ) {
					longest = length;
				}
				
				i += _cpl;
			}
			
			w = longest;
		} else {
			w = lineWidth( _text );
		}
		
		return w;
	}
	
	private inline function predictHeight():Int {
		var h:Int = STD_HEIGHT;
		
		if ( _cpl > 0 ) {
			var numLines:Int = Math.ceil( _text.length / _cpl );
			h =  numLines * STD_HEIGHT;
		}
		
		return h * _size + ( h - 1 ) * Std.int( _size / 2 );
	}
	
	override private function generate( ?w:Int, ?h:Int ):BitmapData {
		var bd:BitmapData = new BitmapData( _w, _h, true, 0 );
		var posX:Int = 0;
		var posY:Int = 0;
		var charcount:Int = 0;
		
		for ( i in 0..._text.length ) {
			var c:String = _text.charAt(i);
			var b:BitmapData = createChar(c);
			bd.draw( b, new Matrix( 1, 0, 0, 1, posX, posY ) );
			posX += Std.int( b.width + Std.int( _size / 2 ) );
			
			if ( _cpl > 0 ) {
				charcount++;
				
				if ( charcount >= _cpl ) {
					charcount = 0;
					posX = 0;
					posY += Std.int( b.height + Std.int( _size / 2 ) );
				}
			}
			
		}
		
		return bd;
	}
	
	private inline function createChar( c:String ):BitmapData {
		var arr:Array<Int> = [];
		var w:Int = STD_WIDTH;
		
		switch ( c ) {
			case "A":
				arr = getArray( [ 7, 5, 7, 5, 5 ] );
			case "B":
				arr = getArray( [ 7, 5, 6, 5, 7 ] );
			case "C":
				arr = getArray( [ 7, 4, 4, 4, 7 ] );
			case "D":
				arr = getArray( [ 6, 5, 5, 5, 6 ] );
			case "E":
				arr = getArray( [ 7, 4, 6, 4, 7 ] );
			case "F":
				arr = getArray( [ 7, 4, 6, 4, 4 ] );
			case "G":
				arr = getArray( [ 7, 4, 4, 5, 7 ] );
			case "H":
				arr = getArray( [ 5, 5, 7, 5, 5 ] );
			case "I":
				arr = getArray( [ 7, 2, 2, 2, 7 ] );
			case "J":
				arr = getArray( [ 1, 1, 5, 5, 7 ] );
			case "K":
				arr = getArray( [ 5, 5, 6, 5, 5 ] );
			case "L":
				arr = getArray( [ 4, 4, 4, 4, 7 ] );
			case "M":
				arr = [ 1, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1 ];
				w = M_WIDTH;
			case "N":
				arr = [ 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1 ];
				w = N_WIDTH;
			case "O":
				arr = getArray( [ 7, 5, 5, 5, 7 ] );
			case "P":
				arr = getArray( [ 7, 5, 7, 4, 4 ] );
			case "Q":
				arr = [ 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1 ];
				w = Q_WIDTH;
			case "R":
				arr = getArray( [ 7, 5, 6, 5, 5 ] );
			case "S":
				arr = getArray( [ 7, 4, 7, 1, 7 ] );
			case "T":
				arr = getArray( [ 7, 2, 2, 2, 2 ] );
			case "U":
				arr = getArray( [ 5, 5, 5, 5, 7 ] );
			case "V":
				arr = getArray( [ 5, 5, 5, 5, 2 ] );
			case "W":
				arr = [ 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1 ];
				w = W_WIDTH;
			case "X":
				arr = getArray( [ 5, 5, 2, 5, 5 ] );
			case "Y":
				arr = getArray( [ 5, 5, 2, 2, 2 ] );
			case "Z":
				arr = getArray( [ 7, 1, 2, 4, 7 ] );
			case " ":
				arr = getArray( [ 0, 0, 0, 0, 0 ] );
			case "-":
				arr = getArray( [ 0, 0, 7, 0, 0 ] );
			case ":":
				arr = getArray( [ 0, 2, 0, 2, 0 ] );
		}
		
		var bd:BitmapData = new BitmapData( w * _size, STD_HEIGHT * _size, true, 0 );
		
		var posX:Int = 0;
		var posY:Int = 0;
		
		for ( i in arr ) {
			if ( i == 1 ) {
				bd.draw( new MashBitmap( _size, _size, _pixelSize ), new Matrix( 1, 0, 0, 1, posX, posY ) );
			}
			
			posX += _size;
			
			if ( posX >= ( _size * w ) ) {
				posX = 0;
				posY += _size;
			}
		}
		
		return bd;
	}
	
	private inline static function BINARY_ARRAY():Array<Array<Int>> {
		return [ [0, 0, 0], [0, 0, 1], [0, 1, 0], [0, 1, 1], [1, 0, 0], [1, 0, 1], [1, 1, 0], [1, 1, 1] ];
	}
	
	private inline function getArray( types:Array<Int> ):Array<Int> {
		var a:Array<Int> = [];
		
		for ( i in types ) {
			a = a.concat( BINARY_ARRAY()[i] );
		}
		
		return a;
	}
	
	private inline function lineWidth( s:String ):Int {
		var w:Int = 0;
		
		for ( i in 0...s.length ) {
			if ( s.charAt(i) == "M" ) {
				w += M_WIDTH;
			} else if ( s.charAt(i) == "N" ) {
				w += N_WIDTH;
			} else if ( s.charAt(i) == "Q" ) {
				w += Q_WIDTH;
			} else if ( s.charAt(i) == "W" ) {
				w += W_WIDTH;
			} else {
				w += STD_WIDTH;
			}
		}
		
		return w * _size + Std.int( s.length * _size / 2 );
	}
	
	private inline function randomText( len:Int ):String {
		var s:String = "";
		
		while ( s.length < len ) {
			s += randomLetter();
		}
		
		return s;
	}
	
	private inline static function LETTER_ARRAY():Array<String> {
		return [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", " " ];
	}
	
	private inline function randomLetter():String {
		return LETTER_ARRAY()[ randomInt( 0, LETTER_ARRAY().length ) ];
	}
}