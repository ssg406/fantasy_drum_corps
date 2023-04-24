export default class MemberNode {
  userId: string;
  next?: MemberNode;
  prev?: MemberNode;
  constructor(userId: string) {
    this.userId = userId;
  }
}
