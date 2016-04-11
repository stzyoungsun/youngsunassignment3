package
{
	import flash.display.Bitmap;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.geom.Rectangle;
	
	public class SaveToFile
	{
		
		
		private var _fileStream:FileStream = new FileStream(); 
		
		public function SaveToFile()
		{
		}
		/**
		 * 
		 * @param bitmap 병합 된  bitmap
		 * Note @유영선 병합 된 bitmap을 PNGEncoder 라이브러리를 이용하여 png 변환 후 파일로 출력
		 */		
		public function saveToPNG(bitmap:Vector.<Bitmap>):void
		{
		   var pngFile:File; 
			for(var i : int =0; i < bitmap.length; i++)
			{
				pngFile = File.documentsDirectory.resolvePath("sprite_sheet["+i+"].png");
				var byteArray:ByteArray = PNGEncoder.encode(bitmap[i].bitmapData);
				
				_fileStream.open(pngFile, FileMode.WRITE);
				_fileStream.writeBytes(byteArray);
				_fileStream.close();
			}	
		}
		/**
		 * 
		 * @param spriteSheetRect [sheet 개수][sheet 안에 이미지 개수의 위치 값] 의 이차원 벡터
		 * @param spriteSheetName [sheet 개수][sheet 안에 이미지 이름] 의 이차원 벡터
		 * 
		 */		
		public function exportToXML(spriteSheetRect : Vector.<Vector.<Rectangle>>,spriteSheetName : Vector.<Array>):void
		{
			for(var i : int = 0; i< spriteSheetName.length; i++)
			{
				var xmlFile:File = File.documentsDirectory.resolvePath("sprite_sheet["+i+"].xml");
				_fileStream.open(xmlFile, FileMode.WRITE);
				_fileStream.writeUTFBytes("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
				_fileStream.writeUTFBytes("<TextureAtlas ImagePath=\"" + "sprite_sheet["+i+"].png" + "\">\n");
				for(var j : int = 0; j< spriteSheetName[i].length; j++)
				{
					_fileStream.writeMultiByte("<SubTexture name=\"" + spriteSheetName[i][j] + "\" x=\"" + spriteSheetRect[i][j].x 
						+ "\" y=\"" + spriteSheetRect[i][j].y + "\" width=\"" + spriteSheetRect[i][j].width + "\" height=\"" + spriteSheetRect[i][j].height + " \"/>\n","EUC-KR");
				}
				_fileStream.writeUTFBytes("</TextureAtlas>");
				_fileStream.close();
			}
		}
	}
}