import { DrumCorps } from './DrumCorps';
import { Caption } from './Caption';

export default class DrumCorpsCaption {
  id: string;
  corps: DrumCorps;
  caption: Caption;

  constructor(id: string, corps: DrumCorps, caption: Caption) {
    this.id = id;
    this.corps = corps;
    this.caption = caption;
  }
}
