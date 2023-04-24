import { Caption } from './models/Caption';
import { DrumCorps } from './models/DrumCorps';
import DrumCorpsCaption from './models/DrumCorpsCaption';

export const allPicks = [
  new DrumCorpsCaption('1', DrumCorps.bluecoats, Caption.brass),
  new DrumCorpsCaption('2', DrumCorps.bluecoats, Caption.colorGuard),
  new DrumCorpsCaption('3', DrumCorps.bluecoats, Caption.ge1),
  new DrumCorpsCaption('4', DrumCorps.bluecoats, Caption.ge2),
  new DrumCorpsCaption('5', DrumCorps.bluecoats, Caption.musicAnalysis),
  new DrumCorpsCaption('6', DrumCorps.bluecoats, Caption.percussion),
  new DrumCorpsCaption('7', DrumCorps.bluecoats, Caption.visualAnalysis),
  new DrumCorpsCaption('8', DrumCorps.bluecoats, Caption.visualProficiency),
  //break
  new DrumCorpsCaption('9', DrumCorps.blueDevils, Caption.brass),
  new DrumCorpsCaption('10', DrumCorps.blueDevils, Caption.colorGuard),
  new DrumCorpsCaption('11', DrumCorps.blueDevils, Caption.ge1),
  new DrumCorpsCaption('12', DrumCorps.blueDevils, Caption.ge2),
  new DrumCorpsCaption('13', DrumCorps.blueDevils, Caption.musicAnalysis),
  new DrumCorpsCaption('14', DrumCorps.blueDevils, Caption.percussion),
  new DrumCorpsCaption('15', DrumCorps.blueDevils, Caption.visualAnalysis),
  new DrumCorpsCaption('16', DrumCorps.blueDevils, Caption.visualProficiency),
  //break
  new DrumCorpsCaption('17', DrumCorps.blueKnights, Caption.brass),
  new DrumCorpsCaption('18', DrumCorps.blueKnights, Caption.colorGuard),
  new DrumCorpsCaption('19', DrumCorps.blueKnights, Caption.ge1),
  new DrumCorpsCaption('20', DrumCorps.blueKnights, Caption.ge2),
  new DrumCorpsCaption('21', DrumCorps.blueKnights, Caption.musicAnalysis),
  new DrumCorpsCaption('22', DrumCorps.blueKnights, Caption.percussion),
  new DrumCorpsCaption('23', DrumCorps.blueKnights, Caption.visualAnalysis),
  new DrumCorpsCaption('24', DrumCorps.blueKnights, Caption.visualProficiency),
  //break
  new DrumCorpsCaption('25', DrumCorps.theAcademy, Caption.brass),
  new DrumCorpsCaption('26', DrumCorps.theAcademy, Caption.colorGuard),
  new DrumCorpsCaption('27', DrumCorps.theAcademy, Caption.ge1),
  new DrumCorpsCaption('28', DrumCorps.theAcademy, Caption.ge2),
  new DrumCorpsCaption('29', DrumCorps.theAcademy, Caption.musicAnalysis),
  new DrumCorpsCaption('30', DrumCorps.theAcademy, Caption.percussion),
  new DrumCorpsCaption('31', DrumCorps.theAcademy, Caption.visualAnalysis),
  new DrumCorpsCaption('32', DrumCorps.theAcademy, Caption.visualProficiency),
  //break
  new DrumCorpsCaption('33', DrumCorps.blueStars, Caption.brass),
  new DrumCorpsCaption('34', DrumCorps.blueStars, Caption.colorGuard),
  new DrumCorpsCaption('35', DrumCorps.blueStars, Caption.ge1),
  new DrumCorpsCaption('36', DrumCorps.blueStars, Caption.ge2),
  new DrumCorpsCaption('37', DrumCorps.blueStars, Caption.musicAnalysis),
  new DrumCorpsCaption('38', DrumCorps.blueStars, Caption.percussion),
  new DrumCorpsCaption('39', DrumCorps.blueStars, Caption.visualAnalysis),
  new DrumCorpsCaption('40', DrumCorps.blueStars, Caption.visualProficiency),
  //break
  new DrumCorpsCaption('41', DrumCorps.bostonCrusaders, Caption.brass),
  new DrumCorpsCaption('42', DrumCorps.bostonCrusaders, Caption.colorGuard),
  new DrumCorpsCaption('43', DrumCorps.bostonCrusaders, Caption.ge1),
  new DrumCorpsCaption('44', DrumCorps.bostonCrusaders, Caption.ge2),
  new DrumCorpsCaption('45', DrumCorps.bostonCrusaders, Caption.musicAnalysis),
  new DrumCorpsCaption('46', DrumCorps.bostonCrusaders, Caption.percussion),
  new DrumCorpsCaption('47', DrumCorps.bostonCrusaders, Caption.visualAnalysis),
  new DrumCorpsCaption(
    '48',
    DrumCorps.bostonCrusaders,
    Caption.visualProficiency
  ),
  //break
  new DrumCorpsCaption('49', DrumCorps.theCadets, Caption.brass),
  new DrumCorpsCaption('50', DrumCorps.theCadets, Caption.colorGuard),
  new DrumCorpsCaption('51', DrumCorps.theCadets, Caption.ge1),
  new DrumCorpsCaption('52', DrumCorps.theCadets, Caption.ge2),
  new DrumCorpsCaption('53', DrumCorps.theCadets, Caption.musicAnalysis),
  new DrumCorpsCaption('54', DrumCorps.theCadets, Caption.percussion),
  new DrumCorpsCaption('55', DrumCorps.theCadets, Caption.visualAnalysis),
  new DrumCorpsCaption('56', DrumCorps.theCadets, Caption.visualProficiency),
  //break
  new DrumCorpsCaption('57', DrumCorps.carolinaCrown, Caption.brass),
  new DrumCorpsCaption('58', DrumCorps.carolinaCrown, Caption.colorGuard),
  new DrumCorpsCaption('59', DrumCorps.carolinaCrown, Caption.ge1),
  new DrumCorpsCaption('60', DrumCorps.carolinaCrown, Caption.ge2),
  new DrumCorpsCaption('61', DrumCorps.carolinaCrown, Caption.musicAnalysis),
  new DrumCorpsCaption('62', DrumCorps.carolinaCrown, Caption.percussion),
  new DrumCorpsCaption('63', DrumCorps.carolinaCrown, Caption.visualAnalysis),
  new DrumCorpsCaption(
    '64',
    DrumCorps.carolinaCrown,
    Caption.visualProficiency
  ),
  //break
  new DrumCorpsCaption('65', DrumCorps.theCavaliers, Caption.brass),
  new DrumCorpsCaption('66', DrumCorps.theCavaliers, Caption.colorGuard),
  new DrumCorpsCaption('67', DrumCorps.theCavaliers, Caption.ge1),
  new DrumCorpsCaption('68', DrumCorps.theCavaliers, Caption.ge2),
  new DrumCorpsCaption('69', DrumCorps.theCavaliers, Caption.musicAnalysis),
  new DrumCorpsCaption('70', DrumCorps.theCavaliers, Caption.percussion),
  new DrumCorpsCaption('71', DrumCorps.theCavaliers, Caption.visualAnalysis),
  new DrumCorpsCaption('72', DrumCorps.theCavaliers, Caption.visualProficiency),
  //break
  new DrumCorpsCaption('73', DrumCorps.colts, Caption.brass),
  new DrumCorpsCaption('74', DrumCorps.colts, Caption.colorGuard),
  new DrumCorpsCaption('75', DrumCorps.colts, Caption.ge1),
  new DrumCorpsCaption('76', DrumCorps.colts, Caption.ge2),
  new DrumCorpsCaption('77', DrumCorps.colts, Caption.musicAnalysis),
  new DrumCorpsCaption('78', DrumCorps.colts, Caption.percussion),
  new DrumCorpsCaption('79', DrumCorps.colts, Caption.visualAnalysis),
  new DrumCorpsCaption('80', DrumCorps.colts, Caption.visualProficiency),
  //break
  new DrumCorpsCaption('81', DrumCorps.crossmen, Caption.brass),
  new DrumCorpsCaption('82', DrumCorps.crossmen, Caption.colorGuard),
  new DrumCorpsCaption('83', DrumCorps.crossmen, Caption.ge1),
  new DrumCorpsCaption('84', DrumCorps.crossmen, Caption.ge2),
  new DrumCorpsCaption('85', DrumCorps.crossmen, Caption.musicAnalysis),
  new DrumCorpsCaption('86', DrumCorps.crossmen, Caption.percussion),
  new DrumCorpsCaption('87', DrumCorps.crossmen, Caption.visualAnalysis),
  new DrumCorpsCaption('88', DrumCorps.crossmen, Caption.visualProficiency),
  //break
  new DrumCorpsCaption('89', DrumCorps.genesis, Caption.brass),
  new DrumCorpsCaption('90', DrumCorps.genesis, Caption.colorGuard),
  new DrumCorpsCaption('91', DrumCorps.genesis, Caption.ge1),
  new DrumCorpsCaption('92', DrumCorps.genesis, Caption.ge2),
  new DrumCorpsCaption('93', DrumCorps.genesis, Caption.musicAnalysis),
  new DrumCorpsCaption('94', DrumCorps.genesis, Caption.percussion),
  new DrumCorpsCaption('95', DrumCorps.genesis, Caption.visualAnalysis),
  new DrumCorpsCaption('96', DrumCorps.genesis, Caption.visualProficiency),
  //break
  new DrumCorpsCaption('97', DrumCorps.jerseySurf, Caption.brass),
  new DrumCorpsCaption('98', DrumCorps.jerseySurf, Caption.colorGuard),
  new DrumCorpsCaption('99', DrumCorps.jerseySurf, Caption.ge1),
  new DrumCorpsCaption('100', DrumCorps.jerseySurf, Caption.ge2),
  new DrumCorpsCaption('101', DrumCorps.jerseySurf, Caption.musicAnalysis),
  new DrumCorpsCaption('102', DrumCorps.jerseySurf, Caption.percussion),
  new DrumCorpsCaption('103', DrumCorps.jerseySurf, Caption.visualAnalysis),
  new DrumCorpsCaption('104', DrumCorps.jerseySurf, Caption.visualProficiency),
  //break
  new DrumCorpsCaption('105', DrumCorps.madisonScouts, Caption.brass),
  new DrumCorpsCaption('106', DrumCorps.madisonScouts, Caption.colorGuard),
  new DrumCorpsCaption('107', DrumCorps.madisonScouts, Caption.ge1),
  new DrumCorpsCaption('108', DrumCorps.madisonScouts, Caption.ge2),
  new DrumCorpsCaption('109', DrumCorps.madisonScouts, Caption.musicAnalysis),
  new DrumCorpsCaption('110', DrumCorps.madisonScouts, Caption.percussion),
  new DrumCorpsCaption('111', DrumCorps.madisonScouts, Caption.visualAnalysis),
  new DrumCorpsCaption(
    '112',
    DrumCorps.madisonScouts,
    Caption.visualProficiency
  ),
  //break
  new DrumCorpsCaption('113', DrumCorps.mandarins, Caption.brass),
  new DrumCorpsCaption('114', DrumCorps.mandarins, Caption.colorGuard),
  new DrumCorpsCaption('115', DrumCorps.mandarins, Caption.ge1),
  new DrumCorpsCaption('116', DrumCorps.mandarins, Caption.ge2),
  new DrumCorpsCaption('117', DrumCorps.mandarins, Caption.musicAnalysis),
  new DrumCorpsCaption('118', DrumCorps.mandarins, Caption.percussion),
  new DrumCorpsCaption('119', DrumCorps.mandarins, Caption.visualAnalysis),
  new DrumCorpsCaption('120', DrumCorps.mandarins, Caption.visualProficiency),
  //break
  new DrumCorpsCaption('121', DrumCorps.musicCity, Caption.brass),
  new DrumCorpsCaption('122', DrumCorps.musicCity, Caption.colorGuard),
  new DrumCorpsCaption('123', DrumCorps.musicCity, Caption.ge1),
  new DrumCorpsCaption('124', DrumCorps.musicCity, Caption.ge2),
  new DrumCorpsCaption('125', DrumCorps.musicCity, Caption.musicAnalysis),
  new DrumCorpsCaption('126', DrumCorps.musicCity, Caption.percussion),
  new DrumCorpsCaption('127', DrumCorps.musicCity, Caption.visualAnalysis),
  new DrumCorpsCaption('128', DrumCorps.musicCity, Caption.visualProficiency),
  //break
  new DrumCorpsCaption('129', DrumCorps.pacificCrest, Caption.brass),
  new DrumCorpsCaption('130', DrumCorps.pacificCrest, Caption.colorGuard),
  new DrumCorpsCaption('131', DrumCorps.pacificCrest, Caption.ge1),
  new DrumCorpsCaption('132', DrumCorps.pacificCrest, Caption.ge2),
  new DrumCorpsCaption('133', DrumCorps.pacificCrest, Caption.musicAnalysis),
  new DrumCorpsCaption('134', DrumCorps.pacificCrest, Caption.percussion),
  new DrumCorpsCaption('135', DrumCorps.pacificCrest, Caption.visualAnalysis),
  new DrumCorpsCaption(
    '136',
    DrumCorps.pacificCrest,
    Caption.visualProficiency
  ),
  //break
  new DrumCorpsCaption('137', DrumCorps.phantomRegiment, Caption.brass),
  new DrumCorpsCaption('138', DrumCorps.phantomRegiment, Caption.colorGuard),
  new DrumCorpsCaption('130', DrumCorps.phantomRegiment, Caption.ge1),
  new DrumCorpsCaption('140', DrumCorps.phantomRegiment, Caption.ge2),
  new DrumCorpsCaption('141', DrumCorps.phantomRegiment, Caption.musicAnalysis),
  new DrumCorpsCaption('142', DrumCorps.phantomRegiment, Caption.percussion),
  new DrumCorpsCaption(
    '143',
    DrumCorps.phantomRegiment,
    Caption.visualAnalysis
  ),
  new DrumCorpsCaption(
    '144',
    DrumCorps.phantomRegiment,
    Caption.visualProficiency
  ),
  //break
  new DrumCorpsCaption('145', DrumCorps.santaClaraVanguard, Caption.brass),
  new DrumCorpsCaption('146', DrumCorps.santaClaraVanguard, Caption.colorGuard),
  new DrumCorpsCaption('147', DrumCorps.santaClaraVanguard, Caption.ge1),
  new DrumCorpsCaption('148', DrumCorps.santaClaraVanguard, Caption.ge2),
  new DrumCorpsCaption(
    '149',
    DrumCorps.santaClaraVanguard,
    Caption.musicAnalysis
  ),
  new DrumCorpsCaption('150', DrumCorps.santaClaraVanguard, Caption.percussion),
  new DrumCorpsCaption(
    '151',
    DrumCorps.santaClaraVanguard,
    Caption.visualAnalysis
  ),
  new DrumCorpsCaption(
    '152',
    DrumCorps.santaClaraVanguard,
    Caption.visualProficiency
  ),
  //break
  new DrumCorpsCaption('153', DrumCorps.seattleCascades, Caption.brass),
  new DrumCorpsCaption('154', DrumCorps.seattleCascades, Caption.colorGuard),
  new DrumCorpsCaption('155', DrumCorps.seattleCascades, Caption.ge1),
  new DrumCorpsCaption('156', DrumCorps.seattleCascades, Caption.ge2),
  new DrumCorpsCaption('157', DrumCorps.seattleCascades, Caption.musicAnalysis),
  new DrumCorpsCaption('158', DrumCorps.seattleCascades, Caption.percussion),
  new DrumCorpsCaption(
    '159',
    DrumCorps.seattleCascades,
    Caption.visualAnalysis
  ),
  new DrumCorpsCaption(
    '160',
    DrumCorps.seattleCascades,
    Caption.visualProficiency
  ),
  //break
  new DrumCorpsCaption('161', DrumCorps.spiritOfAtlanta, Caption.brass),
  new DrumCorpsCaption('162', DrumCorps.spiritOfAtlanta, Caption.colorGuard),
  new DrumCorpsCaption('163', DrumCorps.spiritOfAtlanta, Caption.ge1),
  new DrumCorpsCaption('164', DrumCorps.spiritOfAtlanta, Caption.ge2),
  new DrumCorpsCaption('165', DrumCorps.spiritOfAtlanta, Caption.musicAnalysis),
  new DrumCorpsCaption('166', DrumCorps.spiritOfAtlanta, Caption.percussion),
  new DrumCorpsCaption(
    '167',
    DrumCorps.spiritOfAtlanta,
    Caption.visualAnalysis
  ),
  new DrumCorpsCaption(
    '168',
    DrumCorps.spiritOfAtlanta,
    Caption.visualProficiency
  ),
  //break
  new DrumCorpsCaption('169', DrumCorps.troopers, Caption.brass),
  new DrumCorpsCaption('170', DrumCorps.troopers, Caption.colorGuard),
  new DrumCorpsCaption('171', DrumCorps.troopers, Caption.ge1),
  new DrumCorpsCaption('172', DrumCorps.troopers, Caption.ge2),
  new DrumCorpsCaption('173', DrumCorps.troopers, Caption.musicAnalysis),
  new DrumCorpsCaption('174', DrumCorps.troopers, Caption.percussion),
  new DrumCorpsCaption('175', DrumCorps.troopers, Caption.visualAnalysis),
  new DrumCorpsCaption('176', DrumCorps.troopers, Caption.visualProficiency),
];
