import { Collection } from 'fireorm';

@Collection('tours')
export default class Tour {
  id!: string;
  name!: string;
  description!: string;
  isPublic!: Boolean;
  owner!: string;
  members!: Array<string>;
  draftDateTime!: string;
  password?: string;
  draftActive!: boolean;
}
