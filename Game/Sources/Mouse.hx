package ;

class Mouse {
	public var pos:kha.math.Vector2;
	public var leftButton = false;
	public var rightButton = false;
	public function new (){
		

		pos = new kha.math.Vector2();
		var mouse = kha.input.Mouse.get();
		mouse.notify(onDown, onUp, onMove, onWheel);
	}
	function onDown (buttonCode:Int, x:Int,y:Int){
		pos.x = x;
		pos.y = y;
		//trace('Button $buttonCode down');

		if (buttonCode == 0)
			leftButton = true;

		if (buttonCode == 1)
			rightButton = true;
	}
	function onUp (buttonCode:Int,x:Int,y:Int){
		pos.x = x;
		pos.y = y;
		//trace('Button $buttonCode up');

		if (buttonCode == 0)
			leftButton = false;

		if (buttonCode == 1)
			rightButton = false;
	}
	function onMove(x:Int,y:Int,z:Int,a:Int){
		pos.x = x;
		pos.y = y;
	}
	function onWheel (amount:Int){
		//Wheel be pos/negative depending on direction
	}

	public function worldPos (camera:Camera){
		return camera.screenToWorld(pos);
	}
}