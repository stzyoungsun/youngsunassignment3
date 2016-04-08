package
{
	import flash.display.Bitmap;

	public class IDBitmap
	{
		private var _bitmap : Bitmap;
		private var _id : int;
		public function IDBitmap(bitmap:Bitmap, ID:int)
		{
			_bitmap = bitmap;
			_id = ID;
		}
		
		public function getBitmap() : Bitmap
		{
			return _bitmap;
		}
		public function getID() : int
		{
			return _id;
		}
	}
}