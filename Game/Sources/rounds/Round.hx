package rounds;

class Round {
	var playerShip:Ship;
	var game:Game;
	var enemies:Array<entities.enemies.Enemy>;
	public function new (playerShip:Ship, game:Game,enemies:Array<entities.enemies.Enemy>){
		this.playerShip = playerShip;
		this.game = game;
		this.enemies = enemies;
	}
	public function start (){

	}
	public function update (delta){
		
	}
}