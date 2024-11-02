// ParsleyConfig definition if not already set
window.ParsleyConfig = window.ParsleyConfig || {};
window.ParsleyConfig.i18n = window.ParsleyConfig.i18n || {};

// Define then the messages
window.ParsleyConfig.i18n.fr = jQuery.extend(window.ParsleyConfig.i18n.fr || {}, {
  defaultMessage: "Cette valeur semble non valide.",
  type: {
    email:        "Cette valeur n'est pas une adresse email valide.",
    url:          "Cette valeur n'est pas une URL valide.",
    number:       "Cette valeur doit etre un nombre.",
    integer:      "Cette valeur doit etre un entier.",
    digits:       "Cette valeur doit etre numerique.",
    alphanum:     "Cette valeur doit etre alphanumerique."
  },
  notblank:       "Cette valeur ne peut pas etre vide.",
  required:       "Ce champ est requis.",
  pattern:        "Cette valeur semble non valide.",
  min:            "Cette valeur ne doit pas etre inferieure à %s.",
  max:            "Cette valeur ne doit pas exceder %s.",
  range:          "Cette valeur doit etre comprise entre %s et %s.",
  minlength:      "Cette chaîne est trop courte. Elle doit avoir au minimum %s caracteres.",
  maxlength:      "Cette chaîne est trop longue. Elle doit avoir au maximum %s caracteres.",
  length:         "Cette valeur doit contenir entre %s et %s caracteres.",
  mincheck:       "Vous devez selectionner au moins %s choix.",
  maxcheck:       "Vous devez selectionner %s choix maximum.",
  check:          "Vous devez selectionner entre %s et %s choix.",
  equalto:        "Cette valeur devrait etre identique."
});

// If file is loaded after Parsley main file, auto-load locale
if ('undefined' !== typeof window.ParsleyValidator)
  window.ParsleyValidator.addCatalog('fr', window.ParsleyConfig.i18n.fr, true);
