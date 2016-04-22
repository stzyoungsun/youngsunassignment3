package
{
	import flash.display.Bitmap;
	import flash.display.PNGEncoderOptions;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	public class SaveToFile
	{
		
		
		private var _fileStream:FileStream = new FileStream(); 
		private var _saveFile:File = new File(); 
		
		private var _spriteSheetBitmaps : Vector.<Bitmap>;
		private var _spriteSheetRects :  Vector.<Vector.<Rectangle>>;
		private var _spriteSheetNames : Vector.<Array>;
		
		
		
		public function SaveToFile(bitmaps:Vector.<Bitmap>, spriteSheetRects : Vector.<Vector.<Rectangle>>, spriteSheetNames : Vector.<Array>)
		{
			_saveFile = File.applicationDirectory;
			_saveFile.addEventListener(Event.SELECT, onSelectHandler);
			_saveFile.browseForDirectory("저장 할 png, xml의 폴더를 선택해주세요. (우측하단의 폴더선택을 눌러주세요!!)");
		
			_spriteSheetBitmaps = bitmaps;
			_spriteSheetRects = spriteSheetRects;
			_spriteSheetNames = spriteSheetNames;
		}
		/**
		 * 
		 * @param bitmap 병합 된  bitmap
		 * Note @유영선 병합 된 bitmap을 PNGEncoder 라이브러리를 이용하여 png 변환 후 파일로 출력
		 * 
		 * 
		 * spriteSheetRect [sheet 개수][sheet 안에 이미지 개수의 위치 값] 의 이차원 벡터
		 * spriteSheetName [sheet 개수][sheet 안에 이미지 이름] 의 이차원 벡터
		 * 
		 */		

		private function onSelectHandler(e:Event):void
		{
			_saveFile.removeEventListener(Event.SELECT, onSelectHandler);
			var tempPath : String =  _saveFile.nativePath;
			
			 
			for(var i : int =0; i < _spriteSheetBitmaps.length; i++)
			{
				var bitmapByteArray:ByteArray = new ByteArray();
				_spriteSheetBitmaps[i].bitmapData.encode(new Rectangle(0,0,_spriteSheetBitmaps[i].width,_spriteSheetBitmaps[i].height), new PNGEncoderOptions(), bitmapByteArray);
				_saveFile.nativePath += "\\Sprite_Sheet"+i+".png";
				_fileStream.open(_saveFile, FileMode.WRITE);
				_fileStream.writeBytes(bitmapByteArray);
				_saveFile.nativePath = tempPath;
				_fileStream.close();
			}
			
			for(var j : int = 0; j< _spriteSheetNames.length; j++)
			{
				_saveFile.nativePath += "\\Sprite_Sheet"+j+".xml";
				_fileStream.open(_saveFile, FileMode.WRITE);
				_fileStream.writeUTFBytes("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
				_fileStream.writeUTFBytes("<TextureAtlas ImagePath=\"" + "sprite_sheet"+j+".png" + "\">\n");
				for(var k : int = 0; k< _spriteSheetNames[j].length; k++)
				{
					_fileStream.writeMultiByte("<SubTexture name=\"" + _spriteSheetNames[j][k] + "\" x=\"" + _spriteSheetRects[j][k].x 
						+ "\" y=\"" + _spriteSheetRects[j][k].y + "\" width=\"" + _spriteSheetRects[j][k].width + "\" height=\"" + _spriteSheetRects[j][k].height + " \"/>\n","EUC-KR");
				}
				_fileStream.writeUTFBytes("</TextureAtlas>");
				_fileStream.close();
				_saveFile.nativePath = tempPath;
			}
			
		}
	}
}