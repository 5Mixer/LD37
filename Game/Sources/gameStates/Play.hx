package gameStates;

class Play extends State {
	var ship:Ship;
	var camera:Camera;
	var player:Player;
	var game:Game;

	var inventory:Array<tiles.Tile> = [];
	var inventorySelectedIndex:Int = 0;

	var enemies:Array<entities.enemies.Enemy>;
	
	var constructionMode = true;

	var round:Int = 0;
	var rounds:Array<rounds.Round>;
	var frame = 0;

	override public function new (game:Game,switchState:State->Void){
		super (switchState);
		camera = new Camera();
		ship = new Ship();
		this.game = game;
		this.game.camera = camera;
		player = new Player(game.keyboard);

		enemies = new Array<entities.enemies.Enemy>();

		// /new tiles.JetTile(new kha.math.Vector2i(0,0),camera)
		// inventory.push(tiles.StandardTile)
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.JetTile(new kha.math.Vector2i(0,0),game));
		inventory.push(new tiles.StandardTile(new kha.math.Vector2i(),1));
		inventory.push(new tiles.StandardTile(new kha.math.Vector2i(),1));
		inventory.push(new tiles.StandardTile(new kha.math.Vector2i(),1));
		inventory.push(new tiles.StandardTile(new kha.math.Vector2i(),1));
		inventory.push(new tiles.StandardTile(new kha.math.Vector2i(),1));
		inventory.push(new tiles.StandardTile(new kha.math.Vector2i(),2));

		game.mouse.onWheelListeners.push(function (amount){
			
			inventorySelectedIndex += amount;
			if (inventorySelectedIndex < 0) inventorySelectedIndex = inventory.length-1;
			if (inventorySelectedIndex > inventory.length-1) inventorySelectedIndex = 0;
			

		});

		rounds = [
			new rounds.Round1(ship,game,enemies)
		];
		rounds[round].start();
	}

	override public function render(framebuffer:kha.Framebuffer){
		frame++;

		if (frame%30 == 0){
		//	rounds[0].start();
		}
		if (false){
			camera.scale.x = 8;
			camera.scale.y = 8;
		}else{
			camera.scale.x = 4;
			camera.scale.y = 4;
		}
		
		var g = framebuffer.g2;
		g.begin();
		g.imageScaleQuality = kha.graphics2.ImageScaleQuality.Low;
		
	
		camera.transform(g);
		ship.draw(g);

		if (constructionMode)
			player.draw(g);

		for (enemy in enemies){
			enemy.render(g,game);
		}

			
		g.color = kha.Color.White;

		g.font = kha.Assets.fonts.pixel;
		g.fontSize =8;

		camera.restore(g);

		if (constructionMode){
			camera.pos = new kha.math.Vector2(player.pos.x-kha.System.windowWidth()/2/camera.scale.x,player.pos.y-kha.System.windowHeight()/2/camera.scale.y);

			var tileAtMouse = ship.getTileAt(Math.floor((game.mouse.worldPos(camera).x)/8),Math.floor((game.mouse.worldPos(camera).y)/8));
		
			if (tileAtMouse != null){
				
				g.drawString('Tile: ${tileAtMouse.name}',1,1);
				
			}

			if (inventory.length != 0){
				var mouseTilePosX = Math.floor((game.mouse.worldPos(camera).x)/8);
				var mouseTilePosY = Math.floor((game.mouse.worldPos(camera).y)/8);
				if (game.mouse.justLeftClicked){
					//ship.setTileAt(mouseTilePosX,mouseTilePosY, new tiles.StandardTile(new kha.math.Vector2i(mouseTilePosX,mouseTilePosY),1));
					if (inventory[inventorySelectedIndex] == null) return;
					inventory[inventorySelectedIndex].pos = new kha.math.Vector2i(mouseTilePosX,mouseTilePosY);
					var success = ship.setTileAt(mouseTilePosX,mouseTilePosY,inventory[inventorySelectedIndex]);
					if (success){
						inventory.remove(inventory[inventorySelectedIndex]);
						inventorySelectedIndex--;
						if (inventorySelectedIndex < 0) inventorySelectedIndex = 0;
					}
				}


				//Display inventory
				var x = 0;
				var selectedItemX = 0;
				var i = 0;

				for (item in inventory){
					i++;
					
					g.pushTransformation(g.transformation);

					g.transformation._00 = 2;
					g.transformation._11 = 2;

					g.translate(x*8*2,0);
					item.renderInventoryItem(g);
					g.popTransformation();
					
					x+= item.size.width;
					if (i <= inventorySelectedIndex) selectedItemX += item.size.width;
					
					
				}
				g.color = kha.Color.White;
				g.drawRect(selectedItemX*8,0,inventory[inventorySelectedIndex].size.width*8,inventory[inventorySelectedIndex].size.height*8);

				//if (game.mouse.rightButton) //Remove item
				//	ship.setTileAt(mouseTilePosX,mouseTilePosY, new tiles.StandardTile(new kha.math.Vector2i(mouseTilePosX,mouseTilePosY),2));

			}

			
		}

		if (!constructionMode){
			camera.pos = new kha.math.Vector2(ship.pos.x+(ship.width*4)-kha.System.windowWidth()/2/camera.scale.x,ship.pos.y+(ship.height*4)-kha.System.windowHeight()/2/camera.scale.y);
		}

		if (inventory.length != 0){
			g.drawString('Selected: [${inventorySelectedIndex}]',1,10);
		
		}
		

		g.end();

		game.mouse.update();
	}
	override public function update(delta:Float){
		
		if (game.keyboard.left) player.velocity.x = -player.speed;
		if (game.keyboard.right) player.velocity.x = player.speed;
		if (game.keyboard.up) player.velocity.y = -player.speed;
		if (game.keyboard.down) player.velocity.y = player.speed;

		

		if (constructionMode)
			player.update(delta,game);

		for (enemy in enemies){
			enemy.update(delta,game);
		}
		
		ship.update(delta,game);
	}
}