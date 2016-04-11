package
{
	import flash.geom.Rectangle;
	import flash.geom.Point;

	public class Node
	{
		private var _left : Node ;
		private var _right : Node ;
		private var _rc : Rectangle;
		private var _imageName : String = "NULL";
		private var _rotateFlag : Boolean = false;
		
		public static var sImageRectVetor : Vector.<Rectangle> = new Vector.<Rectangle>;
		public static var sImageNameArray : Array = new Array();
		public static var sMaxImagePos : Point = new Point(0,0);
		
		public function Node(rc : Rectangle,imageName : String )
		{
			this._rc = rc;
			this._imageName = imageName;
			
		}
	
		/**
		 *Note @유영선 중위 순회 알고리즘 
		 * 
		 */		
		public function inOrder() : void
		{
			if(_left != null)
				_left.inOrder();
			if(_imageName != "NULL")  //이미지가 존재 할 경우
			{
				sImageNameArray.push(_imageName);	//이미지 아이디를 벡터에 저장
				sImageRectVetor.push(_rc);     //이미지 좌표를 벡터에 저장
				
				if(sMaxImagePos.x < _rc.x+_rc.width)
					sMaxImagePos.x = _rc.x+_rc.width;
				if(sMaxImagePos.y < _rc.y+_rc.height)
					sMaxImagePos.y = _rc.y+_rc.height;
			}
				
			if(_right != null)
				_right.inOrder();
		}
		
		
		public function  getLeft() : Node{
			return _left;
		}
		
		public function setLeft(left:Node) : void {
			this._left = left;
		}
		
		public function getRight():Node {
			return _right;
		}
		
		public function setRight(right : Node) : void {
			this._right = right;
		}
		
		public function getrc() : Rectangle {
			return _rc;
		}
		
		public function setrc(rc : Rectangle) : void {
			this._rc = rc;
		}
		
		public function getImageName() :  String{
			return _imageName;
		}
		
		public function setImageName(imageName : String) : void {
			this._imageName = imageName;
		}
		
		public function getRotateFlag() :  Boolean{
			return _rotateFlag;
		}
		
		public function setRotateFlag(rotateFlag : Boolean) : void {
			this._rotateFlag = rotateFlag;
		}
	}
}