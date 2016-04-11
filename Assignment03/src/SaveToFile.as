package
{
	import flash.display.Bitmap;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	public class SaveToFile
	{
		private var _pngFile:File = File.documentsDirectory.resolvePath("sprite_sheet.png");
		private var _xmlFile:File = File.documentsDirectory.resolvePath("sprite_sheet.xml");
		private var _fileStream:FileStream = new FileStream(); 
		
		public function SaveToFile()
		{
		}
		/**
		 * 
		 * @param bitmap 병합 된  bitmap
		 * Note @유영선 병합 된 bitmap을 PNGEncoder 라이브러리를 이용하여 png 변환 후 파일로 출력
		 */		
		public function saveToPNG(bitmap:Bitmap):void
		{
			var byteArray:ByteArray = PNGEncoder.encode(bitmap.bitmapData);
			
			_fileStream.open(_pngFile, FileMode.WRITE);
			_fileStream.writeBytes(byteArray);
			_fileStream.close();
		}
		/**
		 * 
		 *Note @유영선 XML 형태에 맞게 File 입출력
		 */		
		public function exportToXML():void
		{
			_fileStream.open(_xmlFile, FileMode.WRITE);
			_fileStream.writeUTFBytes("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
			_fileStream.writeUTFBytes("<TextureAtlas ImagePath=\"" + "sprite_sheet.png" + "\">\n");
			
			for(var i:int = 0; i<Node.sImageRectVetor.length; ++i)
			{
				//name Node.
				_fileStream.writeMultiByte("<SubTexture name=\"" + Node.sImageNameArray[i] + "\" x=\"" + Node.sImageRectVetor[i].x 
					+ "\" y=\"" + Node.sImageRectVetor[i].y + "\" width=\"" + Node.sImageRectVetor[i].width + "\" height=\"" + Node.sImageRectVetor[i].height + " \"/>\n","EUC-KR");
			}
			_fileStream.writeUTFBytes("</TextureAtlas>");
			_fileStream.close();
			
		}
	}
}