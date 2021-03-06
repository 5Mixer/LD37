package ;

class Mouse {
	public var pos:kha.math.Vector2;
	public var leftButton = false;
	public var rightButton = false;
	public var wheel:Int = 0;
	public var leftUp = false;

	public var onWheelListeners = new Array<Int->Void>();
	public var leftDownListeners = new Array<Void->Void>();
	public var leftUpListeners = new Array<Void->Void>();

	public var justLeftClicked = false;
	
	public function new (){
		

		pos = new kha.math.Vector2();
		var mouse = kha.input.Mouse.get();
		mouse.notify(onDown, onUp, onMove, onWheel);
	}
	function onDown (buttonCode:Int, x:Int,y:Int){
		pos.x = x;
		pos.y = y;
		//trace('Button $buttonCode down');

		if (buttonCode == 0){
			leftButton = true;
			for (listener in leftDownListeners) listener();
		}

		if (buttonCode == 1)
			rightButton = true;
	}
	public function update (){
		justLeftClicked = false;
	}
	function onUp (buttonCode:Int,x:Int,y:Int){
		pos.x = x;
		pos.y = y;

		justLeftClicked = true;
		//trace('Button $buttonCode up');

		if (buttonCode == 0){
			leftButton = false;
			leftUp = true;
			for (listener in leftUpListeners) listener();
		}

		if (buttonCode == 1)
			rightButton = false;
	}

	function onMove(x:Int,y:Int,z:Int,a:Int){
		pos.x = x;
		pos.y = y;
	}
	function onWheel (amount:Int){
		//Wheel be pos/negative depending on direction
		wheel = amount;
		for (listener in onWheelListeners) listener(amount);
	}

	public function worldPos (camera:Camera){
		return camera.screenToWorld(pos);
	}
}