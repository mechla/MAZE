package doubleMaze
{
	import flash.geom.Point;
	import flash.sampler.NewObjectSample;
	
	public class Level2
	{
		private var _levels1:Array = new Array();
		private var _levels2:Array = new Array();
		private static var _instance:Level2=new Level2();
		
		public static function instance():Level2
		{
			return _instance;
		}
		public function Level2():void{
			//			randomLevels();
			makeReadyLevels();
			
		}
		private function randomLevels():void{
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
			_levels1.push(randomField());
			_levels2.push(randomField());
		}
		private function randomField():Array{
			var fields:Array =  new Array();
			var start:Point =  new Point(random(8),random(7));
			var end:Point = new Point(random(8),random(7));
			for(var i:int =0;i<9;i++){
				fields[i] = new Array();
				for(var j:int = 0;j<8;j++){
					fields[i][j] = "none";
					
					if(i == start.x && j == start.y) {
						fields[i][j] = "start";
						//						trace(i,j,"START");
					}
					else if(i == end.x && j == end.y){
						fields[i][j] = "end";
						//						trace(i,j,"END");
					}
					else if(Math.random()<.1){
						fields[i][j] = "block";
						//						trace(i,j,"block");
					}
					else if(Math.random()<.05){
						fields[i][j]= "break";
						//						trace(i,j,"break");
					}
					else{
						fields[i][j]= "none";
						//						trace(i,j,"_");
						
					}
				}
			}
			return fields;
		}
		private function random(number:int):int{
			return Math.floor((Math.random()*number));
		}
		public function getLevel1(level:Number):Array{
			trace("--------LEVELS1: ",level);
			for(var i:int = 0;i<_levels1[level].length;i++){
				trace("levels1:",_levels1[level][i]);
			}
			return _levels1[level];
		}
		
		public function get levels1():Array
		{
			return _levels1;
		}
		public function getLevel2(level:Number):Array{
			trace("-----LEVELS  2: ",level);
			for(var i:int = 0;i<_levels2[level].length;i++){
				trace("levels2:",_levels2[level][i]);
			}
			return _levels2[level];
		}
		
		public function get levels2():Array
		{
			return _levels2;
		}
		private function makeReadyLevels():void{
			var level1:Array;
			var level2:Array
			/////////////hard = 2
			level1 =  new Array();
			level1.push(["block","none","none","none","none","none","block","block"]);
			level1.push(["none","none","none","none","none","none","none","none"]);
			level1.push(["none","none","none","start","none","none","none","none"]);
			level1.push(["none","end","none","none","none","none","none","none"]);
			level1.push(["none","none","block","none","none","none","none","none"]);
			level1.push(["none","none","none","none","none","none","none","none"]);
			level1.push(["block","none","block","none","block","none","none","none"]);
			level1.push(["none","none","none","none","none","break","none","none"]);
			level1.push(["none","none","none","none","none","none","none","none"]);
			_levels1.push(level1);
			level2 =  new Array();
			level2.push(["none","break","none","none","none","none","none","none"]);
			level2.push(["none","none","none","none","break","none","none","none"]);
			level2.push(["none","none","none","block","none","none","none","none"]);
			level2.push(["none","none","none","block","block","none","none","none"]);
			level2.push(["none","none","none","block","none","none","none","none"]);
			level2.push(["none","block","none","none","none","none","start","none"]);
			level2.push(["end","none","block","none","none","none","none","none"]);
			level2.push(["break","none","block","none","none","none","none","none"]);
			level2.push(["none","none","block","none","none","none","none","none"]);
			_levels2.push(level2);
			//hard=3
			level1 =  new Array();
			level1.push(["none","none","none","none","none","none","none","none"]);
			level1.push(["none","none","none","block","none","none","none","none"]);
			level1.push(["none","none","none","none","block","none","none","none"]);
			level1.push(["none","none","none","none","none","none","none","none"]);
			level1.push(["end","none","none","none","break","none","none","none"]);
			level1.push(["none","block","none","none","block","none","none","none"]);
			level1.push(["none","none","none","none","none","block","none","none"]);
			level1.push(["none","none","none","none","none","start","block","none"]);
			level1.push(["break","none","none","none","none","none","none","none"]);
			_levels1.push(level1);
			level2 =  new Array();
			level2.push(["none","block","block","block","none","none","none","none"]);
			level2.push(["none","start","break","none","none","end","block","block"]);
			level2.push(["none","none","block","none","none","none","block","none"]);
			level2.push(["none","none","none","none","none","none","none","block"]);
			level2.push(["none","none","none","none","block","break","none","none"]);
			level2.push(["none","none","block","none","none","none","none","break"]);
			level2.push(["none","none","none","none","none","none","none","none"]);
			level2.push(["block","none","none","none","none","none","none","block"]);
			level2.push(["none","none","none","none","break","none","none","block"]);
			///////////////////////////////hard = 5
			level1 =  new Array();
			level1.push(["none","none","none","none","none","block","none","none"]);
			level1.push(["none","none","none","end","none","none","none","none"]);
			level1.push(["none","none","none","none","block","none","block","none"]);
			level1.push(["none","none","none","start","none","block","none","none"]);
			level1.push(["none","none","none","none","none","none","none","none"]);
			level1.push(["none","none","block","block","none","none","none","none"]);
			level1.push(["none","block","block","none","block","none","none","none"]);
			level1.push(["none","none","none","none","block","block","none","block"]);
			level1.push(["none","none","block","none","none","none","none","none"]);
			_levels1.push(level1);
			level2 =  new Array();
			level2.push(["none","none","none","block","none","none","none","none"]);
			level2.push(["none","none","none","none","none","none","block","none"]);
			level2.push(["none","none","none","break","none","none","none","none"]);
			level2.push(["none","none","none","none","block","none","start","none"]);
			level2.push(["none","none","none","none","none","none","none","none"]);
			level2.push(["block","none","none","none","none","break","none","none"]);
			level2.push(["none","none","break","none","block","none","none","block"]);
			level2.push(["block","none","none","none","end","none","none","none"]);
			level2.push(["none","none","none","none","none","none","none","none"]);
			_levels2.push(level2);
			//hard = 5
			level1 =  new Array();
			level1.push(["none","block","block","none","none","none","none","none"]);
			level1.push(["none","none","none","break","none","block","none","none"]);
			level1.push(["block","none","none","end","none","none","break","none"]);
			level1.push(["none","none","none","none","none","none","none","none"]);
			level1.push(["none","none","block","none","none","none","none","none"]);
			level1.push(["none","block","break","none","none","none","start","break"]);
			level1.push(["none","none","none","break","none","none","none","none"]);
			level1.push(["none","none","none","none","none","none","none","none"]);
			level1.push(["break","none","none","none","none","none","none","none"]);
			_levels1.push(level1);
			level2 =  new Array();
			level2.push(["none","none","none","block","none","none","start","none"]);
			level2.push(["block","none","none","none","none","break","end","none"]);
			level2.push(["none","none","none","none","none","none","none","block"]);
			level2.push(["none","none","none","none","none","none","block","none"]);
			level2.push(["none","none","break","none","none","none","none","none"]);
			level2.push(["none","block","none","block","none","none","none","none"]);
			level2.push(["none","none","none","none","none","block","none","none"]);
			level2.push(["none","none","none","none","block","none","none","none"]);
			level2.push(["none","none","none","break","none","block","none","none"]);
			_levels2.push(level2);
			//hard = 6
			level1 =  new Array();
			level1.push(["none","none","block","none","none","none","end","none"]);
			level1.push(["none","none","none","none","none","block","none","none"]);
			level1.push(["none","break","none","break","none","start","none","none"]);
			level1.push(["none","block","none","block","none","none","none","none"]);
			level1.push(["none","block","none","none","none","none","none","none"]);
			level1.push(["none","none","none","none","none","none","none","none"]);
			level1.push(["none","none","block","block","none","none","block","none"]);
			level1.push(["none","none","none","none","none","none","none","none"]);
			level1.push(["none","none","none","none","block","none","none","block"]);
			_levels1.push(level1);
			level2 =  new Array();
			level2.push(["break","block","none","none","none","none","none","none"]);
			level2.push(["start","none","none","none","none","none","none","none"]);
			level2.push(["none","none","none","block","none","none","none","none"]);
			level2.push(["none","none","none","none","none","none","none","none"]);
			level2.push(["none","none","none","none","none","none","none","none"]);
			level2.push(["none","none","none","none","block","none","end","none"]);
			level2.push(["none","none","none","none","none","none","none","none"]);
			level2.push(["none","none","none","none","none","none","none","block"]);
			level2.push(["none","break","none","none","none","none","none","none"]);
			_levels2.push(level2);
		}
	}
}

//////////////// NO BREAK


//hard = 2
//--------level1.push([ 0
//levels1: none,none,none,none,"end",none,none,none
//levels1: none,none,none,none,none,none,none,none
//levels1: none,none,none,none,none,none,none,none
//levels1: none,none,break,none,none,none,none,none
//levels1: none,none,none,none,none,none,none,none
//levels1: break,"block",none,none,none,none,none,break
//levels1: none,none,"block",none,none,none,"block",none
//levels1: none,none,"start",none,"block",none,none,none
//levels1: break,none,none,none,none,none,none,none
//-----LEVELS  2:  0
//levels2: none,none,none,"block","block",none,none,"block"
//levels2: none,none,none,none,none,break,none,none
//levels2: break,none,"block",none,none,none,"block",none
//levels2: none,none,none,"block",none,none,none,none
//levels2: none,none,none,none,none,none,none,"block"
//levels2: none,none,"block",none,none,none,none,none
//levels2: none,"end",none,none,none,none,none,none
//levels2: none,break,"start",none,none,none,none,none
//levels2: "block",none,"block",none,none,none,none,none

//hard=3
//	--------LEVELS1:  0
//levels1: "block",none,none,none,none,none,none,none
//levels1: none,none,none,none,none,none,"block",none
//levels1: none,"block",none,none,none,none,none,none
//levels1: none,none,"end",none,none,"block",none,none
//levels1: none,none,"block",none,"start",none,none,none
//levels1: "block",none,none,none,none,none,"block",none
//levels1: "block",none,none,none,"block","block",none,"block"
//levels1: none,none,none,none,none,none,none,none
//levels1: none,none,"block",none,none,none,none,none
//-----LEVELS  2:  0
//levels2: "block",none,none,none,none,"block",none,none
//levels2: none,none,none,none,none,none,none,none
//levels2: none,none,none,none,none,"start",none,none
//levels2: none,none,none,none,none,"end","block",none
//levels2: none,none,none,none,none,none,none,none
//levels2: none,"block",none,none,none,none,none,none
//levels2: none,none,none,none,none,none,none,"block"
//levels2: none,none,none,none,none,none,none,none
//levels2: none,none,none,none,none,none,none,none




// WITH BREAK




