package com.ideakup {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class FluctGridItem extends Sprite {
		
		public var row:int;
		public var col:int;
		public var itemonme:MovieClip;
		
		public function FluctGridItem(piece:MovieClip) {
			if (piece != null) {
				itemonme = piece;
				addChild(itemonme);
			}
		}
	
	}

}