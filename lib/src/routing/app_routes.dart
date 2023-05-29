enum AppRoutes {
  signIn,
  dashboard,
  tours,
  profile,
  createTour,
  register,
  myTours,
  searchTours,
  tourDetail,
  draft,
  allCorps,
  about,
  editTour,
  joinTour,
  leaveTour,
  manageTour,
  createFluttermoji,
  draftLobby,
  createCorps,
  myCorps,
  corpsDetail,
  leaderboard,
  adminMain,
  adminAddScore,
  howToPlay,
}

extension RouteNames on AppRoutes {
  String get fullName {
    switch (this) {
      case AppRoutes.signIn:
        return name;
      case AppRoutes.dashboard:
        return 'Corps Hall';
      case AppRoutes.tours:
        return 'My Tours';
      case AppRoutes.profile:
        return name;
      case AppRoutes.createTour:
        return 'Create a Tour';
      case AppRoutes.register:
        return name;
      case AppRoutes.myTours:
        return 'My Tours';
      case AppRoutes.searchTours:
        return 'Find a Tour';
      case AppRoutes.tourDetail:
        return name;
      case AppRoutes.draft:
        return name;
      case AppRoutes.allCorps:
        return name;
      case AppRoutes.about:
        return 'About';
      case AppRoutes.editTour:
        return name;
      case AppRoutes.joinTour:
        return 'Find a Tour';
      case AppRoutes.leaveTour:
        return name;
      case AppRoutes.manageTour:
        return name;
      case AppRoutes.createFluttermoji:
        return name;
      case AppRoutes.draftLobby:
        return name;
      case AppRoutes.createCorps:
        return name;
      case AppRoutes.myCorps:
        return 'My Fantasy Corps';
      case AppRoutes.corpsDetail:
        return name;
      case AppRoutes.leaderboard:
        return 'Leaderboard';
      case AppRoutes.adminMain:
        return name;
      case AppRoutes.adminAddScore:
        return name;
      case AppRoutes.howToPlay:
        return 'How to Play';
    }
  }
}
