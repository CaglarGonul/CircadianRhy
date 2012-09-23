package com.ideakup {
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
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
		
		private function getCellCoord(x : Number, y : Number) : Point {
			var cell : Point = new Point();
			
			cell.x = Math.max(0, Math.min(_cols - 1, Math.round(x / (_colSize + _padd))));
			cell.y = Math.max(0, Math.min(_rows - 1, Math.round(y / (_rowSize + _padd))));
			
			return cell;
		}
		
		private function getPosition(row:int, col:int):Point {
			return new Point(col * (_colSize + _padd), row * (_rowSize + _padd));
		}
		
		public function getItemAtPosition(row : int, col : int) : FluctGridItem {
			return _index[row][col];
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
			
			item.addEventListener(MouseEvent.MOUSE_DOWN, onItemPress);
			item.addEventListener(MouseEvent.MOUSE_UP, onItemRelease);
		}
		
		private function onItemPress(e:MouseEvent):void {
			_currentItem = e.currentTarget as FluctGridItem;
			_currentItem.startDrag();
			addChild(_currentItem);
		}
		
		private function onItemRelease(e:MouseEvent):void {
			if (_currentItem != null) {
				_currentItem.stopDrag();
				arrangeItems();
				snapToGrid(_dictionary[_currentItem]);
			}
		}
		
		private function arrangeItems():void {
			var itemSelected:FluctGridItem = _dictionary[_currentItem];
			var cellToBeDraggedOn:Point = getCellCoord(_currentItem.x, _currentItem.y);
			
			var intialCol:int = itemSelected.col;
			var intialRow:int = itemSelected.row;
			
			var colToBeDraggedOn:int = cellToBeDraggedOn.x;
			var rowToBeDraggedOn:int = cellToBeDraggedOn.y;
			
			if (colToBeDraggedOn == itemSelected.col && rowToBeDraggedOn == itemSelected.row) {
				return;
			}
			
			var hMove:int = colToBeDraggedOn - itemSelected.col;
			var vMove:int = rowToBeDraggedOn - itemSelected.row;
			
			var i:int;
			var itemTemp:FluctGridItem;
			var move:Array = [];
			
			if (!isCellOcuppied(rowToBeDraggedOn, colToBeDraggedOn)) {
				
				itemTemp = _index[rowToBeDraggedOn][colToBeDraggedOn];
				
				itemSelected.row = rowToBeDraggedOn;
				itemSelected.col = colToBeDraggedOn;
				snapToGrid(itemSelected);
				_index[rowToBeDraggedOn][colToBeDraggedOn] = itemSelected;
				
				insertBlankItemAt(intialRow, intialCol);
				
				return;
			}
			
			if (hMove < 0) {
				for (i = itemSelected.col - 1; i >= itemSelected.col + hMove; i--) {
					if (_index[itemSelected.row][i]) {
						itemTemp = _index[itemSelected.row][i];
						itemTemp.col++;
						
						_index[itemTemp.row][itemTemp.col] = itemTemp;
						move.push(itemTemp);
					}
				}
			} else {
				for (i = itemSelected.col + 1; i <= itemSelected.col + hMove; i++) {
					if (_index[itemSelected.row][i]) {
						itemTemp = _index[itemSelected.row][i];
						itemTemp.col--;
						
						_index[itemTemp.row][itemTemp.col] = itemTemp;
						move.push(itemTemp);
					}
				}
			}
			
			if (vMove < 0) {
				for (i = itemSelected.row - 1; i >= itemSelected.row + vMove; i--) {
					if (_index[i][itemSelected.col + hMove]) {
						itemTemp = _index[i][itemSelected.col + hMove];
						itemTemp.row++;
						
						_index[itemTemp.row][itemTemp.col] = itemTemp;
						move.push(itemTemp);
					}
				}
			} else {
				for (i = itemSelected.row + 1; i <= itemSelected.row + vMove; i++) {
					if (_index[i][itemSelected.col + hMove]) {
						itemTemp = _index[i][itemSelected.col + hMove];
						itemTemp.row--;
						
						_index[itemTemp.row][itemTemp.col] = itemTemp;
						move.push(itemTemp);
					}
				}
			}
			
			for (i = 0; i < move.length; i++) {
				snapToGrid(move[i]);
			}
			
			itemSelected.row = rowToBeDraggedOn;
			itemSelected.col = colToBeDraggedOn;
			
			_index[rowToBeDraggedOn][colToBeDraggedOn] = itemSelected;
		}
		
		private function snapToGrid(item : FluctGridItem) : void {
			var pos : Point = getPosition(item.row, item.col);
			TweenLite.to(item, _tweenTime, {x:pos.x, y:pos.y, ease:Expo.easeInOut});
		}
		
		private function isCellOcuppied(row:int, col:int) : Boolean {
			var check:FluctGridItem = getItemAtPosition(row, col);
			if (check.itemonme == null) {
				return false;
			}
			else {
				return true;
			}
		}
		
		private function insertBlankItemAt(row:int, col:int):void  {
			var item:FluctGridItem = new FluctGridItem(null);
			item.row = row;
			item.col = col;
			_index[row][col] = item;
		}
	
	}

}