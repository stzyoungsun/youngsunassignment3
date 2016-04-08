package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import BinaryTree;
	import LoaderImage;
	import Node;
	import IDBitmap;
	
	public class MakeSpriteSheet
	{	
		public static const MAX_SHEET_WIDTH :int = 1024;
		public static const MAX_SHEET_HEIGHT :int = 1024;
		
		private var _pieceImage : Dictionary = new Dictionary();
		private var _cBinaryTree : BinaryTree;
		private var _cIDBitmap : IDBitmap;
		
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
		private function setPacking() : void
		{

			var rc :Rectangle = new Rectangle(0,0,MAX_SHEET_WIDTH,MAX_SHEET_HEIGHT);
			_cBinaryTree = new BinaryTree(rc);
			
			for(var i : int=0; i<LoaderImage.MAC_PIECE_COUNT; i++)
			{
				_cBinaryTree.insert(_pieceBitmap[i].getBitmap(),_pieceBitmap[i].getID(),_cBinaryTree.getroot());
			}
			_cBinaryTree.getroot().inOrder();
			
			
			
			for(var j : int=0; j<LoaderImage.MAC_PIECE_COUNT; j++)
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
			return _bitmap;
		}
		
	}
}