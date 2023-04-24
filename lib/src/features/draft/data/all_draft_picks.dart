import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_enum.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/caption_model.dart';
import 'package:fantasy_drum_corps/src/features/fantasy_corps/domain/drum_corps_enum.dart';

const startingDraftPicks = [
  DrumCorpsCaption(
      drumCorpsCaptionId: '1',
      corps: DrumCorps.bluecoats,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '2',
      corps: DrumCorps.bluecoats,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '3',
      corps: DrumCorps.bluecoats,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '4',
      corps: DrumCorps.bluecoats,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '5',
      corps: DrumCorps.bluecoats,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '6',
      corps: DrumCorps.bluecoats,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '7',
      corps: DrumCorps.bluecoats,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '8',
      corps: DrumCorps.bluecoats,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '9',
      corps: DrumCorps.blueDevils,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '10',
      corps: DrumCorps.blueDevils,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '11',
      corps: DrumCorps.blueDevils,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '12',
      corps: DrumCorps.blueDevils,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '13',
      corps: DrumCorps.blueDevils,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '14',
      corps: DrumCorps.blueDevils,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '15',
      corps: DrumCorps.blueDevils,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '16',
      corps: DrumCorps.blueDevils,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '17',
      corps: DrumCorps.blueKnights,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '18',
      corps: DrumCorps.blueKnights,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '19',
      corps: DrumCorps.blueKnights,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '20',
      corps: DrumCorps.blueKnights,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '21',
      corps: DrumCorps.blueKnights,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '22',
      corps: DrumCorps.blueKnights,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '23',
      corps: DrumCorps.blueKnights,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '24',
      corps: DrumCorps.blueKnights,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '25',
      corps: DrumCorps.theAcademy,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '26',
      corps: DrumCorps.theAcademy,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '27',
      corps: DrumCorps.theAcademy,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '28',
      corps: DrumCorps.theAcademy,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '29',
      corps: DrumCorps.theAcademy,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '30',
      corps: DrumCorps.theAcademy,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '31',
      corps: DrumCorps.theAcademy,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '32',
      corps: DrumCorps.theAcademy,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '33',
      corps: DrumCorps.blueStars,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '34',
      corps: DrumCorps.blueStars,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '35',
      corps: DrumCorps.blueStars,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '36',
      corps: DrumCorps.blueStars,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '37',
      corps: DrumCorps.blueStars,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '38',
      corps: DrumCorps.blueStars,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '39',
      corps: DrumCorps.blueStars,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '40',
      corps: DrumCorps.blueStars,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '41',
      corps: DrumCorps.bostonCrusaders,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '42',
      corps: DrumCorps.bostonCrusaders,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '43',
      corps: DrumCorps.bostonCrusaders,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '44',
      corps: DrumCorps.bostonCrusaders,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '45',
      corps: DrumCorps.bostonCrusaders,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '46',
      corps: DrumCorps.bostonCrusaders,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '47',
      corps: DrumCorps.bostonCrusaders,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '48',
      corps: DrumCorps.bostonCrusaders,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '49',
      corps: DrumCorps.theCadets,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '50',
      corps: DrumCorps.theCadets,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '51',
      corps: DrumCorps.theCadets,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '52',
      corps: DrumCorps.theCadets,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '53',
      corps: DrumCorps.theCadets,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '54',
      corps: DrumCorps.theCadets,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '55',
      corps: DrumCorps.theCadets,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '56',
      corps: DrumCorps.theCadets,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '57',
      corps: DrumCorps.carolinaCrown,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '58',
      corps: DrumCorps.carolinaCrown,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '59',
      corps: DrumCorps.carolinaCrown,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '60',
      corps: DrumCorps.carolinaCrown,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '61',
      corps: DrumCorps.carolinaCrown,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '62',
      corps: DrumCorps.carolinaCrown,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '63',
      corps: DrumCorps.carolinaCrown,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '64',
      corps: DrumCorps.carolinaCrown,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '65',
      corps: DrumCorps.theCavaliers,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '66',
      corps: DrumCorps.theCavaliers,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '67',
      corps: DrumCorps.theCavaliers,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '68',
      corps: DrumCorps.theCavaliers,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '69',
      corps: DrumCorps.theCavaliers,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '70',
      corps: DrumCorps.theCavaliers,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '71',
      corps: DrumCorps.theCavaliers,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '72',
      corps: DrumCorps.theCavaliers,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '73', corps: DrumCorps.colts, caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '74',
      corps: DrumCorps.colts,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '75', corps: DrumCorps.colts, caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '76', corps: DrumCorps.colts, caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '77',
      corps: DrumCorps.colts,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '78',
      corps: DrumCorps.colts,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '79',
      corps: DrumCorps.colts,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '80',
      corps: DrumCorps.colts,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '81',
      corps: DrumCorps.crossmen,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '82',
      corps: DrumCorps.crossmen,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '83',
      corps: DrumCorps.crossmen,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '84',
      corps: DrumCorps.crossmen,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '85',
      corps: DrumCorps.crossmen,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '86',
      corps: DrumCorps.crossmen,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '87',
      corps: DrumCorps.crossmen,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '88',
      corps: DrumCorps.crossmen,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '89',
      corps: DrumCorps.genesis,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '90',
      corps: DrumCorps.genesis,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '91', corps: DrumCorps.genesis, caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '92', corps: DrumCorps.genesis, caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '93',
      corps: DrumCorps.genesis,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '94',
      corps: DrumCorps.genesis,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '95',
      corps: DrumCorps.genesis,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '96',
      corps: DrumCorps.genesis,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '97',
      corps: DrumCorps.jerseySurf,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '98',
      corps: DrumCorps.jerseySurf,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '99',
      corps: DrumCorps.jerseySurf,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '100',
      corps: DrumCorps.jerseySurf,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '101',
      corps: DrumCorps.jerseySurf,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '102',
      corps: DrumCorps.jerseySurf,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '103',
      corps: DrumCorps.jerseySurf,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '104',
      corps: DrumCorps.jerseySurf,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '105',
      corps: DrumCorps.madisonScouts,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '106',
      corps: DrumCorps.madisonScouts,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '107',
      corps: DrumCorps.madisonScouts,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '108',
      corps: DrumCorps.madisonScouts,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '109',
      corps: DrumCorps.madisonScouts,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '110',
      corps: DrumCorps.madisonScouts,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '111',
      corps: DrumCorps.madisonScouts,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '112',
      corps: DrumCorps.madisonScouts,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '113',
      corps: DrumCorps.mandarins,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '114',
      corps: DrumCorps.mandarins,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '115',
      corps: DrumCorps.mandarins,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '116',
      corps: DrumCorps.mandarins,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '117',
      corps: DrumCorps.mandarins,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '118',
      corps: DrumCorps.mandarins,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '119',
      corps: DrumCorps.mandarins,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '120',
      corps: DrumCorps.mandarins,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '121',
      corps: DrumCorps.musicCity,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '122',
      corps: DrumCorps.musicCity,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '123',
      corps: DrumCorps.musicCity,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '124',
      corps: DrumCorps.musicCity,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '125',
      corps: DrumCorps.musicCity,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '126',
      corps: DrumCorps.musicCity,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '127',
      corps: DrumCorps.musicCity,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '128',
      corps: DrumCorps.musicCity,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '129',
      corps: DrumCorps.pacificCrest,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '130',
      corps: DrumCorps.pacificCrest,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '131',
      corps: DrumCorps.pacificCrest,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '132',
      corps: DrumCorps.pacificCrest,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '133',
      corps: DrumCorps.pacificCrest,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '134',
      corps: DrumCorps.pacificCrest,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '135',
      corps: DrumCorps.pacificCrest,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '136',
      corps: DrumCorps.pacificCrest,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '137',
      corps: DrumCorps.phantomRegiment,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '138',
      corps: DrumCorps.phantomRegiment,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '139',
      corps: DrumCorps.phantomRegiment,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '140',
      corps: DrumCorps.phantomRegiment,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '141',
      corps: DrumCorps.phantomRegiment,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '142',
      corps: DrumCorps.phantomRegiment,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '143',
      corps: DrumCorps.phantomRegiment,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '144',
      corps: DrumCorps.phantomRegiment,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '145',
      corps: DrumCorps.santaClaraVanguard,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '146',
      corps: DrumCorps.santaClaraVanguard,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '147',
      corps: DrumCorps.santaClaraVanguard,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '148',
      corps: DrumCorps.santaClaraVanguard,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '149',
      corps: DrumCorps.santaClaraVanguard,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '150',
      corps: DrumCorps.santaClaraVanguard,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '151',
      corps: DrumCorps.santaClaraVanguard,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '152',
      corps: DrumCorps.santaClaraVanguard,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '153',
      corps: DrumCorps.seattleCascades,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '154',
      corps: DrumCorps.seattleCascades,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '155',
      corps: DrumCorps.seattleCascades,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '156',
      corps: DrumCorps.seattleCascades,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '157',
      corps: DrumCorps.seattleCascades,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '158',
      corps: DrumCorps.seattleCascades,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '159',
      corps: DrumCorps.seattleCascades,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '160',
      corps: DrumCorps.seattleCascades,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '161',
      corps: DrumCorps.spiritOfAtlanta,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '162',
      corps: DrumCorps.spiritOfAtlanta,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '163',
      corps: DrumCorps.spiritOfAtlanta,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '164',
      corps: DrumCorps.spiritOfAtlanta,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '165',
      corps: DrumCorps.spiritOfAtlanta,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '166',
      corps: DrumCorps.spiritOfAtlanta,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '167',
      corps: DrumCorps.spiritOfAtlanta,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '168',
      corps: DrumCorps.spiritOfAtlanta,
      caption: Caption.visualProficiency),
  //break
  DrumCorpsCaption(
      drumCorpsCaptionId: '169',
      corps: DrumCorps.troopers,
      caption: Caption.brass),
  DrumCorpsCaption(
      drumCorpsCaptionId: '170',
      corps: DrumCorps.troopers,
      caption: Caption.colorGuard),
  DrumCorpsCaption(
      drumCorpsCaptionId: '171',
      corps: DrumCorps.troopers,
      caption: Caption.ge1),
  DrumCorpsCaption(
      drumCorpsCaptionId: '172',
      corps: DrumCorps.troopers,
      caption: Caption.ge2),
  DrumCorpsCaption(
      drumCorpsCaptionId: '173',
      corps: DrumCorps.troopers,
      caption: Caption.musicAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '174',
      corps: DrumCorps.troopers,
      caption: Caption.percussion),
  DrumCorpsCaption(
      drumCorpsCaptionId: '175',
      corps: DrumCorps.troopers,
      caption: Caption.visualAnalysis),
  DrumCorpsCaption(
      drumCorpsCaptionId: '176',
      corps: DrumCorps.troopers,
      caption: Caption.visualProficiency),
];
