package tiles;

class JetTile implements Tile {
	public var name:String = "Jet";
	public var collide:Bool = true;
	public var interiourTile:Bool = false;
	public var size = {width: 3, height: 3};
	public var pos:kha.math.Vector2i;

	public var rocketRotation = 0;
	var jetOffset:kha.math.Vector2; //How much is the jet offset from the base.
	var jetOffsetUnrotated:kha.math.Vector2;

	var tileset:kha.Image;
	var cam:Camera;
	var t = 0.0;
	public function new (pos,cam){
		this.pos = pos;
		tileset = kha.Assets.images.Tileset;
		this.cam = cam;

		jetOffset = new kha.math.Vector2(1.5*8,1.5*8);
		jetOffsetUnrotated = new kha.math.Vector2();
	}
	public function render (g:kha.graphics2.Graphics,x:Int,y:Int):Void {
		jetOffsetUnrotated = new kha.math.Vector2(8+(Math.sin(t*60)*.05)*8*8,0);

		//Render base.
		g.drawSubImage(tileset,x*8, y*8, 0, 8,8*3,8*3);

		//g.pushTransformation(g.transformation);
		//Render rocket
		//Get the point of the world that the screen has at 0,0
		var rotatePoint = cam.screenToWorld(new kha.math.Vector2(0,0));
		//Store current world transform for later restoration after this madness
		g.pushTransformation(g.transformation);
		//Translate 'back' to the *screen* origin point, and center sprite
		g.translate((rotatePoint.x)*8,(rotatePoint.y)*8);
		g.translate(-jetOffsetUnrotated.x,-jetOffsetUnrotated.y);
		//Do a rotate at this point.
		g.translate(0*8,-12*8);
		//move forwards back etc for vibrations etc
		g.rotate(rocketRotation * (Math.PI / 180),0,0);
		//Translate back from 0,0 screen to 0,0 world
		g.translate(-rotatePoint.x*8,-rotatePoint.y*8);
		//Translate to place of ship
		
		//g.drawRect(0,0,2,2);
		g.translate(jetOffset.x*8,jetOffset.y*8);
		//Draw
		g.drawSubImage(tileset,x*8 -12,y*8+8,3*8,8,3*8,8);
		
		g.popTransformation();

		rocketRotation += 1;
	}
	public function update (delta:Float,game:Game){
		t+=delta;
		rocketRotation = 180 + cast Math.atan2(((pos.y+1.5)*8)- game.mouse.worldPos(game.camera).y,((pos.x+1.5)*8) -game.mouse.worldPos(game.camera).x)*(180/Math.PI);
	}
}