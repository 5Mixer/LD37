package rounds;

class Round1 extends Round{
	override public function new (playerShip:Ship, game:Game,enemies:Array<entities.enemies.Enemy>){
		super(playerShip,game,enemies);	
	}
	override public function start (){
		enemies.splice(0,enemies.length);
		//Build up outside layer of a number of class A's.
		for (i in 0...8){
			var e = new entities.enemies.EnemyA(i*(4*8*8),Math.sin(i)*70);
			//e.angle = Math.round(180);
			enemies.push(e);

		}
	}
	var t= 0;
	override public function update (delta){
		//Build up outside layer of a number of class A's.
		for (i in 0...8){
			var e = new entities.enemies.EnemyA(i*(4*8*8),Math.sin(i)*70);
			//e.angle = Math.round(180);
			enemies.push(e);

		}
	}
}