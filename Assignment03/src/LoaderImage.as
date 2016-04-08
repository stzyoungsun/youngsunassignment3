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
		public static const MAC_PIECE_COUNT : int = 33;
		
		private var _picecBitmapDictionary : Dictionary = new Dictionary();
		
		private var _completeFunction:Function;
		private var _progressFunction:Function;
		
		
		public function LoaderImage(completeFunction:Function, progressFunction : Function)
		{
			_pieceLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			
			_pieceLoader.load(new URLRequest("PieceImage/piece"+ String(sCurrentCount) + ".png"));
			
			_completeFunction = completeFunction;
			_progressFunction = progressFunction;
		}
		
		private function onLoadComplete(e:Event):void
		{
			chedckedImage();
			_pieceLoader.load(new URLRequest("PieceImage/piece"+ String(sCurrentCount) + ".png"));
			
			
		}
		
		private function chedckedImage() : void
		{
			_picecBitmapDictionary["piece"+ String(sCurrentCount) + ".png"] =  _pieceLoader.content as Bitmap;
			
			trace(sCurrentCount);
			if(sCurrentCount == MAC_PIECE_COUNT) 
			{
				_completeFunction();
				clearLoader();
				return;
			}
			else
			{
				sCurrentCount++;
				_progressFunction(sCurrentCount);
			}
		}	
		
		private function clearLoader() : void
		{
			_pieceLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			_pieceLoader.unload();
		}
		
		public function getBitmap() : Dictionary
		{
			return _picecBitmapDictionary;
		}
	}
}