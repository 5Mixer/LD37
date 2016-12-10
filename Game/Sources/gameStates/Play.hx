package gameStates;

class Play extends State {
	var ship:Ship;
	var camera:Camera;
	var player:Player;
	var game:Game;

	override public function new (game:Game,switchState:State->Void){
		super (switchState);
		camera = new Camera();
		ship = new Ship();
		this.game = game;
		this.game.camera = camera;
		ship.setTileAt(0,0,new tiles.JetTile(new kha.math.Vector2i(0,0),camera));
		player = new Player(game.keyboard);

		
	}

	override public function render(framebuffer:kha.Framebuffer){
		var g = framebuffer.g2;
		g.begin();
		g.imageScaleQuality = kha.graphics2.ImageScaleQuality.Low;
		
		camera.pos = new kha.math.Vector2(player.pos.x-kha.System.windowWidth()/2/camera.scale.x,player.pos.y-kha.System.windowHeight()/2/camera.scale.y);


		camera.transform(g);
		ship.draw(g);
		player.draw(g);

		g.color = kha.Color.Cyan;
		g.drawRect(Math.round((game.mouse.worldPos(camera).x-4)/8)*8,Math.round((game.mouse.worldPos(camera).y-4)/8)*8,8,8);
		
		g.color = kha.Color.White;

		g.font = kha.Assets.fonts.pixel;
		g.fontSize =8;

		camera.restore(g);

		var tileAtMouse = ship.getTileAt(Math.floor((game.mouse.worldPos(camera).x)/8),Math.floor((game.mouse.worldPos(camera).y)/8));
		
		if (tileAtMouse != null){
			
			g.drawString('Tile: ${tileAtMouse.name}',1,1);
			
		}

		var mouseTilePosX = Math.floor((game.mouse.worldPos(camera).x)/8);
		var mouseTilePosY = Math.floor((game.mouse.worldPos(camera).y)/8);
		if (game.mouse.leftButton)
			ship.setTileAt(mouseTilePosX,mouseTilePosY, new tiles.StandardTile(new kha.math.Vector2i(mouseTilePosX,mouseTilePosY),1));

		if (game.mouse.rightButton)
			ship.setTileAt(mouseTilePosX,mouseTilePosY, new tiles.StandardTile(new kha.math.Vector2i(mouseTilePosX,mouseTilePosY),2));


		g.end();
	}
	override public function update(delta:Float){
		if (game.keyboard.left) player.velocity.x = -player.speed;
		if (game.keyboard.right) player.velocity.x = player.speed;
		if (game.keyboard.up) player.velocity.y = -player.speed;
		if (game.keyboard.down) player.velocity.y = player.speed;


		player.update(delta,game);
		ship.update(delta,game);
	}
}