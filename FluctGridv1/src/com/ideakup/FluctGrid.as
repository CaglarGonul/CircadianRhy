package com.ideakup {
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import flash.geom.Point;
	
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
		
		private function getPosition(row:int, col:int):Point {
			return new Point(col * (_colSize + _padd), row * (_rowSize + _padd));
		}
		
		private function initElements():void {
			_dictionary = new Dictionary();
			_index = new Array(_rows);
			_items = [];
			for (var i:int = 0; i < _rows; i++) {
				_index[i] = new Array(_cols);
			}
		}
		
		public function addElement(item:FluctGridItem):void {
			var col:int = _numItems % _cols;
			var row:int = Math.floor(_numItems / _cols);
			
			var position:Point = getPosition(row, col);
			
			item.row = row;
			item.col = col;
			
			item.x = position.x;
			item.y = position.y;
		
			item.mouseEnabled = true;
			item.buttonMode = false;
			
			addChild(item);
			_items.push(item);
			
			_index[row][col] = item;
			_dictionary[item] = item;
			_numItems++;
		}
	}

}