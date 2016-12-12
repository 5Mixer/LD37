package tiles;

//This is an odd class.
//It represents space 'under neath' tiles that are larger than 1x1
//It doesn't make sense to render anything here, as that is the job of the larger tile.
//Instead, this just allows access to the larger tile indirectly.

class OccupiedSpaceTile implements Tile {
	public var name:String = "Occupied Space";
	public var collide:Bool = false;
	public var size = {width: 1, height: 1};
	public var largerTile:Tile;
	public var relativePosition:kha.math.Vector2i;
	public var pos:kha.math.Vector2i;

	public function new (pos,largerTile,relativePosition){
		this.pos = pos;
		this.largerTile = largerTile;
		this.relativePosition = relativePosition;
	}

	public function render (g:kha.graphics2.Graphics,x:Int,y:Int):Void{

	}
	public function renderInventoryItem (g:kha.graphics2.Graphics):Void {
		g.color = kha.Color.Pink;
		g.drawRect(0,0,size.width*8,size.height*8);
	}
	public function update (delta:Float,game:Game,ship:Ship):Void{

	}
}