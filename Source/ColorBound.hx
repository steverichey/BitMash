package;

class ColorBound {
	public var min:Int = 0;
	public var max:Int = 255;
	
	public function new( Min:Int = 0, Max:Int = 255 ) {
		this.min = Min;
		this.max = Max;
	}
}