package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	
	
	public class LoaderImage
	{
		private var _pieceLoader : Loader = new Loader();
		
		public static var sCurrentCount : int = 1;
		public static const MAC_PIECE_COUNT : int = 7;
		
		private var _PicecTextureDictionary : Dictionary = new Dictionary();
		
		private var _completeFunction:Function;
		private var _progressFunction:Function;
		
		
		public function LoaderImage(completeFunction:Function, progressFunction : Function)
		{
			_pieceLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			
			_pieceLoader.load(new URLRequest("PieceImage/piece00"+ String(sCurrentCount) + ".png"));
			
			_completeFunction = completeFunction;
			_progressFunction = progressFunction;
		}
		
		private function onLoadComplete(e:Event):void
		{
			if(sCurrentCount == MAC_PIECE_COUNT) 
			{
				_completeFunction();
				clearLoader();
				return;
			}
				
			chedckedImage();
			_pieceLoader.load(new URLRequest("PieceImage/piece00"+ String(sCurrentCount) + ".png"));
			
		}
		
		private function chedckedImage() : void
		{
			_PicecTextureDictionary["piece00"+ String(sCurrentCount) + ".png"] =  _pieceLoader.content as Bitmap;
			_progressFunction(sCurrentCount);
			
			sCurrentCount++;
			trace(sCurrentCount);
		}	
		
		private function clearLoader() : void
		{
			_pieceLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			_pieceLoader.unload();
		}
		
		public function getBitmap() : Dictionary
		{
			return _PicecTextureDictionary;
		}
	}
}