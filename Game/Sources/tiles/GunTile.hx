package tiles;

class GunTile implements Tile {
	public var name:String = "gun";
	public var collide:Bool = true;
	public var interiourTile:Bool = false;
	public var size = {width: 3, height: 3};
	public var pos:kha.math.Vector2i;

	public var rocketRotation = 0;
	var gunOffset:kha.math.Vector2; //How much is the gun offset from the base.
	var gunOffsetUnrotated:kha.math.Vector2;

	var tileset:kha.Image;
	var t = 0.0;
	var game:Game;
	public function new (pos,game){
		this.pos = pos;
		tileset = kha.Assets.images.Tileset;
		this.game = game;

		gunOffset = new kha.math.Vector2(1.5*8,1.5*8);
		gunOffsetUnrotated = new kha.math.Vector2();
	}
	public function render (g:kha.graphics2.Graphics,x:Int,y:Int):Void {
		gunOffsetUnrotated = new kha.math.Vector2(8+(Math.sin(t*60)*.05)*8*8,0);

		//Render base.
		g.drawSubImage(tileset,x*8, y*8, 0, 8*4,8*3,8*3);

		var rotatePoint = game.camera.screenToWorld(new kha.math.Vector2(0,0));
		g.pushTransformation(g.transformation);
	
		g.transformation = kha.math.FastMatrix3.translation(-6*8,-2*8);

		var screenOrigin = game.camera.screenToWorld(new kha.math.Vector2(0,0));
		

		g.rotate(rocketRotation * (Math.PI / 180),0,0);

		//g.translate(screenOrigin.x,screenOrigin.y);

		g.translate(-game.camera.pos.x*3,-game.camera.pos.y*3);

		g.translate((x+4)*8*game.camera.scale.x,(y+4)*(game.camera.scale.y*2)*game.camera.scale.y);

		
		g.drawScaledSubImage(tileset,3*8,8*3,3*8,8,0,0,3*8*game.camera.scale.x,1*8*game.camera.scale.y);
		g.popTransformation();

		this.x = x;
		this.y = y;
		//rocketRotation += 1;
	}
	var x = 0;
	var y = 0;
	public function renderInventoryItem (g:kha.graphics2.Graphics):Void {
		g.drawSubImage(tileset,0,0, 0, 8,8*3,8*3);
	}
	public function update (delta:Float,game:Game,ship:Ship){
		t += delta;


		ship.bullets.push(new entities.bullet.Bullet(x*8+8+pos.x,y*8+8+pos.y,true,this,rocketRotation));	
	
		
		rocketRotation = 180 + cast Math.atan2(((pos.y+1.5)*8)- game.mouse.worldPos(game.camera).y,((pos.x+1.5)*8) -game.mouse.worldPos(game.camera).x)*(180/Math.PI);
	}
}