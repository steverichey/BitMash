package;

import flash.display.BitmapData;
import flash.geom.Matrix;

/**
 * A tiled map class; pass in an array, and it generates a level made of MashBitmaps.
 * 
 * @author Steve Richey
 */
class MashTiles extends MashBitmap {
	private var _array:Array<Int>;
	private var _width:Int;
	private var _tileSize:Int;
	
	public function new( TileArray:Array<Int>, Width:Int, TileSize:Int = 4, PixelSize:Int = 1 ) {
		_array = TileArray;
		_width = Width;
		_tileSize = TileSize;
		_pixelSize =  PixelSize;
		
		super( 1, 1, 1 );
	}
	
	override private function generate( ?w:Int, ?h:Int ):BitmapData {
		var bd:BitmapData = new BitmapData( _width * _tileSize, Std.int( _array.length / _width ) * _tileSize, true, 0 );
		
		var current:Int = 0;
		var posX:Int = 0;
		var posY:Int = 0;
		
		while ( posY < bd.height ) {
			while ( posX < bd.width ) {
				if ( _array[ current ] == 1 ) {
					bd.draw( new MashBitmap( _tileSize, _tileSize, _pixelSize ), new Matrix( 1, 0, 0, 1, posX, posY ) );
				}
				
				posX += _tileSize;
			}
			posX = 0;
			posY += _tileSize;
		}
		
		return bd;
	}
}