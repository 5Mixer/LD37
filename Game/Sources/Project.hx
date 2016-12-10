package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Project {
	var ship:Ship;
	var camera:Camera;
	var frame = 0;
	var player:Player;
	var keyboard:Keyboard;

	var lastTime:Float;
	var mouse:Mouse;

	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);


		keyboard = new Keyboard();
		camera = new Camera();
		mouse = new Mouse(camera);

		ship = new Ship();
		player = new Player(keyboard);

		lastTime = Scheduler.time();
		
	}

	function update() {
		
		var delta = Scheduler.time() - lastTime;
		player.update(delta);

		lastTime = Scheduler.time();
		
	}

	function render(framebuffer: Framebuffer): Void {
		frame++;


		var g = framebuffer.g2;
		g.begin();
		g.imageScaleQuality = kha.graphics2.ImageScaleQuality.Low;
		
		camera.pos = new kha.math.Vector2(player.pos.x-kha.System.windowWidth()/2/camera.scale.x,player.pos.y-kha.System.windowHeight()/2/camera.scale.y);


		camera.transform(g);
		ship.draw(g);
		player.draw(g);

		g.color = kha.Color.Cyan;
		g.drawRect(Math.round((mouse.worldPos().x-4)/8)*8,Math.round((mouse.worldPos().y-4)/8)*8,8,8);
		
		g.color = kha.Color.White;

		g.font = kha.Assets.fonts.pixel;
		g.fontSize =8;

		camera.restore(g);

		var tileAtMouse = ship.getTileAt(Math.floor((mouse.worldPos().x)/8),Math.floor((mouse.worldPos().y)/8));
		
		if (tileAtMouse != null){
			
			g.drawString('Tile: ${tileAtMouse.name}',1,1);
			
		}
		if (mouse.leftButton)
			ship.setTileAt(Math.floor((mouse.worldPos().x)/8),Math.floor((mouse.worldPos().y)/8),1);

		if (mouse.rightButton)
			ship.setTileAt(Math.floor((mouse.worldPos().x)/8),Math.floor((mouse.worldPos().y)/8),2);


		g.end();

		
	}
}
