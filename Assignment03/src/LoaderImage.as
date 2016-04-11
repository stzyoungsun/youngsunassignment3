package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	public class LoaderImage
	{
		private var _pieceLoader : Loader = new Loader();
		
		public static var sFileNameVecotr : Vector.<String> = new Vector.<String>;
		public static var sCurrentCount : int = 1;
		public static var sImageMaxCount :int;
		
		private var _picecBitmapDictionary : Dictionary = new Dictionary();
		
		private var _completeFunction:Function;
		private var _progressFunction:Function;
		
		private var _urlArray:Array = new Array();					//파일명이 담긴 배열
		private var _imageDataArray:Array = new Array();			//ImageData가 담긴 배열 
		/**
		 * 
		 * @param completeFunction Mainclass의 완료 함수
		 * @param progressFunction Mainclass의 동작 중 함수
		 * Note @유영선 이미지데이터를 piece+번호 이런식으로 로딩
		 */		
		public function LoaderImage(completeFunction:Function, progressFunction : Function)
		{
			//_pieceLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			
			//_pieceLoader.load(new URLRequest("PieceImage/piece"+ String(sCurrentCount) + ".png"));
		
			_completeFunction = completeFunction;
			_progressFunction = progressFunction;
			
			resourceLoader();
		}
		/**
		 * 
		 * @param e
		 * Note @유영선 한 이미지가 완료 후 다른 이미지 로딩 진행
		 */		
		private function onLoadComplete(e:Event):void
		{
			var loaderInfo:LoaderInfo = LoaderInfo(e.target);
			
			var filename:String = loaderInfo.url;
			filename = decodeURIComponent(filename.substring(16, filename.length));
			sFileNameVecotr.push(filename);
			_picecBitmapDictionary[filename] =  e.target.content as Bitmap;
			chedckedImage();
		}
		/**
		 * 
		 * Note @유영선 이미지가 모두 로딩 된 후에 Mainclass에 완료 함수 호출
		 */		
		private function chedckedImage() : void
		{
			
			trace(sCurrentCount);
			if(sCurrentCount == sImageMaxCount) 
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
		
		public function resourceLoader() : void
		{
			var array:Array = new Array();
			array = getResource();
			findOnlyImageFile(array);
			buildLoader();
		}
		/**
		 * 
		 * @return 
		 * 불러올 폴더명 지정
		 */		
		private function getResource():Array
		{
			var directory:File = File.applicationDirectory.resolvePath("PieceImage");
			var array:Array = directory.getDirectoryListing();			
			
			return array;
		}
		/**
		 * 
		 * @param resourceArray 저장
		 * 폴더에서 jpg,png파일만 array에 저장
		 */		
		private function findOnlyImageFile(resourceArray:Array):void
		{			
			for(var i:int = 0; i<resourceArray.length; ++i)
			{				
				
				var url:String = resourceArray[i].url; 
				
				var extension:String = url.substr(url.lastIndexOf(".") + 1, url.length);
				
				if(extension == "png" || extension == "jpg")
				{
					url = url.substring(5, url.length);	
					
					_urlArray.push(decodeURIComponent(url));					
					
				}
			}
		}
		/**
		 *이미지 로더 수행 
		 * 
		 */		
		private function buildLoader():void
		{
			sImageMaxCount =_urlArray.length;   
			for(var i:int = 0; i<_urlArray.length; ++i)
			{
				var loader:Loader = new Loader();
				
				loader.load(new URLRequest(_urlArray[i]));
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);				
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