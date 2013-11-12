package;

class MashButton {
	private var _pressed:Bool;
	private var _justPressed:Bool;
	private var _justReleased:Bool;
	
	public function new() {
		_pressed = false;
		_justPressed = false;
		_justReleased = false;
	}
	
	public var pressed(get, set):Bool;
	
	private function get_pressed():Bool {
		return _pressed;
	}
	
	private function set_pressed( p:Bool ):Bool {
		_pressed = p;
		_justPressed = p;
		return _pressed;
	}
	
	public var justPressed(get, set):Bool;
	
	private function get_justPressed():Bool {
		return _justPressed;
	}
	
	private function set_justPressed( p:Bool ):Bool {
		_justPressed = p;
		
		return _justPressed;
	}
	
	public var justReleased(get, set):Bool;
	
	private function get_justReleased():Bool {
		return _justReleased;
	}
	
	private function set_justReleased( p:Bool ):Bool {
		_justReleased = p;
		
		return _justReleased;
	}
}