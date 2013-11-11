package;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Matrix;

class ThrBitmapText extends Bitmap {
	private static inline var TILE_SIZE:Int = 4;
	private static inline var STD_WIDTH:Int = 3;
	private static inline var STD_HEIGHT:Int = 5;
	private static inline var N_WIDTH:Int = 5;
	private static inline var M_WIDTH:Int = 5;
	private static inline var Q_WIDTH:Int = 4;
	private static inline var W_WIDTH:Int = 5;
	
	public function new( text:String, size:Int = 0, charsPerLine:Int = 0, pixelSize:Int = 1 ) {
		super( generateBitmapData( text, size, charsPerLine, pixelSize ) );
	}
	
	private inline function generateBitmapData( t:String, s:Int = 0, charsPerLine:Int = 0, pixelSize:Int = 1 ) {
		t = t.toUpperCase();
		var w:Int = 0;
		var ts:Int = TILE_SIZE;
		
		if ( s != 0 ) {
			ts = s;
		}
		
		for ( i in 0...t.length ) {
			if ( t.charAt(i) == "M" ) {
				w += M_WIDTH;
			} else if ( t.charAt(i) == "N" ) {
				w += N_WIDTH;
			} else {
				w += STD_WIDTH;
			}
		}
		
		var h:Int = STD_HEIGHT;
		
		if ( charsPerLine != 0 ) {
			h = Math.ceil( t.length / charsPerLine ) * STD_HEIGHT;
		}
		
		var bd:BitmapData = new BitmapData( w * ts + ( t.length - 1 ) * ts, h * ts + ( h - 1 ) * Std.int( ts / 2 ), true, 0 );
		var posX:Int = 0;
		var posY:Int = 0;
		var charcount:Int = 0;
		
		for ( i in 0...t.length ) {
			var c:String = t.charAt(i);
			var b:BitmapData = createChar(c,s,pixelSize);
			bd.draw( b, new Matrix( 1, 0, 0, 1, posX, posY ) );
			posX += Std.int( b.width + Std.int( ts / 2 ) );
			
			if ( charsPerLine != 0 ) {
				charcount++;
				
				if ( charcount >= charsPerLine ) {
					charcount = 0;
					posX = 0;
					posY += Std.int( b.height + Std.int( ts / 2 ) );
				}
			}
			
		}
		
		return bd;
	}
	
	private inline function createChar( c:String, s:Int = 0, p:Int = 1 ):BitmapData {
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
				arr = getArray( [ 5, 5, 5, 5, 7 ] );
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
		}
		
		var ts:Int = TILE_SIZE;
		
		if ( s != 0 ) {
			ts = s;
		}
		
		var bd:BitmapData = new BitmapData( w * ts, STD_HEIGHT * ts, true, 0 );
		
		var posX:Int = 0;
		var posY:Int = 0;
		
		for ( i in arr ) {
			if ( i == 1 ) {
				haxe.Log.trace( "TS: " + ts + ", P: " + p );
				bd.draw( new ThrBitmap( ts, ts, p ), new Matrix( 1, 0, 0, 1, posX, posY ) );
			}
			
			posX += ts;
			
			if ( posX >= ( ts * w ) ) {
				posX = 0;
				posY += ts;
			}
		}
		
		return bd;
	}
	
	private inline function getArray( types:Array<Int> ):Array<Int> {
		var a:Array<Int> = [];
		var b:Array<Array<Int>> = [	[0, 0, 0],
									[0, 0, 1],
									[0, 1, 0],
									[0, 1, 1],
									[1, 0, 0],
									[1, 0, 1],
									[1, 1, 0],
									[1, 1, 1] ];
		
		for ( i in types ) {
			a = a.concat( b[i] );
		}
		
		return a;
	}
}