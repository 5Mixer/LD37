package gameStates;

class Play extends State {
	var ship:Ship;
	var camera:Camera;
	var player:Player;
	var game:Game;

	var inventory:Array<tiles.Tile> = [];
	var inventorySelectedIndex:Int = 0;

	override public function new (game:Game,switchState:State->Void){
		super (switchState);
		camera = new Camera();
		ship = new Ship();
		this.game = game;
		this.game.camera = camera;
		player = new Player(game.keyboard);

		// /new tiles.JetTile(new kha.math.Vector2i(0,0),camera)
		// inventory.push(tiles.StandardTile)
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
//		ship.setTileAt(0,0,Type.createInstance(inventory[0], [new kha.math.Vector2i(0,0),game] ));
//		ship.setTileAt(0,0,Type.createInstance(inventory[0], [new kha.math.Vector2i(0,0),game] ));
//		ship.setTileAt(0,0,Type.createInstance(inventory[0], [new kha.math.Vector2i(0,0),game] ));
//		ship.setTileAt(0,0,Type.createInstance(inventory[0], [new kha.math.Vector2i(0,0),game] ));
//		ship.setTileAt(0,0,Type.createInstance(inventory[0], [new kha.math.Vector2i(0,0),game] ));
//		ship.setTileAt(0,0,Type.createInstance(inventory[0], [new kha.math.Vector2i(0,0),game] ));
//		ship.setTileAt(0,0,Type.createInstance(inventory[0], [new kha.math.Vector2i(0,0),game] ));
//		ship.setTileAt(0,0,Type.createInstance(inventory[0], [new kha.math.Vector2i(0,0),game] ));
//		ship.setTileAt(0,0,Type.createInstance(inventory[0], [new kha.math.Vector2i(0,0),game] ));
//		ship.setTileAt(0,0,Type.createInstance(inventory[0], [new kha.math.Vector2i(0,0),game] ));
//		ship.setTileAt(0,0,Type.createInstance(inventory[0], [new kha.math.Vector2i(0,0),game] ));
//		ship.setTileAt(0,0,Type.createInstance(inventory[0], [new kha.math.Vector2i(0,0),game] ));
//		ship.setTileAt(0,0,Type.createInstance(inventory[0], [new kha.math.Vector2i(0,0),game] ));

		game.mouse.onWheelListeners.push(function (amount){
			
			inventorySelectedIndex += amount;
			if (inventorySelectedIndex < 0) inventorySelectedIndex = inventory.length-1;
			if (inventorySelectedIndex > inventory.length-1) inventorySelectedIndex = 0;
			

		});
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

		var constructionMode = true;
		if (constructionMode){

			var tileAtMouse = ship.getTileAt(Math.floor((game.mouse.worldPos(camera).x)/8),Math.floor((game.mouse.worldPos(camera).y)/8));
		
			if (tileAtMouse != null){
				
				g.drawString('Tile: ${tileAtMouse.name}',1,1);
				
			}

			if (inventory.length != 0){
				var mouseTilePosX = Math.floor((game.mouse.worldPos(camera).x)/8);
				var mouseTilePosY = Math.floor((game.mouse.worldPos(camera).y)/8);
				if (game.mouse.leftButton){
					//ship.setTileAt(mouseTilePosX,mouseTilePosY, new tiles.StandardTile(new kha.math.Vector2i(mouseTilePosX,mouseTilePosY),1));
					if (inventory[inventorySelectedIndex] == null) return;
					inventory[inventorySelectedIndex].pos = new kha.math.Vector2i(mouseTilePosX,mouseTilePosY);
					trace("Placing" + inventory[inventorySelectedIndex]);
					ship.setTileAt(mouseTilePosX,mouseTilePosY,inventory[inventorySelectedIndex]);
					inventory.remove(inventory[inventorySelectedIndex]);
					inventorySelectedIndex--;
					if (inventorySelectedIndex < 0) inventorySelectedIndex = inventory.length;
					trace(inventory);
				}

				//if (game.mouse.rightButton)
				//	ship.setTileAt(mouseTilePosX,mouseTilePosY, new tiles.StandardTile(new kha.math.Vector2i(mouseTilePosX,mouseTilePosY),2));

			}

			
		}

		if (inventory.length != 0){
			g.drawString('Selected: [${inventorySelectedIndex}]',1,10);
		}
		

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