package view
{
	import com.greensock.TweenAlign;
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import doubleMaze.GameConst;
	import doubleMaze.cubeGame;
	
	public class Menu extends GameConst
	{
		
		
		private var _infoText:text_filed =  new text_filed()
		private var _menu:up_menu =  new up_menu();
		private var _navigation:navigation  = new navigation()
		private var _set_directions:Function;
		private var _container:Sprite =  new Sprite();
		
		public function Menu()
		{
			Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT; 
			super();
			init();
			addChild(_container);
		}
		
		public function setDirectionsFunction(f:Function):void{
			_set_directions =  f;
		}
		private function init():void{
			addMenu();
			addNavigation();
			
		}
		
		private function addMenu():void{
			addChild(_menu);
			if(_android)
				_menu.instructions.addEventListener(TouchEvent.TOUCH_END, showInstructions);
			else
				_menu.instructions.addEventListener(MouseEvent.CLICK, showInstructions);
		}
		private function showInstructions(...args):void{
			cubeGame.instance().pop_up.showInstrucions();
		}
		private function removeText(...args):void{
			if (_android)
				removeEventListener(TouchEvent.TOUCH_BEGIN, removeText);
			else
				removeEventListener(MouseEvent.CLICK, removeText);
			TweenLite.to(_infoText, 1,{alpha:0, onComplete:removeInfoText});
		}
		private function removeInfoText():void{
			
			_container.removeChild(_infoText);
		}
		private function addNavigation():void{
			_container.addChild(_navigation);
			_navigation.y = -20;
			_navigation.up.mouseChildren = false;
			_navigation.down.mouseChildren = false;
			_navigation.left.mouseChildren = false;
			_navigation.right.mouseChildren = false;
			addEvents();
		}
		public function addEvents():void{
			if(_android){
				_navigation.up.addEventListener(TouchEvent.TOUCH_BEGIN, moveBoxesAndroid);
				_navigation.down.addEventListener(TouchEvent.TOUCH_BEGIN,  moveBoxesAndroid);
				_navigation.left.addEventListener(TouchEvent.TOUCH_BEGIN,  moveBoxesAndroid);
				_navigation.right.addEventListener(TouchEvent.TOUCH_BEGIN,  moveBoxesAndroid);
			}
			else{
				_navigation.up.addEventListener(MouseEvent.CLICK, moveBoxes);
				_navigation.down.addEventListener(MouseEvent.CLICK, moveBoxes);
				_navigation.left.addEventListener(MouseEvent.CLICK, moveBoxes);
				_navigation.right.addEventListener(MouseEvent.CLICK, moveBoxes);
			}
		}
		public function removeEvents():void{
			if(_android){
				_navigation.up.removeEventListener(TouchEvent.TOUCH_BEGIN, moveBoxesAndroid);
				_navigation.down.removeEventListener(TouchEvent.TOUCH_BEGIN,  moveBoxesAndroid);
				_navigation.left.removeEventListener(TouchEvent.TOUCH_BEGIN,  moveBoxesAndroid);
				_navigation.right.removeEventListener(TouchEvent.TOUCH_BEGIN,  moveBoxesAndroid);
			}
			else{
				_navigation.up.removeEventListener(MouseEvent.CLICK, moveBoxes);
				_navigation.down.removeEventListener(MouseEvent.CLICK, moveBoxes);
				_navigation.left.removeEventListener(MouseEvent.CLICK, moveBoxes);
				_navigation.right.removeEventListener(MouseEvent.CLICK, moveBoxes);
			}
		}
		public function changeLevel(level:Number):void{
			_menu.level.text = "LEVEL "+level.toString();
		}
		private function moveBoxes(e:MouseEvent):void{
			_set_directions(e.target.name);
		}
		private function moveBoxesAndroid(e:TouchEvent):void{
			_set_directions(e.target.name);
		}
		public  function hideObjects():void{
			TweenLite.to(_container,1,{alpha:0});
		}
		public  function showObjects():void{
			TweenLite.to(_container,1,{alpha:1});
			
		}
	}
	
}
