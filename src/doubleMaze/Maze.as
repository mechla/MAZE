
package
{
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	import iso.IsoBox;
	import iso.IsoFloor;
	import iso.IsoWorld;
	import iso.Point3D;
	
	[SWF(backgroundColor=0xffffff)]
	public class Maze extends Sprite
	{
		private var _world:IsoWorld;
		
		private var _jump:Number = 20;
		private var _currentLevelNumber:Number = 0;
		private var _currentLevelArray:Array;
		
		private var _box1:IsoBox = new IsoBox(20, 0x550000, 20);
		private var _box2:IsoBox = new IsoBox(20, 0x550000, 20);		
		private var _tile1:IsoFloor = new IsoFloor(20, 0x550000);
		private var _tile2:IsoFloor = new IsoFloor(20, 0x550000);
		
		private var _box1DesirePosition:Point3D;
		private var _box2DesirePosition:Point3D;
		
		
		public function Maze()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			createWorld();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		private function createWorld():void{
			
			_world = new IsoWorld();
			_world.x = 500;
			_world.y = 100;
			addChild(_world);
			createTille();
			_world.addChildToFloor(_tile2);
			_world.addChildToFloor(_tile1);
			createRound();
			_world.addChildToWorld(_box1);			
			_world.addChildToWorld(_box2);
		}
		
		private function createTille():void{
			for(var i:int = 0; i < 10; i++)
			{
				for(var j:int = 0; j < 21; j++)
				{
					var tile:IsoFloor = new IsoFloor(20, 0xffffff);
					tile.position = new Point3D(i * 20, 0, j * 20);
					_world.addChildToFloor(tile);
				}
			}
		}
		private function createRound():void{			
			_currentLevelArray = Levels.instance().getLevel(_currentLevelNumber);
		
			for(var i:int = 0; i < 10; i++)
			{
				for(var j:int = 0; j < 21; j++)
				{
					var element:Number= _currentLevelArray[i][j];
					if (element == 1)
					{
						var newBox:IsoBox = new IsoBox(20, 0xffff00, 20);
						newBox.position = new Point3D(i * 20, 0, j * 20);
						newBox.alpha = .6;
						_world.addChildToWorld(newBox);
					}
					if(element == 3){
						_box1.position =  new Point3D(i * 20, 0, j * 20);
						
					}
					if(element == 2){
						_box2.position =  new Point3D(i * 20, 0, j * 20);
						
					}
					if(element == 7){
						_box1DesirePosition = new Point3D(i * 20, 0, j * 20);
						_tile1.position = _box1DesirePosition;
					}
					if(element == 8){
						_box2DesirePosition =  new Point3D(i * 20, 0, j * 20);
						_tile2.position = _box2DesirePosition;
					}
					
				}
			}
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			switch(event.keyCode)
			{
				case Keyboard.UP :
					_box1.vx = -_jump;
					_box2.vx = -_jump;
					break;
				
				case Keyboard.DOWN :
					_box1.vx = _jump;
					_box2.vx = _jump;
					break;
				
				case Keyboard.LEFT :
					_box1.vz = _jump;
					_box2.vz = _jump;
					break;
				
				case Keyboard.RIGHT :
					_box1.vz = -_jump;
					_box2.vz = -_jump;
					break;
				
				default :
					break;
				
			}
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			_box1.vx = 0;
			_box1.vz = 0;
			_box2.vx = 0;
			_box2.vz = 0;
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			if(_world.canMove(_box1))
			{
				_box1.x += _box1.vx;
				_box1.y += _box1.vy;
				_box1.z += _box1.vz;
			}
			if(_world.canMove(_box2))
			{
				_box2.x += _box2.vx;
				_box2.y += _box2.vy;
				_box2.z += _box2.vz;
			}
			if(_box2.x == _box2DesirePosition.x && 
				_box1.x == _box1DesirePosition.x && 
				_box2.z == _box2DesirePosition.z && 
				_box1.z == _box1DesirePosition.z)				
			{
				removeEventListener(Event.ENTER_FRAME, onEnterFrame);
				trace("wygrałes");
				nextRound();
			}
			_world.sort();
		}
		
		private function nextRound():void{
//			_world.removeChildrenFromWorld();
			_currentLevelNumber++;
			trace(_currentLevelNumber);
			removeChild(_world);
			createWorld();
		}
	}
}
