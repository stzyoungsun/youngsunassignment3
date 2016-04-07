package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;

	public class MakeSpriteSheet
	{
		private var _pieceImage : Dictionary = new Dictionary();
		
		public function MakeSpriteSheet(pieceImage : Dictionary)
		{
			_pieceImage = pieceImage;
 			trace(pieceImage["piece001.png"]);
			var bitmap : Bitmap = new Bitmap();
		}
		
		
	}
}