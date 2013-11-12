package;

/**
 * Registry to store common items.
 * 
 * @author Steve Richey
 */
class MashLevels {
	public static var level:Int;
	
	public static inline function LEVEL_TEXT():Array<String> {
		return [	"input:up    left  down  right",
					"some messages are important" ];
	}
	
	public static inline function getText():String {
		var s:String = "";
		
		if ( level < LEVEL_TEXT().length ) {
			s = LEVEL_TEXT()[level];
		}
		
		return s;
	}
}