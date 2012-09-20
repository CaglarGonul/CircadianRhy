package com.ideakup {
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	public class FluctGrid extends Sprite {
		public var _tweenTime:Number = 0.5;
		private var _rows:int;
		private var _cols:int;
		private var _padd:int;
		private var _rowSize:int;
		private var _colSize:int;
		private var _index:Array;
		private var _items:Array;
		private var _numItems:int;
		private var _dictionary:Dictionary;
		private var _currentItem:FluctGridItem;
		
		public function FluctGrid(rows:int, cols:int, rowSize:int, colSize:int, padding:Number = 0) {
			_rows = rows;
			_cols = cols;
			_padd = padding;
			_rowSize = rowSize;
			_colSize = colSize;
			_numItems = 0;
			
			initElements();
		}
		
		private function initElements():void {
			_dictionary = new Dictionary();
			_index = new Array(_rows);
			_items = [];
			for (var i:int = 0; i < _rows; i++) {
				_index[i] = new Array(_cols);
			}
		}
		
		public function addElementWithMeta() {
			
		}
	}

}