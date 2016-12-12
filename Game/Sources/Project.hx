package;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;



class Project {
	var frame = 0;
	public var keyboard:Keyboard;

	var lastTime:Float;
	public var mouse:Mouse;

	var currentState:State;

	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);

		keyboard = new Keyboard();
		mouse = new Mouse();

		var game:Game = { mouse: mouse, keyboard: keyboard, delta: 0, camera: null};

		currentState = new gameStates.Play(game,switchState);

		lastTime = Scheduler.time();

		//kha.audio1.Audio.play(kha.Assets.sounds.Intro);
		
	}

	function switchState (newState:State){
		currentState = newState;
	}

	function update() {
		
		var delta = Scheduler.time() - lastTime;

		currentState.update(delta);

		lastTime = Scheduler.time();
	
	}

	function render(framebuffer: Framebuffer): Void {
		frame++;
		currentState.render(framebuffer);
		
	}
}
