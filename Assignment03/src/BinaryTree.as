package
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	
	import Node;
	
	public class BinaryTree
	{	
		private var _root : Node;
		private var _pnode : Node;
		public function BinaryTree(rc : Rectangle)
		{
			_root = new Node(rc,-1);
			_pnode = _root;
		}
		public function getroot() : Node
		{
			return _root;
		}
		public function initnode() : void
		{
			_pnode = _root;
		}
		public function isEmpty() : Boolean {
			return _root == null;
		}
		
		public function clear() : void {
			_root = null;
		}
		
		public function inOrder() : void {
			_root.inOrder();
		}
		
		public function preOrder() : void{
			_root.preOrder();
		}
		
		public function insert(bitmap : Bitmap, imageID : int, pnode : Node) : Node
		{
			var cnode : Node = pnode;
			if(cnode.getLeft() != null)
			{
	
				return insert(bitmap,imageID, cnode.getLeft()) ||  insert(bitmap,imageID, cnode.getRight());
					
			}
			else
			{
				if(cnode.getImageID() != -1)
					return null;
				
				if( cnode.getrc().width == bitmap.width && cnode.getrc().height == bitmap.height)
				{
					cnode.setImageID(imageID);
					return _root;
				}
				
				
				if(cnode.getrc().width < bitmap.width || cnode.getrc().height < bitmap.height)
					return null
					
				var dw : int = cnode.getrc().width - bitmap.width;
				var dh : int = cnode.getrc().height - bitmap.height;
				
				
					
				if(dw > dh)
				{
					var newLeftNode : Node = new Node(new Rectangle(cnode.getrc().x, cnode.getrc().y, bitmap.width,cnode.getrc().height),-1);
					var newRightNode : Node = new Node(new Rectangle(cnode.getrc().x+bitmap.width, cnode.getrc().y, cnode.getrc().width - bitmap.width ,cnode.getrc().height),-1);	
					cnode.setLeft(newLeftNode);
					cnode.setRight(newRightNode);
				}
				else
				{
					var newLeftNode1 : Node = new Node(new Rectangle(cnode.getrc().x, cnode.getrc().y, cnode.getrc().width,bitmap.height),-1);
					var newRightNode1 : Node = new Node(new Rectangle(cnode.getrc().x, cnode.getrc().y+bitmap.height,  cnode.getrc().width,cnode.getrc().height - bitmap.height),-1);	
					cnode.setLeft(newLeftNode1);
					cnode.setRight(newRightNode1);
				}
				
			}
			return insert(bitmap,imageID,cnode.getLeft());
		}

	}
}