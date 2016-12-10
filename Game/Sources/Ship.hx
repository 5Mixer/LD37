package ;

//Perhaps this should be loaded from a file.
typedef Tile = {
	var name:String;
	var collide:Bool;
	@:optional var oncollide:Void -> Void;
	var id:Int;
}

class Ship {
	var tileColours = [

	];
	public var tileInfo:Map<Int,Tile> = [
		1 => { name: "Wall", collide: false, id: 1},
		2 => { name: "Floor", collide: true, id: 2}
	];
	var tiles = new Array<Int>();

	var width:Int;
	var height:Int;

	public function new () {

		var data = haxe.xml.Parser.parse(kha.Assets.blobs.level1_tmx.toString());
		var map = data.elementsNamed("map").next();
		width = Std.parseInt(map.get("width"));
		height = Std.parseInt(map.get("height"));
		var layers = map.elementsNamed("layer");
		for (layer in layers){
			tiles = [];
			var layerTiles = layer.elementsNamed("data").next().elements();
			for (tile in layerTiles){
				tiles.push(Std.parseInt(tile.get("gid")));
			}
			trace("Loaded data "+tiles);
		}

		if (tiles.length != width*height){
			throw "Odd level data - More tiles than width*height";
		}
	}
	public function getTileAt (x:Int,y:Int){
		return tileInfo.get(tiles[(y*width)+x]);
	}
	public function setTileAt(x:Int,y:Int,id:Int){
		trace('setting tile at $x $y to $id');
		tiles[(y*width)+x] = id;
	}
	public function draw (g:kha.graphics2.Graphics){
		for (y in 0...height){
			for (x in 0...width){
				var tileData = tileInfo.get(tiles[(y*width)+x]);
				var sourcePos = { x: (width%(tileData.id+1))*8, y:Math.floor((tileData.id+1)/height)*8 };
				var destPos = { x: x*8, y: y*8 };
				//trace(sourcePos + " " + destPos);

				g.drawScaledSubImage(kha.Assets.images.Tileset,sourcePos.x,sourcePos.y,8,8,destPos.x,destPos.y,8,8);
			}
		}
	}
}
