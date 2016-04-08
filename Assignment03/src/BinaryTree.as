package
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	
	public class BinaryTree
	{	
		private var _root : Node;
		private var _pnode : Node;
		/**
		 * 
		 * @param rc Image의 Rectangle 데이터
		 *  Note @유영선 이진트리 초기화
		 */		
		public function BinaryTree(rc : Rectangle)
		{
			_root = new Node(rc,-1);
			_pnode = _root;
		}
		/**
		 * 
		 * @return 
		 * 이진트리 반환 
		 */		
		public function getroot() : Node
		{
			return _root;
		}
		/**
		 *Note @유영선 중위 순회 
		 * 
		 */		
		public function inOrder() : void {
			_root.inOrder();
		}
		
		/**
		 * 
		 * @param bitmap 병합 할 Bitmap 데이터
		 * @param imageID 병합 할 Bitmap의 ID
		 * @param pnode  현재의 노드
		 * @return Image가 삽입된 노드
		 * Note @유영선 병합 알고리즘에 대한 상세 설명은 wiki에 남길 예정 (깊이우선 탐색 방식 사용)
		 */		
		public function insert(bitmap : Bitmap, imageID : int, currentNode : Node) : Node
		{
			
			if(currentNode.getLeft() != null)
			{
	
				return insert(bitmap,imageID, currentNode.getLeft()) ||  insert(bitmap,imageID, currentNode.getRight());
					
			}
			else
			{
				if(currentNode.getImageID() != -1)
					return null;
				
				if( currentNode.getrc().width == bitmap.width && currentNode.getrc().height == bitmap.height)
				{
					currentNode.setImageID(imageID);
					return currentNode;
				}
				
				
				if(currentNode.getrc().width < bitmap.width || currentNode.getrc().height < bitmap.height)
					return null
					
				var dw : int = currentNode.getrc().width - bitmap.width;
				var dh : int = currentNode.getrc().height - bitmap.height;
				
				
					
				if(dw > dh)
				{
					var newLeftNode : Node = new Node(new Rectangle(currentNode.getrc().x, currentNode.getrc().y, bitmap.width,currentNode.getrc().height),-1);
					var newRightNode : Node = new Node(new Rectangle(currentNode.getrc().x+bitmap.width, currentNode.getrc().y, currentNode.getrc().width - bitmap.width ,currentNode.getrc().height),-1);	
					currentNode.setLeft(newLeftNode);
					currentNode.setRight(newRightNode);
				}
				else
				{
					var newLeftNode1 : Node = new Node(new Rectangle(currentNode.getrc().x, currentNode.getrc().y, currentNode.getrc().width,bitmap.height),-1);
					var newRightNode1 : Node = new Node(new Rectangle(currentNode.getrc().x, currentNode.getrc().y+bitmap.height,  currentNode.getrc().width,currentNode.getrc().height - bitmap.height),-1);	
					currentNode.setLeft(newLeftNode1);
					currentNode.setRight(newRightNode1);
				}
				
			}
			return insert(bitmap,imageID,currentNode.getLeft());
		}

	}
}