import MemberNode from './MemberNode';

export default class MemberNodeList {
  head?: MemberNode;
  tail?: MemberNode;
  length: number;
  currentNode?: MemberNode;
  nextNode?: MemberNode;

  constructor() {
    this.length = 0;
  }

  addNode(nodeValue: string): void {
    const node = new MemberNode(nodeValue);
    if (this.length === 0) {
      this.head = node;
      this.tail = node;
    } else {
      this.tail!.next = node;
      node.prev = this.tail;
      this.tail = node;
    }
    this.length++;
  }

  getCurrentNode(): MemberNode {
    if (!this.head) {
      throw Error('List not initialized');
    }

    return !this.currentNode ? this.head : this.currentNode;
  }

  advanceToNextNode(): void {
    if (!this.head) {
      throw Error('List not initialized');
    }
    if (!this.currentNode) {
      this.currentNode == this.head;
    } else {
      this.currentNode == this.currentNode.next ?? this.head;
    }
  }
}
