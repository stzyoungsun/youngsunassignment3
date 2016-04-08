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
		
		public function outTextField(textField : TextField ) : void
		{
			addChild(textField);
		}
		
		public function outBitmap(bitmap : Bitmap) : void
		{
			addChild(bitmap);
		}
	
	}
}