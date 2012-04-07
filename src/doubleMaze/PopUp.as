package doubleMaze
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Elastic;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	public class PopUp extends GameConst
	{
		private var _next_round:Function;
		private var _pop_up:level_up_popup =  new level_up_popup();
		private var _popup_size:Point =  new Point(_pop_up.width,+_pop_up.height);
		private var _show_time:Number = 1;
		private var _instruction:pop_up_instructions =  new pop_up_instructions();
		private var _instruction_index:Number = 1;
		private var _bg:background =  new background();
		public function PopUp()
		{
			Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT; 
			super();
			_pop_up.x = _stage_width/2 - _pop_up.width/2;
			_pop_up.y = _stage_height/2 - _pop_up.height/2;
			_instruction.x = _stage_width/2 - _instruction.width/2;
			_instruction.y = _stage_height/2 - _instruction.height/2;
			_bg.width = _stage_width;
			_bg.height = _stage_height;
		}
		public function showInstrucions():void{
			addChild(_bg);
			_instruction_index = 1;
			_instruction.gotoAndStop(_instruction_index);
			trace(_instruction_index);
			addChild(_instruction)
			TweenLite.delayedCall(1,addEvents);
		}
		private function addEvents():void{
			if(_android)
				_instruction.addEventListener(TouchEvent.TOUCH_END, swapInstruction);
			else
				_instruction.addEventListener(MouseEvent.CLICK, swapInstruction);
		}
		private function swapInstruction(...args):void{
			if(_instruction_index == 1){
				_instruction_index++;
				_instruction.gotoAndStop(_instruction_index);
			}
			else{
				if(_android)
					_instruction.removeEventListener(TouchEvent.TOUCH_END, swapInstruction);
				else
					_instruction.removeEventListener(MouseEvent.CLICK, swapInstruction);
				removeChild(_bg);
				removeChild(_instruction);
				
			}
			trace("swap ", _instruction_index);
		}
		public function setNextRoundFunction(f:Function):void{
			_next_round =  f;
		}
		public function showWrongPosition():void{
			_pop_up.level.text = "Wrong position!";
			_pop_up.info.text = "You move to wrong position, green fields can't be access";
			show();
		}
		public function showNextLevel(level:Number):void{
			_pop_up.level.text = "level " +level.toString();
			_pop_up.info.text = "Congratulations! Try next level.";
			show();
		}
		private function show():void{
			_pop_up.x = _stage_width/2;
			_pop_up.y = _stage_height/2;
			_pop_up.scaleX = _pop_up.scaleY = 0;
			this.addChild(_bg);
			this.addChild(_pop_up);
			TweenLite.to(_pop_up, _show_time, {x:_stage_width/2 - _popup_size.x/2, y:_stage_height/2 - _popup_size.y/2, scaleX:1, scaleY:1,ease:Elastic.easeOut, onComplete:addEvent});
			
		}
		private function addEvent():void{
			if(_android)
				this.addEventListener(TouchEvent.TOUCH_BEGIN, hide);
			else
				this.addEventListener(MouseEvent.CLICK, hide);
		}
		public function hide(...args):void{
			if(_android)
				this.removeEventListener(TouchEvent.TOUCH_BEGIN, hide);
			else
				this.removeEventListener(MouseEvent.CLICK, hide);
			TweenLite.to(_pop_up,_show_time, {x:_stage_width/2, y:_stage_height/2, scaleX:0, scaleY:0, ease:Elastic.easeIn, onComplete:removePopUp});
		}
		private function removePopUp():void{
			this.removeChild(_pop_up)
			this.removeChild(_bg);
			_next_round();
			
		}
	}
}