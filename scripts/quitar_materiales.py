from pathlib import Path

for path in sorted(Path('.').glob('[0-9][0-9]-*.qmd')):
    text = path.read_text(encoding='utf-8')
    start = text.find('## Materiales complementarios del capítulo')
    if start == -1:
        continue
    end = text.find('## Referencias del capítulo', start)
    if end == -1:
        new = text[:start].rstrip() + '\n'
    else:
        new = text[:start].rstrip() + '\n\n' + text[end:]
    path.write_text(new, encoding='utf-8')
    print('Materiales eliminados:', path)
