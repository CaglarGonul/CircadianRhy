package  {
	import com.ideakup.ColorLabels;
	import com.ideakup.FluctGrid;
	import com.ideakup.FluctGridItem;
	import com.ideakup.RummiPieceMC;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	import com.ideakup.CustomizeGrid;

	public class TestFluctGridClass extends Sprite {
		
		private var _fluctGrid:FluctGrid;
		private var _board:Billiard = new Billiard();
		private var _pieceLabels:Array = new Array();
		private var _shuffledPieceLabels:Array = new Array();
		private var _rummiPieces:Array = new Array(); //For storing rum piece movie clips.
		private var _sampleGrid:FluctGrid;
		
		public function TestFluctGridClass() {
			placeBoard();
			initPieces();
			shufflePieces();
			createRummiPieces();
			showASampleGrid();
		}
		
		private function placeBoard():void {
			_board.x = (700 / 2) - (_board.width / 2);
			_board.y = 125;
			addChild(_board);
		}
		
		private function initPieces():void {
			var frontLabels:Array = [ColorLabels.Red, ColorLabels.Blue, ColorLabels.Yellow, ColorLabels.Orange];
			for (var i:int = 0; i < frontLabels.length; i++) {
				for (var j:int = 1; j <=13 ; j++) {
					_pieceLabels.push(frontLabels[i] + j.toString());
				}
			}
		}
				
		private function shufflePieces():void {
			while (_pieceLabels.length > 0) {
				var r:int = Math.floor(Math.random() * _pieceLabels.length);
				_shuffledPieceLabels.push(_pieceLabels[r]);
				_pieceLabels.splice(r, 1);
			}
		}
		
		private function createRummiPieces():void {
			for (var i:int = 0; i < 17; i++) {
				var rummiPiece:RummiPieceMC = new RummiPieceMC();
				rummiPiece.labelOn = _shuffledPieceLabels[i];
				var labelClass:Class = getDefinitionByName(_shuffledPieceLabels[i]) as Class;
				var label:MovieClip = new labelClass();
				label.x = rummiPiece.width / 2 - label.width / 2 + 3;
				label.y = 2;
				rummiPiece.addChild(label);
				_rummiPieces.push(rummiPiece);
			}
			
		}

		private function showASampleGrid():void {
			_sampleGrid = new FluctGrid(2, 14, CustomizeGrid.HEIGHT, CustomizeGrid.WIDTH, 2.6);
			for (var i:int = 0; i < 28; i++) {
				var oneFluctItmToBeAddedToGrid:FluctGridItem = new FluctGridItem(_rummiPieces[i] as RummiPieceMC);
				_sampleGrid.addElement(oneFluctItmToBeAddedToGrid);
			}
			_sampleGrid.x = (700 / 2) - (_board.width / 2) + 12;
			_sampleGrid.y = 123 ;
			addChild(_sampleGrid);
		}

	}

}