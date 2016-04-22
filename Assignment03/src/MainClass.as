package
{

	public class MainClass
	{
		private var _cLoaderImage : LoaderImage;
		private var _cMakeSpriteSheet : MakeSpriteSheet;
	
		private var _onInitializeComplete : Function;
		private var _cSaveToFile : SaveToFile;
		
		public function MainClass()
		{
			
		}
		/**
		 * 
		 * @param outMainTexture 화면에 로딩 화면 출력 하기 위한 함수 호출
		 * @param outMainBitmap  화면에 병합된 bitmap 출력하기 위한 함수 호출
		 * Note @유영선 
		 */		
		public function initialize (onInitializeComplete:Function) : void
		{
			_onInitializeComplete= onInitializeComplete;
			
			_cLoaderImage = new LoaderImage(completeLoadImage);
		}
		
		/**
		 * Note @유영선 이미지 로드가 모두 완료 후 호출 되는 함수
		 * 
		 */		
		public function completeLoadImage() : void
		{
			_cMakeSpriteSheet = new MakeSpriteSheet(_cLoaderImage.getBitmap());
			_onInitializeComplete(_cMakeSpriteSheet.getSheet());
			
			_cSaveToFile = new SaveToFile(_cMakeSpriteSheet.getSheet(),_cMakeSpriteSheet.getSheetRect(), _cMakeSpriteSheet.getSheetName());
			
		}
	}
}