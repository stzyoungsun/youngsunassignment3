package
{
	import flash.events.Event;
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
		private var _addButton : Function;
	
		public function MainClass()
		{
			
		}
		/**
		 * 
		 * @param outMainTexture 화면에 로딩 화면 출력 하기 위한 함수 호출
		 * @param outMainBitmap  화면에 병합된 bitmap 출력하기 위한 함수 호출
		 * Note @유영선 
		 */		
		public function initialize (outMainTexture:Function, addButton:Function) : void
		{
			_outMainTexture=outMainTexture;
			_addButton=addButton;
			
			_progressTextField = new TextField();
			_progressTextField.width = 150;
			_progressTextField.height = 150;
			_progressTextField.x = 130;
			_progressTextField.y = 370;
			_progressTextField.text = _progressText;
			_outMainTexture(_progressTextField);
			
			_completeLoadImage = completeLoadImage;
			_progressLoadImage = progressLoadImage;
			
			_cLoaderImage = new LoaderImage(_completeLoadImage,_progressLoadImage);
			
		}
		
		public function onClickButton(e:Event) : void
		{
			

			_progressText = "Sprite Sheet 제작 완료\n내문서를 확인 해주세요.";
			_progressTextField.text = _progressText;
			
			_cMakeSpriteSheet = new MakeSpriteSheet(_cLoaderImage.getBitmap());
			_cMakeSpriteSheet.getSheet();
		}
		/**
		 * Note @유영선 이미지 로드가 모두 완료 후 호출 되는 함수
		 * 
		 */		
		public function completeLoadImage() : void
		{
			_progressText = "로딩 완료";
			_progressTextField.text = _progressText;
			_addButton(130,410,"Make Sprite-Sheet")
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