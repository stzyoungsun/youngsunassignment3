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
		public static const MAC_PIECE_COUNT : int = 40;
		
		private var _picecBitmapDictionary : Dictionary = new Dictionary();
		
		private var _completeFunction:Function;
		private var _progressFunction:Function;
		
		/**
		 * 
		 * @param completeFunction Mainclass의 완료 함수
		 * @param progressFunction Mainclass의 동작 중 함수
		 * Note @유영선 이미지데이터를 piece+번호 이런식으로 로딩
		 */		
		public function LoaderImage(completeFunction:Function, progressFunction : Function)
		{
			_pieceLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			
			_pieceLoader.load(new URLRequest("PieceImage/piece"+ String(sCurrentCount) + ".png"));
			
			_completeFunction = completeFunction;
			_progressFunction = progressFunction;
		}
		/**
		 * 
		 * @param e
		 * Note @유영선 한 이미지가 완료 후 다른 이미지 로딩 진행
		 */		
		private function onLoadComplete(e:Event):void
		{
			chedckedImage();
			_pieceLoader.load(new URLRequest("PieceImage/piece"+ String(sCurrentCount) + ".png"));
			
		}
		/**
		 * 
		 * Note @유영선 이미지가 모두 로딩 된 후에 Mainclass에 완료 함수 호출
		 */		
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