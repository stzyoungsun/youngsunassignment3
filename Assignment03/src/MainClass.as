package
{
	import flash.text.TextField;
	
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
		/**
		 * 
		 * @param outMainTexture 화면에 로딩 화면 출력 하기 위한 함수 호출
		 * @param outMainBitmap  화면에 병합된 bitmap 출력하기 위한 함수 호출
		 * Note @유영선 
		 */		
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
		/**
		 * Note @유영선 이미지 로드가 모두 완료 후 호출 되는 함수
		 * 
		 */		
		public function completeLoadImage() : void
		{
			_progressText = "로딩 완료";
			_progressTextField.text = _progressText;
			
			_cMakeSpriteSheet = new MakeSpriteSheet(_cLoaderImage.getBitmap());
			
			_outMainBitmap(_cMakeSpriteSheet.getSheet());
		}
		/**
		 * 
		 * @param progressCount 로드가 완료 된 숫자
		 * 이미지 로드 중에 호출 되는 함수
		 */		
		public function progressLoadImage(progressCount : int) : void
		{
			_progressText = "로딩 중 : " + String(progressCount);
			
			_progressTextField.text = _progressText;	
		}
	}
}