package entities.enemies;


class EnemyA implements Enemy {
	
	public var pos:kha.math.Vector2;
	var spriteMap:kha.Image;
	public var angle:Int = 45;
	var size:kha.math.Vector2;
	public function new (x,y){
		pos = new kha.math.Vector2(x,y);
		size = new kha.math.Vector2(3*8,4*8);
		spriteMap = kha.Assets.images.Enemies;
	}
	public function render (g:kha.graphics2.Graphics,game:Game):Void {
		g.pushTransformation(g.transformation);

		var rotatePoint = game.camera.screenToWorld(new kha.math.Vector2(0,0));
		g.translate((rotatePoint.x)*game.camera.scale.x,(rotatePoint.y)*game.camera.scale.y);
		g.translate(-this.size.x*game.camera.scale.x/2,-this.size.y*game.camera.scale.y/2);
		//g.translate(-game.camera.pos.x,-game.camera.pos.y);
		g.rotate(angle * (Math.PI/180),0,0);
		g.translate(-(rotatePoint.x)*(game.camera.scale.x),-(rotatePoint.y)*(game.camera.scale.y));
		g.translate(pos.x,pos.y);
		g.drawSubImage(spriteMap, 0,0, 0,0,8*3,8*4);
		g.popTransformation();

		angle++;
	}
	public function update (delta:Float,game:Game):Void {

	}
}