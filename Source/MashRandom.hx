/*
 * Copyright (c) 2009 Michael Baczynski, http://www.polygonal.de
 *
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the
 * "Software"), to deal in the Software without restriction, including
 * without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 * LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

/**
 * Implementation of the Park Miller (1988) "minimal standard" linear 
 * congruential pseudo-random number generator.
 * 
 * For a full explanation visit: http://www.firstpr.com.au/dsp/rand31/
 * 
 * The generator uses a modulus constant (m) of 2^31 - 1 which is a
 * Mersenne Prime number and a full-period-multiplier of 16807.
 * Output is a 31 bit unsigned integer. The range of values output is
 * 1 to 2,147,483,646 (2^31-1) and the seed must be in this range too.
 * 
 * David G. Carta's optimisation which needs only 32 bit integer math,
 * and no division is actually *slower* in flash (both AS2 & AS3) so
 * it's better to use the double-precision floating point version.
 * 
 * @author Michael Baczynski, www.polygonal.de
 */

/**
 * Ported to Haxe for BITMASH/BITGLITCH by Steve Richey (STVR).
 */
package;

class MashRandom {
	/**
	 * Set the seed with an integer between 1 and 0X7FFFFFFE inclusive. Don't use 0!
	 */
	public static var seed:UInt = 1;
	
	private static inline var FULL_PERIOD_MULTIPLIER:UInt = 16807;
	private static inline var MODULUS_CONSTANT:UInt = 2147483647;
	private static inline var INT_SPACER:Float = 0.4999;
	
	/**
	 * Provides the next pseudorandom number as an integer.
	 */
	public static inline function int():UInt {
		return gen();
	}
	
	/**
	 * Provides the next pseudorandom number as a float between nearly 0 and nearly 1.0.
	 */
	public static inline function double():Float {
		return ( gen() / MODULUS_CONSTANT );
	}
	
	/**
	 * Provides the next pseudorandom number as an integer betweeen a given range.
	 */
	public static inline function intRanged( min:UInt, max:UInt ):UInt {
		return Math.round( doubleRanged( min - INT_SPACER, max + INT_SPACER ) );
	}
	
	/**
	 * Provides the next pseudorandom number as a float between a given range.
	 */
	public static inline function doubleRanged( min:Float, max:Float ):Float {
		return min + ( ( max - min ) * double() );
	}
	
	/**
	 * Internal method for pseudo-random number generation:
	 * new-value = (old-value * 16807) mod (2^31 - 1)
	 */
	private static inline function gen():UInt 	{
		return seed = ( seed * FULL_PERIOD_MULTIPLIER ) % MODULUS_CONSTANT;
	}
}