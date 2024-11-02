// ParsleyConfig definition if not already set
window.ParsleyConfig = window.ParsleyConfig || {};
window.ParsleyConfig.i18n = window.ParsleyConfig.i18n || {};

// Define then the messages
window.ParsleyConfig.i18n['pt-br'] = jQuery.extend(window.ParsleyConfig.i18n['pt-br'] || {}, {
  defaultMessage: "Este valor parece ser inválido.",
  type: {
    email:        "Este campo deve ser um email válido.",
    url:          "Este campo deve ser um URL válida.",
    number:       "Este campo deve ser um número válido.",
    integer:      "Este campo deve ser um inteiro válido.",
    digits:       "Este campo deve conter apenas dígitos.",
    alphanum:     "Este campo deve ser alfa numerico."
  },
  notblank:       "Este campo não pode ficar vazio.",
  required:       "Este campo e obrigatório.",
  pattern:        "Este campo parece estar inválido.",
  min:            "Este campo deve ser maior ou igual a %s.",
  max:            "Este campo deve ser menor ou igual a %s.",
  range:          "Este campo deve estar entre %s e %s.",
  minlength:      "Este campo e pequeno demais. Ele deveria ter %s caracteres ou mais.",
  maxlength:      "Este campo e grande demais. Ele deveria ter %s caracteres ou menos.",
  length:         "O tamanho deste campo e inválido. Ele deveria ter entre %s e %s caracteres.",
  mincheck:       "Voce deve escolher pelo menos %s opções.",
  maxcheck:       "Voce deve escolher %s opções ou mais",
  check:          "Voce deve escolher entre %s e %s opções.",
  equalto:        "Este valor deveria ser igual."
});

// If file is loaded after Parsley main file, auto-load locale
if ('undefined' !== typeof window.ParsleyValidator)
  window.ParsleyValidator.addCatalog('pt-br', window.ParsleyConfig.i18n['pt-br'], true);
