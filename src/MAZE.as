package
{
	import doubleMaze.DoubleMazeGame;
	import doubleMaze.GameConst;
	import doubleMaze.cubeGame;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class MAZE extends GameConst
	{
		private var _double_maze_game:DoubleMazeGame;
		public function MAZE()
		{
			super();
			
			// support autoOrients
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT; 
			
	
			
			addDoubleMazeGame();
			addEvents();
		}
		public function addEvents():void{
			if(!_android)
				stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		public function removeEvents():void{
			if(!_android)
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		private function onKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP :
					cubeGame.instance().setDirection("up");
					break;
				
				case Keyboard.DOWN :
					cubeGame.instance().setDirection("down");
					break;
				
				case Keyboard.LEFT :
					cubeGame.instance().setDirection("left");
					break;
				
				case Keyboard.RIGHT :
					cubeGame.instance().setDirection("right");
					break;
				
				default :
					break;
				
			}
		}
		private function addDoubleMazeGame():void{
			_double_maze_game =  new DoubleMazeGame();
			//rotation
						_double_maze_game.rotation = 90;
						_double_maze_game.x = 480;
						_double_maze_game.y = 0;
			this.addChild(_double_maze_game);
		}
	}
}