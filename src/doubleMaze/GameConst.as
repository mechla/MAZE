package doubleMaze
{
	import flash.display.MovieClip;

	public class GameConst extends MovieClip
	{
		protected var _android:Boolean = false;
		protected var _stage_width:Number =  800;
		protected var _stage_height:Number =  480;
		
		
		protected var _size:Number = 25
		protected var _jump:Number = _size;
		
		protected var _green:uint = 0x005500;
		protected var _green_light:uint = 0x00AA00
		protected var _yellow:uint = 0xffff66;
		protected var _red:uint = 0x550000 ;
		protected var _white:uint = 0xffffff;
		protected var _gray:uint = 0xcccccc;
		
		public function GameConst()
		{
			super();
		}
	}
}