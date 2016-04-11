package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import MainClass;
	
	[SWF(width="2048", height="2048", frameRate="60", backgroundColor="#ffffff")]
	
	public class Assignment03 extends Sprite
	{	
		private var _TextField : TextField;
		private var _cMainClass : MainClass = new MainClass();
		private var _countSheet : int = 0;
		private var _spriteBitmap:  Vector.<Bitmap>;
		
		private var _nextButton:Sprite;
		private var _preButton:Sprite;
		private var _spriteSheet:Sprite = new Sprite();
		
		public function Assignment03()
		{
			_cMainClass.initialize(outTextField, outBitmap);
			//addEventListener(Event.,release);
		}
		
		/**
		 * 
		 * @param textField 로딩 텍스트
		 * Note @유영선 이미지  로딩 화면 출력 
		 */		
		public function outTextField(textField : TextField ) : void
		{
			_TextField = textField;
			addChild(_TextField);
		}
		/**
		 * 
		 * @param spriteBitmap sprite-sheet를 담고 있는 벡터
		 * Note @유영선 Sheet그릴 준비
		 */		
		public function outBitmap (spriteBitmap : Vector.<Bitmap>) : void
		{
			_spriteBitmap = spriteBitmap;
			removeChild(_TextField);
			
			printSheet();
			
			if(_spriteBitmap.length > 1)
			{
				_preButton = createButton(0,0,"이전 시트 보기");
				_nextButton = createButton(110,0,"다음 시트 보기");
				_nextButton.addEventListener(MouseEvent.CLICK, onClickedButton);
				_preButton.addEventListener(MouseEvent.CLICK, onClickedButton);
			}
		}
		/**
		 * Note @유영선 화면에 시트 출력 
		 * 
		 */		
		public function printSheet() : void
		{
			addChildAt(_spriteBitmap[_countSheet],0);
		}
		/**
		 * 
		 * @param bitmap 병합된 bitmap
		 * Note @유영선 병합된 bitmap 화면 출력
		 */		
		/**
		 * 버튼(Sprite) 객체를 생성 후 반환하는 메서드
		 * @param x - 버튼의 x값
		 * @param y - 버튼의 y값
		 * @param text - 버튼이 출력할 텍스트
		 * @return 생성한 버튼(Sprite) 객체 반환
		 * Note @유영선 지환님 함수 참고
		 */
		private function createButton(x:int, y:int, text:String):Sprite
		{
			// 버튼(Sprite) 객체 생성
			var button:Sprite = new Sprite();
			// 버튼 색칠
			button.graphics.beginFill(0xbbbbbb);
			// drawRect
			button.graphics.drawRect(0, 0, 100, 50);
			// 위치 설정
			button.x = x;
			button.y = y;
			// buttonMode = true
			button.buttonMode = true;
			// Stage의 자식으로 등록
			addChildAt(button,1);
			
				
			// TextField 객체 생성
			var textField:TextField = new TextField();
			// Center 정렬 설정
			textField.autoSize = TextFieldAutoSize.CENTER;
			// 매개변수 text를 text 속성으로
			textField.text = text;
			// 위치 설정
			textField.y = (button.height - textField.height) / 2;
			// 마우스 선택 off
			textField.mouseEnabled = false;
			// 버튼 객체의 자식으로 등록
			button.addChild(textField);
			
			// 버튼 반환
			return button;
			
		}
		
		/**
		 * 
		 * @param e
		 *Note @유영선 이전, 다음 버튼 누르면 다음 시트, 이전 시트 
		 */		
		private function onClickedButton (e:Event) : void
		{
			var clicked:Sprite = e.currentTarget as Sprite;
			removeChildAt(0);
			switch(clicked)
			{
				
				case _preButton:
					if(_countSheet == 0) break;
					else _countSheet--;
					break;
				
				case _nextButton:
					if(_countSheet >= _spriteBitmap.length-1)break;
					else _countSheet++;
					break;
			}	
			
			printSheet();
		}	
		
		private function release() : void
		{
			if(_spriteBitmap.length > 1)
			{
				_nextButton.removeEventListener(MouseEvent.CLICK, onClickedButton);
				_preButton.removeEventListener(MouseEvent.CLICK, onClickedButton);
			}
		}
	}
}