package ;

import tiles.Tile;
import tiles.StandardTile;
import tiles.OccupiedSpaceTile;

class Ship {
	var tiles = new Array<Tile>();

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
			var i = 0;
			for (tile in layerTiles){
				tiles.push(new StandardTile(new kha.math.Vector2i(i%width,Math.floor(i/width)),Std.parseInt(tile.get("gid"))));
				i++;
			}
			//trace("Loaded data "+tiles);
		}

		if (tiles.length != width*height){
			throw "Odd level data - More tiles than width*height";
		}
	}
	public function getTileAt (x:Int,y:Int){
		return tiles[(y*width)+x];
	}
	function setTileSimply(x,y,tile){
		/*if (Std.is(getTileAt(x,y),OccupiedSpaceTile)){
			var pos = cast(getTileAt(x,y),OccupiedSpaceTile).largerTile.pos;
			//var pos = new kha.math.Vector2i(x,y).sub(cast(getTileAt(x,y),OccupiedSpaceTile).relativePosition);
			var size = cast(getTileAt(x,y),OccupiedSpaceTile).largerTile.size;
			for (y in 0...size.width){
				for (x in 0...size.height){
					if (getTileAt (y+pos.y,x+pos.x) == null) return false;
				}
			}
		}*/
		tiles[(y*width)+x] = tile;
		tiles[(y*width)+x].pos = new kha.math.Vector2i(x,y);
	}
	public function setTileAt(x:Int,y:Int,tile:Tile){
		if (x < 0 || y < 0 || x > width || y > height) return false;

		if (Std.is(getTileAt(x,y),StandardTile) == false && getTileAt(x,y) != null) return false;

		trace('setting tile at $x $y');

		if (tile.size.width > 1 || tile.size.height > 1){
			

			//Loop non destructively and check if /any/ of the tiles would be in a taken place.
			//Do this before changing any tiles.
			for (empty_y in 0 ... tile.size.width){
				for (empty_x in 0 ... tile.size.height){

					if (Std.is(getTileAt(x+empty_x,y+empty_y),StandardTile) == false || getTileAt(x+empty_x,y+empty_y) == null) return false;
				}
			}
			setTileSimply(x,y,tile);

			for (empty_y in 0 ... tile.size.width){
				for (empty_x in 0 ... tile.size.height){
					if (empty_x == 0 && empty_y == 0) continue;

					setTileSimply(empty_x+x,y+empty_y,new tiles.OccupiedSpaceTile(new kha.math.Vector2i(empty_x+x,empty_y+y),cast tile,new kha.math.Vector2i(empty_x,empty_y)));
				}
			}
		}
		return true;
	}
	public function update(delta:Float,game:Game){
		for (y in 0...height){
			for (x in 0...width){
				if (tiles[(y*width)+x] != null)
					tiles[(y*width)+x].update(delta,game);
				
			}
		}
	}
	public function draw (g:kha.graphics2.Graphics){
		for (y in 0...height){
			for (x in 0...width){
				if (tiles[(y*width)+x] != null)
					tiles[(y*width)+x].render(g,x,y);
				
			}
		}
	}
}
