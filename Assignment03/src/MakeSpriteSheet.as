package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	
	public class MakeSpriteSheet
	{	
		public static const MAX_SHEET_WIDTH :int = 1024;
		public static const MAX_SHEET_HEIGHT :int = 1024;
		
		private var _pieceImage : Dictionary = new Dictionary();
		
		private var _cBinaryTree : BinaryTree;
		private var _cIDBitmap : IDBitmap;
		private var _cSaveToFile : SaveToFile = new SaveToFile();
		
		private var _spriteSheet : BitmapData = new BitmapData(MAX_SHEET_WIDTH,MAX_SHEET_HEIGHT);
		private var _bitmap : Bitmap;
		private var _imagePos : Point = new Point(0,0);
		private var _pieceBitmap : Vector.<IDBitmap> = new Vector.<IDBitmap>;
		
		public function MakeSpriteSheet(pieceImage : Dictionary)
		{
			_pieceImage = pieceImage;
			sortImage();
			setPacking();
			_bitmap = new Bitmap(_spriteSheet);
			
		}
		/**
		 *Note @유영선 로드 된 이미지 데이터를 크기 별로 정렬 하는 함수 
		 * -> 크기 별로 정렬 하면 병합 알고리즘의 성능이 더 높아 지기 때문에 정렬을 하였습니다
		 */		
		private function sortImage() : void
		{
			var imageTemp : Vector.<Bitmap> = new Vector.<Bitmap>;
			
			for(var i : int=1; i<=LoaderImage.MAC_PIECE_COUNT; i++)
			{
				_cIDBitmap = new IDBitmap(_pieceImage["piece" + i + ".png"],i);
				_pieceBitmap[i-1] = _cIDBitmap;
			}
			_pieceBitmap.sort(orderAbs);
			
			function orderAbs(image1:IDBitmap, image2:IDBitmap):int		
			{
				if(image1.getBitmap().width * image1.getBitmap().height< image2.getBitmap().width * image2.getBitmap().height)
					return 1;
				else if(image1.getBitmap().width * image1.getBitmap().height > image2.getBitmap().width * image2.getBitmap().height)
					return -1;
				else
					return 0;	
			}
		}
		/**
		 *Note @유영선 Image 병합 시작 
		 * 이진 트리를 이용하여 큰 Bimap을 쪼개어 그 좌표 값을 이진트리로 만든후 중위 순회를 이용하여 이미지들의 좌표를 저장
		 * sheet에 평행 이동을 이용하여 저장 된 좌표에 출력
		 */		
		private function setPacking() : void
		{

			var rc :Rectangle = new Rectangle(0,0,MAX_SHEET_WIDTH,MAX_SHEET_HEIGHT);
			_cBinaryTree = new BinaryTree(rc);
			
			for(var i : int=0; i<LoaderImage.MAC_PIECE_COUNT; i++)
			{
				_cBinaryTree.insert(_pieceBitmap[i].getBitmap(),_pieceBitmap[i].getID(),_cBinaryTree.getroot());
			}
			_cBinaryTree.getroot().inOrder();
			
			for(var j : int=0; j<Node.sImageRectVetor.length; j++)
			{
				var imageMatrix:Matrix = new Matrix();
				trace("ImageID : "+Node.sImageIDArray[j]);
				trace("Image x: "+Node.sImageRectVetor[j].x);
				trace("Image y : "+Node.sImageRectVetor[j].y);
				_bitmap = _pieceImage["piece" + Node.sImageIDArray[j] + ".png"];
				
				imageMatrix.translate( Node.sImageRectVetor[j].x,Node.sImageRectVetor[j].y);
				_spriteSheet.draw(_bitmap,imageMatrix);
			}
			
		}
		public function getSheet() : Bitmap
		{
			_cSaveToFile.saveToPNG(_bitmap);
			_cSaveToFile.exportToXML();
			return _bitmap;
		}
		
	}
}