import { Collection } from 'fireorm';
import { DrumCorps } from './DrumCorps';

@Collection('lineups')
export default class CorpsLineup {
  id!: string;
  userId!: string;
  tourId!: string;
  generalEffect1First?: DrumCorps;
  generalEffect1Second?: DrumCorps;
  generalEffect2First?: DrumCorps;
  generalEffect2Second?: DrumCorps;
  visualProficiencyFirst?: DrumCorps;
  visualProficiencySecond?: DrumCorps;
  visualAnalysisFirst?: DrumCorps;
  visualAnalysisSecond?: DrumCorps;
  colorGuardFirst?: DrumCorps;
  colorGuardSecond?: DrumCorps;
  brassFirst?: DrumCorps;
  brassSecond?: DrumCorps;
  musicAnalysis1First?: DrumCorps;
  musicAnalysis1Second?: DrumCorps;
  musicAnalysis2First?: DrumCorps;
  musicAnalysis2Second?: DrumCorps;
  percussionFirst?: DrumCorps;
  percussionSecond?: DrumCorps;
}
