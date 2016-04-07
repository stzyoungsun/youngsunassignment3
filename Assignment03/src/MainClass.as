package
{
	import flash.text.TextField;
	
	import LoaderImage;
	
	import MakeSpriteSheet;
	
	public class MainClass
	{
		private var _cLoaderImage : LoaderImage;
		private var _cMakeSpriteSheet : MakeSpriteSheet;
		
		private  var _completeLoadImage : Function;
		private  var _progressLoadImage : Function;
		
		private var _progressTextField : TextField; 
		private var _progressText : String = "";
		
		private var _outMainTexture : Function;
		private var _outMainBitmap : Function;
		
		public function MainClass()
		{
			
		}
		
		public function initialize (outMainTexture:Function,outMainBitmap:Function) : void
		{
			_outMainTexture=outMainTexture;
			_outMainBitmap=outMainBitmap;
			
			_progressTextField = new TextField();
			_progressTextField.width = 200;
			_progressTextField.height = 200;
			_progressTextField.x = 100;
			_progressTextField.y = 100;
			_progressTextField.text = _progressText;
			_progressTextField.border = true;
			outMainTexture(_progressTextField);
			
			_completeLoadImage = completeLoadImage;
			_progressLoadImage = progressLoadImage;
			
			_cLoaderImage = new LoaderImage(_completeLoadImage,_progressLoadImage);
			
		}
		
		public function completeLoadImage() : void
		{
			_progressText = "로딩 완료";
			_progressTextField.text = _progressText;
			
			_cMakeSpriteSheet = new MakeSpriteSheet(_cLoaderImage.getBitmap());
			_outMainBitmap(_cLoaderImage.getBitmap()["piece001.png"]);
		}
		
		public function progressLoadImage(progressCount : int) : void
		{
			_progressText = "로딩 중 : " + String(progressCount);
			
			_progressTextField.text = _progressText;	
		}
	}
}