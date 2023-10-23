import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';

const startingDraftPicks = [
  DrumCorpsCaption(id: '1', corps: DrumCorps.bluecoats, caption: Caption.brass),
  DrumCorpsCaption(
      id: '2', corps: DrumCorps.bluecoats, caption: Caption.colorGuard),
  DrumCorpsCaption(id: '3', corps: DrumCorps.bluecoats, caption: Caption.ge1),
  DrumCorpsCaption(id: '4', corps: DrumCorps.bluecoats, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '5', corps: DrumCorps.bluecoats, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '6', corps: DrumCorps.bluecoats, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '7', corps: DrumCorps.bluecoats, caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '8', corps: DrumCorps.bluecoats, caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '9', corps: DrumCorps.blueDevils, caption: Caption.brass),
  DrumCorpsCaption(
      id: '10', corps: DrumCorps.blueDevils, caption: Caption.colorGuard),
  DrumCorpsCaption(id: '11', corps: DrumCorps.blueDevils, caption: Caption.ge1),
  DrumCorpsCaption(id: '12', corps: DrumCorps.blueDevils, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '13', corps: DrumCorps.blueDevils, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '14', corps: DrumCorps.blueDevils, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '15', corps: DrumCorps.blueDevils, caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '16',
      corps: DrumCorps.blueDevils,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '17', corps: DrumCorps.blueKnights, caption: Caption.brass),
  DrumCorpsCaption(
      id: '18', corps: DrumCorps.blueKnights, caption: Caption.colorGuard),
  DrumCorpsCaption(
      id: '19', corps: DrumCorps.blueKnights, caption: Caption.ge1),
  DrumCorpsCaption(
      id: '20', corps: DrumCorps.blueKnights, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '21', corps: DrumCorps.blueKnights, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '22', corps: DrumCorps.blueKnights, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '23', corps: DrumCorps.blueKnights, caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '24',
      corps: DrumCorps.blueKnights,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '25', corps: DrumCorps.theAcademy, caption: Caption.brass),
  DrumCorpsCaption(
      id: '26', corps: DrumCorps.theAcademy, caption: Caption.colorGuard),
  DrumCorpsCaption(id: '27', corps: DrumCorps.theAcademy, caption: Caption.ge1),
  DrumCorpsCaption(id: '28', corps: DrumCorps.theAcademy, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '29', corps: DrumCorps.theAcademy, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '30', corps: DrumCorps.theAcademy, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '31', corps: DrumCorps.theAcademy, caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '32',
      corps: DrumCorps.theAcademy,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '33', corps: DrumCorps.blueStars, caption: Caption.brass),
  DrumCorpsCaption(
      id: '34', corps: DrumCorps.blueStars, caption: Caption.colorGuard),
  DrumCorpsCaption(id: '35', corps: DrumCorps.blueStars, caption: Caption.ge1),
  DrumCorpsCaption(id: '36', corps: DrumCorps.blueStars, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '37', corps: DrumCorps.blueStars, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '38', corps: DrumCorps.blueStars, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '39', corps: DrumCorps.blueStars, caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '40', corps: DrumCorps.blueStars, caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '41', corps: DrumCorps.bostonCrusaders, caption: Caption.brass),
  DrumCorpsCaption(
      id: '42', corps: DrumCorps.bostonCrusaders, caption: Caption.colorGuard),
  DrumCorpsCaption(
      id: '43', corps: DrumCorps.bostonCrusaders, caption: Caption.ge1),
  DrumCorpsCaption(
      id: '44', corps: DrumCorps.bostonCrusaders, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '45',
      corps: DrumCorps.bostonCrusaders,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '46', corps: DrumCorps.bostonCrusaders, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '47',
      corps: DrumCorps.bostonCrusaders,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '48',
      corps: DrumCorps.bostonCrusaders,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '49', corps: DrumCorps.theCadets, caption: Caption.brass),
  DrumCorpsCaption(
      id: '50', corps: DrumCorps.theCadets, caption: Caption.colorGuard),
  DrumCorpsCaption(id: '51', corps: DrumCorps.theCadets, caption: Caption.ge1),
  DrumCorpsCaption(id: '52', corps: DrumCorps.theCadets, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '53', corps: DrumCorps.theCadets, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '54', corps: DrumCorps.theCadets, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '55', corps: DrumCorps.theCadets, caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '56', corps: DrumCorps.theCadets, caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '57', corps: DrumCorps.carolinaCrown, caption: Caption.brass),
  DrumCorpsCaption(
      id: '58', corps: DrumCorps.carolinaCrown, caption: Caption.colorGuard),
  DrumCorpsCaption(
      id: '59', corps: DrumCorps.carolinaCrown, caption: Caption.ge1),
  DrumCorpsCaption(
      id: '60', corps: DrumCorps.carolinaCrown, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '61', corps: DrumCorps.carolinaCrown, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '62', corps: DrumCorps.carolinaCrown, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '63',
      corps: DrumCorps.carolinaCrown,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '64',
      corps: DrumCorps.carolinaCrown,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '65', corps: DrumCorps.theCavaliers, caption: Caption.brass),
  DrumCorpsCaption(
      id: '66', corps: DrumCorps.theCavaliers, caption: Caption.colorGuard),
  DrumCorpsCaption(
      id: '67', corps: DrumCorps.theCavaliers, caption: Caption.ge1),
  DrumCorpsCaption(
      id: '68', corps: DrumCorps.theCavaliers, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '69', corps: DrumCorps.theCavaliers, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '70', corps: DrumCorps.theCavaliers, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '71', corps: DrumCorps.theCavaliers, caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '72',
      corps: DrumCorps.theCavaliers,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(id: '73', corps: DrumCorps.colts, caption: Caption.brass),
  DrumCorpsCaption(
      id: '74', corps: DrumCorps.colts, caption: Caption.colorGuard),
  DrumCorpsCaption(id: '75', corps: DrumCorps.colts, caption: Caption.ge1),
  DrumCorpsCaption(id: '76', corps: DrumCorps.colts, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '77', corps: DrumCorps.colts, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '78', corps: DrumCorps.colts, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '79', corps: DrumCorps.colts, caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '80', corps: DrumCorps.colts, caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(id: '81', corps: DrumCorps.crossmen, caption: Caption.brass),
  DrumCorpsCaption(
      id: '82', corps: DrumCorps.crossmen, caption: Caption.colorGuard),
  DrumCorpsCaption(id: '83', corps: DrumCorps.crossmen, caption: Caption.ge1),
  DrumCorpsCaption(id: '84', corps: DrumCorps.crossmen, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '85', corps: DrumCorps.crossmen, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '86', corps: DrumCorps.crossmen, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '87', corps: DrumCorps.crossmen, caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '88', corps: DrumCorps.crossmen, caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(id: '89', corps: DrumCorps.genesis, caption: Caption.brass),
  DrumCorpsCaption(
      id: '90', corps: DrumCorps.genesis, caption: Caption.colorGuard),
  DrumCorpsCaption(id: '91', corps: DrumCorps.genesis, caption: Caption.ge1),
  DrumCorpsCaption(id: '92', corps: DrumCorps.genesis, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '93', corps: DrumCorps.genesis, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '94', corps: DrumCorps.genesis, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '95', corps: DrumCorps.genesis, caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '96', corps: DrumCorps.genesis, caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '97', corps: DrumCorps.jerseySurf, caption: Caption.brass),
  DrumCorpsCaption(
      id: '98', corps: DrumCorps.jerseySurf, caption: Caption.colorGuard),
  DrumCorpsCaption(id: '99', corps: DrumCorps.jerseySurf, caption: Caption.ge1),
  DrumCorpsCaption(
      id: '100', corps: DrumCorps.jerseySurf, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '101', corps: DrumCorps.jerseySurf, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '102', corps: DrumCorps.jerseySurf, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '103', corps: DrumCorps.jerseySurf, caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '104',
      corps: DrumCorps.jerseySurf,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '105', corps: DrumCorps.madisonScouts, caption: Caption.brass),
  DrumCorpsCaption(
      id: '106', corps: DrumCorps.madisonScouts, caption: Caption.colorGuard),
  DrumCorpsCaption(
      id: '107', corps: DrumCorps.madisonScouts, caption: Caption.ge1),
  DrumCorpsCaption(
      id: '108', corps: DrumCorps.madisonScouts, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '109',
      corps: DrumCorps.madisonScouts,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '110', corps: DrumCorps.madisonScouts, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '111',
      corps: DrumCorps.madisonScouts,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '112',
      corps: DrumCorps.madisonScouts,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '113', corps: DrumCorps.mandarins, caption: Caption.brass),
  DrumCorpsCaption(
      id: '114', corps: DrumCorps.mandarins, caption: Caption.colorGuard),
  DrumCorpsCaption(id: '115', corps: DrumCorps.mandarins, caption: Caption.ge1),
  DrumCorpsCaption(id: '116', corps: DrumCorps.mandarins, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '117', corps: DrumCorps.mandarins, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '118', corps: DrumCorps.mandarins, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '119', corps: DrumCorps.mandarins, caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '120',
      corps: DrumCorps.mandarins,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '121', corps: DrumCorps.musicCity, caption: Caption.brass),
  DrumCorpsCaption(
      id: '122', corps: DrumCorps.musicCity, caption: Caption.colorGuard),
  DrumCorpsCaption(id: '123', corps: DrumCorps.musicCity, caption: Caption.ge1),
  DrumCorpsCaption(id: '124', corps: DrumCorps.musicCity, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '125', corps: DrumCorps.musicCity, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '126', corps: DrumCorps.musicCity, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '127', corps: DrumCorps.musicCity, caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '128',
      corps: DrumCorps.musicCity,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '129', corps: DrumCorps.pacificCrest, caption: Caption.brass),
  DrumCorpsCaption(
      id: '130', corps: DrumCorps.pacificCrest, caption: Caption.colorGuard),
  DrumCorpsCaption(
      id: '131', corps: DrumCorps.pacificCrest, caption: Caption.ge1),
  DrumCorpsCaption(
      id: '132', corps: DrumCorps.pacificCrest, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '133', corps: DrumCorps.pacificCrest, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '134', corps: DrumCorps.pacificCrest, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '135',
      corps: DrumCorps.pacificCrest,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '136',
      corps: DrumCorps.pacificCrest,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '137', corps: DrumCorps.phantomRegiment, caption: Caption.brass),
  DrumCorpsCaption(
      id: '138', corps: DrumCorps.phantomRegiment, caption: Caption.colorGuard),
  DrumCorpsCaption(
      id: '139', corps: DrumCorps.phantomRegiment, caption: Caption.ge1),
  DrumCorpsCaption(
      id: '140', corps: DrumCorps.phantomRegiment, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '141',
      corps: DrumCorps.phantomRegiment,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '142', corps: DrumCorps.phantomRegiment, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '143',
      corps: DrumCorps.phantomRegiment,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '144',
      corps: DrumCorps.phantomRegiment,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '145', corps: DrumCorps.santaClaraVanguard, caption: Caption.brass),
  DrumCorpsCaption(
      id: '146',
      corps: DrumCorps.santaClaraVanguard,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      id: '147', corps: DrumCorps.santaClaraVanguard, caption: Caption.ge1),
  DrumCorpsCaption(
      id: '148', corps: DrumCorps.santaClaraVanguard, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '149',
      corps: DrumCorps.santaClaraVanguard,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '150',
      corps: DrumCorps.santaClaraVanguard,
      caption: Caption.percussion),
  DrumCorpsCaption(
      id: '151',
      corps: DrumCorps.santaClaraVanguard,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '152',
      corps: DrumCorps.santaClaraVanguard,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '153', corps: DrumCorps.seattleCascades, caption: Caption.brass),
  DrumCorpsCaption(
      id: '154', corps: DrumCorps.seattleCascades, caption: Caption.colorGuard),
  DrumCorpsCaption(
      id: '155', corps: DrumCorps.seattleCascades, caption: Caption.ge1),
  DrumCorpsCaption(
      id: '156', corps: DrumCorps.seattleCascades, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '157',
      corps: DrumCorps.seattleCascades,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '158', corps: DrumCorps.seattleCascades, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '159',
      corps: DrumCorps.seattleCascades,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '160',
      corps: DrumCorps.seattleCascades,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '161', corps: DrumCorps.spiritOfAtlanta, caption: Caption.brass),
  DrumCorpsCaption(
      id: '162', corps: DrumCorps.spiritOfAtlanta, caption: Caption.colorGuard),
  DrumCorpsCaption(
      id: '163', corps: DrumCorps.spiritOfAtlanta, caption: Caption.ge1),
  DrumCorpsCaption(
      id: '164', corps: DrumCorps.spiritOfAtlanta, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '165',
      corps: DrumCorps.spiritOfAtlanta,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '166', corps: DrumCorps.spiritOfAtlanta, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '167',
      corps: DrumCorps.spiritOfAtlanta,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '168',
      corps: DrumCorps.spiritOfAtlanta,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      id: '169', corps: DrumCorps.troopers, caption: Caption.brass),
  DrumCorpsCaption(
      id: '170', corps: DrumCorps.troopers, caption: Caption.colorGuard),
  DrumCorpsCaption(id: '171', corps: DrumCorps.troopers, caption: Caption.ge1),
  DrumCorpsCaption(id: '172', corps: DrumCorps.troopers, caption: Caption.ge2),
  DrumCorpsCaption(
      id: '173', corps: DrumCorps.troopers, caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      id: '174', corps: DrumCorps.troopers, caption: Caption.percussion),
  DrumCorpsCaption(
      id: '175', corps: DrumCorps.troopers, caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      id: '176', corps: DrumCorps.troopers, caption: Caption.visualProficiency),
];
