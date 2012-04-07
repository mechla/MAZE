package doubleMaze
{
	import flash.display.Sprite;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;

	//	[SWF(backgroundColor=0xffffff)]
	public class DoubleMazeGame extends Sprite
	{
		
		public function DoubleMazeGame()
		{
			Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT; 
			super();
			addChild(cubeGame.instance());//USUNAĆ
			cubeGame.instance().init();
			
		}
	}
}
