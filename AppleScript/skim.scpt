JsOsaDAS1.001.00bplist00�Vscript_�function run(argv) {
  if (argv !== undefined && argv.length > 0) {
    var app = Application('Skim');
    app.activate();
    var file = Path(argv.join(' '));
    app.open(file);
    return;
  }
  return 'No pdf file provide.';
}                            �jscr  ��ޭ