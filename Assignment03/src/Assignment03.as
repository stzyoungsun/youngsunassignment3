package
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.errors.InvalidSWFError;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import MainClass;
	
	[SWF(width="400", height="600", frameRate="60", backgroundColor="#ffffff")]
	
	public class Assignment03 extends Sprite
	{
		[Embed(source = "../bin-debug/BackGround/Background.png")]
		private static const _background:Class;
		private var picture : Bitmap = new _background();
		
		private var _cMainClass : MainClass = new MainClass();
	
		public function Assignment03()
		{
			addChild(picture);
			_cMainClass.initialize(outTextField, createButton);
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
			button.graphics.drawRect(0, 0, 150, 50);
			// 위치 설정
			button.x = x;
			button.y = y;
			// buttonMode = true
			button.buttonMode = true;
			button.addEventListener(MouseEvent.CLICK,_cMainClass.onClickButton);
			// Stage의 자식으로 등록
			addChild(button);
			
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
	
	}
}