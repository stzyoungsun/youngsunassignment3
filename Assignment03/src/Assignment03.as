package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import MainClass;
	[SWF(width="1024", height="1024", frameRate="60", backgroundColor="#ffffff")]
	
	public class Assignment03 extends Sprite
	{
		private var _cMainClass : MainClass = new MainClass();
	
		public function Assignment03()
		{
			_cMainClass.initialize(outTextField, outBitmap);
		}
		
		/**
		 * 
		 * @param textField 로딩 텍스트
		 * Note @유영선 이미지  로딩 화면 출력 
		 */		
		public function outTextField(textField : TextField ) : void
		{
			addChild(textField);
		}
		/**
		 * 
		 * @param bitmap 병합된 bitmap
		 * Note @유영선 병합된 bitmap 화면 출력
		 */		
		public function outBitmap(bitmap : Bitmap) : void
		{
			addChild(bitmap);
		}
	
	}
}