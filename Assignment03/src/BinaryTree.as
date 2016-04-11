package
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	
	public class BinaryTree
	{	
		private var _root : Node;
		private var _pnode : Node;
		private var _rotateFlag : Boolean = false;
		/**
		 * 
		 * @param rc Image의 Rectangle 데이터
		 *  Note @유영선 이진트리 초기화
		 */		
		public function BinaryTree(rc : Rectangle)
		{
			_root = new Node(rc,"NULL");
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
		 * Note @알고리즘 설명

		 *  pre. Image 삽입 전 효율을 높이기 위해서 크기 순으로 정렬
		 * 1. 이진트리를 사용 (각 Node -> 좌표, Image ID)
		 * 2. 처음 root에는 Sprite-Sheet의 크기 1024*1024, Image ID = -1로 생성 -> 수정 Note @유영선 root의 크기를 2의 n승으로 증가시키면서 병합 진행
		 * 3. 처음 Image를 삽입 하고 그 Image에 따라 공간을 분할 하고 그 공간을 Node에 삽입 
		 * 4. Image에 딱 맞는 공간 발견 시 그 공간에 Image ID를 설정 후 return
		 * 5. 다음 삽입 부터는 깊이우선탐색(BST)을 활용하여 모든 노드를 방문 하고 노드에 leaf가 없으면 3번과 마찬가리로 공간 분할 후 Node삽입
		 * 6. 5번을 반복하여 모든 Image를 노드에 삽입
		 * 7. 마지막으로 이진탐색 중위 순회를 이용하여 노드에 방문 후 Image ID가 -1이 아니면 노드 값 벡터에 저장

		 */		
		public function insert(bitmap : Bitmap, imageName : String, currentNode : Node) : Node
		{
			
			if(currentNode.getLeft() != null)   //왼쪽 자시 노드가 없을 경우
			{
	
				return insert(bitmap,imageName, currentNode.getLeft()) ||  insert(bitmap,imageName, currentNode.getRight());
					
			}
			else
			{
				if(currentNode.getImageName() != "NULL")   //현재 노드에 이미지가 있는 경우
					return null;
				
				if( currentNode.getrc().width == bitmap.width && currentNode.getrc().height == bitmap.height)   //현재 영역에 삽입 할 이미지의 크기가 딱 맞는 경우
				{
					currentNode.setImageName(imageName);
					currentNode.setRotateFlag(_rotateFlag);
					return currentNode;
				}
				
				
				if(currentNode.getrc().width < bitmap.width || currentNode.getrc().height < bitmap.height)    //현재 영역이 삽입 할 이미지 보다 클 경우
				{
						return null
				}
					
				
				var dw : int = currentNode.getrc().width - bitmap.width;
				var dh : int = currentNode.getrc().height - bitmap.height;
				
				if(dw > dh)    //분할 된 공간 영역을 설정하기 위해서
				{
					var newLeftNode : Node = new Node(new Rectangle(currentNode.getrc().x, currentNode.getrc().y, bitmap.width,currentNode.getrc().height),"NULL");
					var newRightNode : Node = new Node(new Rectangle(currentNode.getrc().x+bitmap.width, currentNode.getrc().y, currentNode.getrc().width - bitmap.width ,currentNode.getrc().height),"NULL");	
					currentNode.setLeft(newLeftNode);
					currentNode.setRight(newRightNode);
				}
				else
				{
					var newLeftNode1 : Node = new Node(new Rectangle(currentNode.getrc().x, currentNode.getrc().y, currentNode.getrc().width,bitmap.height),"NULL");
					var newRightNode1 : Node = new Node(new Rectangle(currentNode.getrc().x, currentNode.getrc().y+bitmap.height,  currentNode.getrc().width,currentNode.getrc().height - bitmap.height),"NULL");	
					currentNode.setLeft(newLeftNode1);
					currentNode.setRight(newRightNode1);
				}
			}
				
			return insert(bitmap,imageName,currentNode.getLeft());
		}

	}
}