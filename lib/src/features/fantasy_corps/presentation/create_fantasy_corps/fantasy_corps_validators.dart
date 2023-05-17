mixin FantasyCorpsValidators {
  String? validateCorpsName(String? input) {
    if (input == null || input.isEmpty) {
      return 'Please enter a Fantasy Corps name to identify your corps';
    } else if (input.length < 6 || input.length > 100) {
      return 'Please enter a name between 6 and 100 characters';
    } else {
      return null;
    }
  }

  String? validateShowTitleAndRepertoire(String? input) {
    if (input == null || input.isEmpty) {
      return null;
    } else {
      return input.length >= 6 && input.length < 150
          ? null
          : 'Please keep your entry between 6 and 150 characters';
    }
  }
}
