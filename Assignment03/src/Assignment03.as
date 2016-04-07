package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import MainClass;
	
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