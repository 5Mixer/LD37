package ui;

interface Element {
	public function render(g:kha.graphics2.Graphics,game:Game):Void;
	public function update(delta:Float,game:Game):Void;
}