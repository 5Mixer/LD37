package;

import kha.Key;

class Keyboard {
	public var left: Bool;
	public var right: Bool;
	public var up: Bool;
	public var down: Bool;
	public var onEscapeUp:Void->Void;

	public function new() {
		kha.input.Keyboard.get().notify(keyDown,keyUp);
	}
	public function update ()
	{
	}
	public function keyDown(char:Key,letter) {
		trace(char+"down");

		if (char == LEFT || letter == "D")
			left = true;

		if (char == RIGHT || letter == "D")
			right = true;

		if (char == UP || letter == "W")
			up = true;

		if (char == DOWN || letter == "S")
			down = true;
	}

	public function keyUp(char: Key,letter) {
		trace(char+"up");
		switch (char) {
			case LEFT:
				left = false;
			case RIGHT:
				right = false;
			case UP:
				up = false;
			case DOWN:
				down = false;
			case ENTER:
				if (onEscapeUp != null){
					onEscapeUp();
					trace("Escape");
				} 
			default:
		}
	}
}
