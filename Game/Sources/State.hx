package ;

class State {
	var switchState:State->Void;
	public function new (switchState:State->Void){
		this.switchState = switchState;
	}
	public function render(framebuffer:kha.Framebuffer){

	}
	public function update(delta:Float){
		
	}
}