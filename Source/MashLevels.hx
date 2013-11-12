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
					"touch boxes to advance",
					"some messages are important",
					"but most are not take this one for example",
					"from here on all messages are random"
					];
	}
	
	public static inline function getText():String {
		var s:String = "";
		
		if ( level < LEVEL_TEXT().length ) {
			s = LEVEL_TEXT()[level];
		}
		
		return s;
	}
}