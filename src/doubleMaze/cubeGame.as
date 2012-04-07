
package doubleMaze
{
	
	import com.greensock.TweenLite;
	
	import doubleMaze.iso.IsoBox;
	import doubleMaze.iso.IsoFloor;
	import doubleMaze.iso.IsoWorld;
	import doubleMaze.iso.Point3D;
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	[SWF(backgroundColor=0xffffff)]
	public class cubeGame extends GameConst
	{
		
		private var _world:IsoWorld;
		private var _can_move:Boolean = true;
		private var _gaps:Array;
		private var _one_passes:Array;
		private var _one_passes_yellow:Array;
		
		private var _add_block:Boolean =  false;
		private var _new_block_pos:Point3D;
		
		private var _currentLevelNumber:Number = 0;
		private var _currentLevelArray:Array;
		
		private var _box1:IsoBox;
		private var _box2:IsoBox;
		private var _box1_str:Point;
		private var _box2_str:Point;
		private var _tile1:IsoFloor;
		private var _tile2:IsoFloor;
		private var _start1:IsoFloor;
		private var _start2:IsoFloor;
		private var _box1DesirePosition:Point3D;
		private var _box2DesirePosition:Point3D;
		private var _menu:Menu =  new Menu();
		private var _pop_up:PopUp =  new PopUp();
		private static var  _instance:cubeGame  = new cubeGame();

		public function get pop_up():PopUp
		{
			return _pop_up;
		}

		public static function instance():cubeGame
		{
			return _instance;
		}
		public function cubeGame()
		{
		}
		public function init():void{
			
			_box1 = new IsoBox(_size, _red, _size);
			_box2 = new IsoBox(_size, _red, _size);
			_tile1 = new IsoFloor(_size, _red);
			_tile2 = new IsoFloor(_size, _red);
			
			Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT; 
			this.addChild(_menu);
			this.addChild(_pop_up);
			_pop_up.showInstrucions();
			
			nextRound();
			_pop_up.setNextRoundFunction(nextRound);
			_menu.setDirectionsFunction(setDirection);
			
		}
		
		private function goUp(e:MouseEvent):void{
			_box1.vx = -_jump;
			_box2.vx = -_jump;
			moveBoxes();
		}
		private function goDown(e:MouseEvent):void{
			_box1.vx = _jump;
			_box2.vx = _jump;
			moveBoxes();
		}
		private function goLeft(e:MouseEvent):void{
			_box1.vz = _jump;
			_box2.vz = _jump;
			moveBoxes();
		}
		private function goRight(e:MouseEvent):void{
			_box1.vz = -_jump;
			_box2.vz = -_jump;
			moveBoxes();
		}
		private function mouseUp(e:MouseEvent):void{
			_box1.vx = 0;
			_box1.vz = 0;
			_box2.vx = 0;
			_box2.vz = 0;
			moveBoxes();
		}
		private function nextRound():void{
			createWorld();
			_menu.showObjects();
			_can_move = true;
		}
		private function createWorld():void{  
			_world = new IsoWorld();
			_world.x = 530;
			_world.y = 90;
			addChild(_world);this.setChildIndex(_pop_up, this.numChildren-1);
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
					var tile:IsoFloor = new IsoFloor(_size, _white);
					tile.position = new Point3D(i * _size, 0, j * _size);
					_world.addChildToFloor(tile);
				}
			}
		}
		private function createRound():void{			
			_currentLevelArray = Levels.instance().getLevel(_currentLevelNumber);
			_gaps =  new Array();
			_one_passes =  new Array();
			_one_passes_yellow  = new Array();
			//	gap: 5,6  9  	// box1: 3 ->  7                          box2: 2 -> 8
			for(var i:int = 0; i < 10; i++)
			{
				for(var j:int = 0; j < 21; j++)
				{
					var element:Number= _currentLevelArray[i][j];
					if (element == 1)
					{
						var newBox:IsoBox = new IsoBox(_size, _yellow, _size);
						newBox.position = new Point3D(i * _size, 0, j * _size);
						newBox.alpha = .5;
						_world.addChildToWorld(newBox);
					}
					if(element == 3){
						_box1_str = new Point(i * _size, j * _size);
						_box1.position =  new Point3D(i * _size, 0, j * _size);
						_start1 =  new IsoFloor(_size, _gray);
						_start1.position =  new Point3D(i * _size, 0, j * _size);
						_world.addChildToFloor(_start1);
						
					}
					if(element == 2){
						_box2_str = new Point(i * _size, j * _size);
						_box2.position =  new Point3D(i * _size, 0, j * _size);
						_start2 =  new IsoFloor(_size, _gray);
						_start2.position =  new Point3D(i * _size, 0, j * _size);
						_world.addChildToFloor(_start2);
						
					}
					if(element == 7){
						_box1DesirePosition = new Point3D(i * _size, 0, j * _size);
						_tile1.position = _box1DesirePosition;
					}
					if(element == 8){
						_box2DesirePosition =  new Point3D(i * _size, 0, j * _size);
						_tile2.position = _box2DesirePosition;
					}
					if(element == 5){
						var gap:IsoFloor = new IsoFloor(_size, _green);
						gap.position = new Point3D(i * _size, 0, j * _size);
						_world.addChildToFloor(gap);
						_gaps.push(gap.position);
					}
					if(element == 6){
						var one_pass:IsoFloor = new IsoFloor(_size, _green_light);
						one_pass.position = new Point3D(i * _size, 0, j * _size);
						_world.addChildToFloor(one_pass);
						_one_passes.push(one_pass.position);
					}
					if(element == 9){
						var one_pass_yellow:IsoFloor = new IsoFloor(_size, _yellow);
						one_pass_yellow.position = new Point3D(i * _size, 0, j * _size);
						_world.addChildToFloor(one_pass_yellow);
						_one_passes_yellow.push(one_pass_yellow.position);
					}
				}
			}
		}
		private function moveBoxes():void
		{
			if(_can_move){
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
					_can_move = false;
					changeRound();
				}
				checkGaps();
				_world.sort();
			}
			_box1.vx = 0;
			_box1.vz = 0;
			_box2.vx = 0;
			_box2.vz = 0;
		}
		private function checkGaps():void{
			addNewBlock();
			
			for each( var g:Point3D in _gaps){
				if (_box1.x == g.x && _box1.z == g.z) {
					_box1.x = _box1_str.x;
					_box1.z = _box1_str.y;
					
				}
				if (_box2.x == g.x && _box2.z == g.z) {
					_box2.x = _box2_str.x;
					_box2.z = _box2_str.y;
					
				}
			}
			for each ( var p:Point3D in _one_passes){
				if ((_box1.x == p.x && _box1.z == p.z)||(_box2.x == p.x && _box2.z == p.z)) {
					var gap:IsoFloor = new IsoFloor(_size, 0x005500);
					gap.position = p;
					_world.addChildToFloor(gap);
					_gaps.push(p);
					_one_passes.splice(_one_passes.indexOf(p));
				}
			}
			for each ( var o:Point3D in _one_passes_yellow){
				if ((_box1.x == o.x && _box1.z == o.z)||(_box2.x == o.x && _box2.z == o.z)) {
					_one_passes_yellow.splice(_one_passes_yellow.indexOf(o));
					_add_block =  true;
					_new_block_pos =  o;
				}
			}
		}
		private function addNewBlock():void{
			if(_add_block){
				_add_block = false;
				var block:IsoBox  = new IsoBox(_size, _yellow, _size);
				block.position = _new_block_pos;
				_world.addChildToWorld(block);
			}
		}
		private function changeRound():void{
			_currentLevelNumber++;
			_pop_up.showNextLevel(_currentLevelNumber);_menu.changeLevel(_currentLevelNumber);
			_menu.hideObjects();
			if(_currentLevelNumber>=Levels.instance().levels.length)
				_currentLevelNumber=0;
		}
		
		public function setDirection(direction:String):void
		{
			switch(direction)
			{
				case "up" :
					_box1.vx = -_jump;
					_box2.vx = -_jump;
					break;
				case "down" :
					_box1.vx = _jump;
					_box2.vx = _jump;
					break;
				case "left" :
					_box1.vz = _jump;
					_box2.vz = _jump;
					break;
				case "right" :
					_box1.vz = -_jump;
					_box2.vz = -_jump;
					break;
				default :
					break;
			}
			moveBoxes()
		}
	}
}
