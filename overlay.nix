inputs: final: prev: {
  tinymist-rnote = inputs.tinymist-rnote.packages.${prev.system}.tinymist;
}
