package ui;

class Button implements Element{
	public var pos:kha.math.Vector2;
	public var size:kha.math.Vector2;
	public var text:String;
	public function new (x,y,width,height,text){
		pos = new kha.math.Vector2(x,y);
		size = new kha.math.Vector2(width,height);
		this.text = text;
	}
	public function render(g:kha.graphics2.Graphics,game:Game){
		g.color = kha.Color.fromString("#6f6b6b");
		g.fontSize = 8;

		g.fillRect(pos.x,pos.y,size.x+4,size.y+4);
		g.color = kha.Color.White;
		g.drawString(this.text,this.pos.x+2,this.pos.y+2);

	}
	public function update(delta:Float,game:Game){

	}
}