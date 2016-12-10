package ;

class Player {
	public var pos:kha.math.Vector2;
	var size:kha.math.Vector2;
	var velocity:kha.math.Vector2;
	var sprite:Sprite;
	var keyboard:Keyboard;
	var components = new ComponentList();
	
	public function new (keyboard) {
		pos = new kha.math.Vector2(0,0);
		size = new kha.math.Vector2(8,8);
		velocity = new kha.math.Vector2(0,0);
		sprite = new Sprite(kha.Assets.images.Entities,1);
		this.keyboard = keyboard;
		
		
	}
	public function draw (g){
		sprite.draw(g,pos.x,pos.y);
		components.callEvent("draw",g);
	}
	public function update (delta:Float) {
		var speed = 1;
		if (keyboard.left) velocity.x = -speed;
		if (keyboard.right) velocity.x = speed;
		if (keyboard.up) velocity.y = -speed;
		if (keyboard.down) velocity.y = speed;

		pos.x += velocity.x;
		pos.y += velocity.y;

		var friction = .7;
		velocity.y *= friction;
		velocity.x *= friction;
	}

}
