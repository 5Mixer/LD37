package entities.enemies;


typedef ShipStats = {
	var health:Int;
	var speed:Int;
}

interface Enemy {
	public function render (g:kha.graphics2.Graphics,game:Game):Void;
	public function update (delta:Float,game:Game):Void;
}