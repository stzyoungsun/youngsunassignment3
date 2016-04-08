package
{
	import flash.geom.Rectangle;

	public class Node
	{
		private var _left : Node ;
		private var _right : Node ;
		private var _rc : Rectangle;
		private var _imageID : int = -1;
		private var _rotateFlag : Boolean = false;
		
		public static var sImageRectVetor : Vector.<Rectangle> = new Vector.<Rectangle>;
		public static var sImageIDArray : Array = new Array();
		public static var sRotateFlagArray : Array = new Array();
		
		public function Node(rc : Rectangle,imageID : int )
		{
			this._rc = rc;
			this._imageID = imageID;
			
		}
	
		/**
		 *Note @유영선 중위 순회 알고리즘 
		 * 
		 */		
		public function inOrder() : void
		{
			if(_left != null)
				_left.inOrder();
			if(_imageID != -1)  //이미지가 존재 할 경우
			{
				sImageIDArray.push(_imageID);	//이미지 아이디를 벡터에 저장
				sImageRectVetor.push(_rc);     //이미지 좌표를 벡터에 저장
				sRotateFlagArray.push(_rotateFlag);
				trace(_rotateFlag);
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
		
		public function getImageID() :  int{
			return _imageID;
		}
		
		public function setImageID(imageID : int) : void {
			this._imageID = imageID;
		}
		
		public function getRotateFlag() :  Boolean{
			return _rotateFlag;
		}
		
		public function setRotateFlag(rotateFlag : Boolean) : void {
			this._rotateFlag = rotateFlag;
		}
	}
}