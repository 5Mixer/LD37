package tiles;

class StandardTile implements Tile {
	public var id:Int;
	public var name:String;
	public var collide:Bool;
	public var interiourTile:Bool = true;
	public var size = {width: 1, height: 1};
	public var pos:kha.math.Vector2i;

	static var tileInfo:Map<Int,Dynamic> = [
		1 => { name: "Wall", collide: false, id: 0},
		2 => { name: "Floor", collide: true, id: 1}
	];

	public function new (pos,id){
		this.pos = pos;
		setfromID(id);
	}
	public function setfromID (id){
		var info = StandardTile.tileInfo.get(id);
		this.id = info.id;
		name = info.name;
		collide = info.collide;
		interiourTile = true;
	}
	public function render(g:kha.graphics2.Graphics,x,y){
		var sourcePos = { x: (id)*8, y:0 };
		var destPos = { x: x*8, y: y*8 };

		//g.color = kha.Color.White;
		//g.font = kha.Assets.fonts.pixel;
		//g.fontSize = 8;
		
		g.drawScaledSubImage(kha.Assets.images.Tileset,sourcePos.x,sourcePos.y,8,8,destPos.x,destPos.y,8,8);
		//g.drawString(id+"",x*8,y*8);
	}
	public function renderInventoryItem (g:kha.graphics2.Graphics):Void {
		var sourcePos = { x: (id)*8, y:0 };
		
		g.drawSubImage(kha.Assets.images.Tileset,sourcePos.x,sourcePos.y,8,8,8,8);
	}
	public function update(delta,game,ship:Ship){

	}
}