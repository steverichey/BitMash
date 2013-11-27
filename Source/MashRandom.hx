package;

/**
 * Created for BitMash. References include:
	 * http://lab.polygonal.de/?p=162
	 * http://en.wikipedia.org/wiki/Park%E2%80%93Miller_random_number_generator
	 * http://lab.polygonal.de/?p=162
	 * http://www.cs.ucr.edu/~ciardo/teaching/CS177/section2.1.pdf
 * 
 * @author Steve Richey (STVR)
 */

class MashRandom {
	/**
	 * Set the seed with an integer between 1 and 0X7FFFFFFE inclusive. Don't use 0!
	 */
	public static var seed:UInt = 1;
	
	/**
	 * Constants.
	 */
	private static inline var MULTIPLIER:UInt = 75;
	public static inline var MODULUS:UInt = 65537;
	private static inline var POSSIBLE_CHARACTERS:String = " ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
	
	// These should work, but they keep giving negative numbers. Not sure what's wrong.
	//private static inline var MULTIPLIER:UInt = 16807;
	//private static inline var MODULUS:UInt = 2147483647;
	
	/**
	 * Provides the next pseudorandom number as an integer from 0 to 65535.
	 */
	public static inline function int():UInt {
		return gen() - 1;
	}
	
	/**
	 * Provides the next pseudorandom number as a float between 0 and 1.
	 */
	public static inline function float():Float {
		return ( gen() / ( MODULUS - 1 ) );
	}
	
	/**
	 * Provides the next pseudorandom number as a boolean value with controllable weight.
	 * 
	 * @param	Weight	The percentage chance that a true value will be returned.
	 * @return	A boolean value, either true or false.
	 */
	public static inline function bool( Weight:Float = 0.5 ):Bool {
		return ( int() < Weight * ( MODULUS - 1 ) ) ? true : false;
	}
	
	/**
	 * Provides the next pseudorandom number as a single-character string.
	 * 
	 * @return	A randomly generated character.
	 */
	public static inline function char():String {
		return POSSIBLE_CHARACTERS.charAt( intRanged( 0, POSSIBLE_CHARACTERS.length ) );
	}
	
	public static inline function color( ?ColBounds:ColorBounds ):UInt {
		var r:UInt = 0;
		var g:UInt = 0;
		var b:UInt = 0;
		
		if ( ColBounds != null ) {
			r = intRanged( ColBounds.redBounds.min, ColBounds.redBounds.max ) << 16;
			g = intRanged( ColBounds.greenBounds.min, ColBounds.greenBounds.max ) << 8;
			b = intRanged( ColBounds.blueBounds.min, ColBounds.blueBounds.max );
		} else {
			r = intRanged( 0, 255 ) << 16;
			g = intRanged( 0, 255 ) << 8;
			b = intRanged( 0, 255 );
		}
		
		return r + g + b;
	}
	
	/**
	 * Provides the next pseudorandom number as an integer betweeen a given range.
	 */
	public static inline function intRanged( min:UInt, max:UInt ):UInt {
		return Math.round( floatRanged( min, max ) );
	}
	
	/**
	 * Provides the next pseudorandom number as a float between a given range.
	 */
	public static inline function floatRanged( min:Float, max:Float ):Float {
		return float() * ( max - min ) + min;
	}
	
	/**
	 * The actual pseudorandom number generation code. Based on the Lehmer random number generator.
	 * Will generate a value from 1 to MODULUS - 1, inclusive.
	 */
	private static inline function gen():UInt {
		return seed = ( seed * MULTIPLIER ) % MODULUS;
	}
}