package
{
	import flash.geom.Rectangle;

	public class Node
	{
		private var _left : Node ;
		private var _right : Node ;
		private var _rc : Rectangle;
		private var _imageID : int = -1;
		
		public static var sImageRectVetor : Vector.<Rectangle> = new Vector.<Rectangle>;
		public static var sImageIDArray : Array = new Array();
		
		public function Node(rc : Rectangle,imageID : int )
		{
			this._rc = rc;
			this._imageID = imageID;
			
		}
	

		public function inOrder() : void
		{
			if(_left != null)
				_left.inOrder();
			if(_imageID != -1)
			{
				sImageIDArray.push(_imageID);
				sImageRectVetor.push(_rc);
			}
				
			
			if(_right != null)
				_right.inOrder();
		}
		
		public function preOrder() : void
		{
			if(_left != null)
				_left.preOrder();
			
			if(_right != null)
				_right.preOrder();
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
	}
}