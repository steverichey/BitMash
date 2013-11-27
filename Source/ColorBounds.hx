package;

class ColorBounds {
	public var redBounds:ColorBound;
	public var greenBounds:ColorBound;
	public var blueBounds:ColorBound;
	
	public function new( ?Red:ColorBound, ?Green:ColorBound, ?Blue:ColorBound ) {
		if ( Red != null ) {
			redBounds = Red;
		} else {
			redBounds = new ColorBound();
		}
		
		if ( Green != null ) {
			greenBounds = Green;
		} else {
			greenBounds = new ColorBound();
		}
		
		if ( Blue != null ) {
			blueBounds = Blue;
		} else {
			blueBounds = new ColorBound();
		}
	}
}