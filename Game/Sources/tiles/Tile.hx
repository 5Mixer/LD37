package tiles;

interface Tile {
	public var name:String;
	public var collide:Bool;
	public var size:{ width:Int, height:Int};
	public var pos:kha.math.Vector2i;

	public function render (g:kha.graphics2.Graphics,x:Int,y:Int):Void;
	public function renderInventoryItem (g:kha.graphics2.Graphics):Void;
	public function update (delta:Float,game:Game,ship:Ship):Void;
}