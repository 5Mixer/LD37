package entities.bullet;

class Bullet {
	var pos:kha.math.FastVector2;
	var angle:Float;
	var vx:Int;
	var vy:Int;
	var life = 100;
	public function new (x,y,friendly,spawner,angle){
		pos = new kha.math.FastVector2(x,y);
		this.angle = angle;

		vx = Math.round(Math.cos(angle * (Math.PI/180))*5);
		vy = Math.round(Math.sin(angle * (Math.PI/180))*5);

	}
	public function update (delta){
		pos.x += vx;
		pos.y += vy;
		life--;
	}
	public function render (g:kha.graphics2.Graphics){
		
		g.drawSubImage(kha.Assets.images.Entities,this.pos.x,this.pos.y,8,0,8,8);
	}
}