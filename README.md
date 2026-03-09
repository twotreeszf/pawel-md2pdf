# pawel-md2pdf

Convert Markdown to PDF via pawel-md2html. Generates beautiful HTML first, then prints to PDF using browser automation.

## Features

- 📄 **One-Click PDF** - Single command converts MD → PDF
- 🎨 **Beautiful Styling** - Powered by pawel-md2html (Tailwind CSS)
- 🀄 **Chinese Support** - Noto Sans SC font optimization
- 🤖 **Automated** - Browser print automation via OpenClaw
- 🧹 **Auto Cleanup** - HTTP server starts/stops automatically

## Workflow

```
Markdown → pawel-md2html → HTML → Browser Print → PDF
```

## Usage

```bash
# Clone the repository
git clone https://github.com/twotreeszf/pawel-md2pdf.git
cd pawel-md2pdf

# Run converter
./pawel-md2pdf.sh /path/to/input.md

# Output: input.pdf (next to source .md file)
```

## Example

```bash
./pawel-md2pdf.sh docs/report.md
open docs/report.pdf
```

## Dependencies

- **pawel-md2html** - Must be installed (sibling repository)
- **Node.js** - For pawel-md2html
- **Python3** - For HTTP server
- **OpenClaw** - For browser automation

## Project Structure

```
pawel-md2pdf/
├── pawel-md2pdf.sh       # Main script
├── package.json          # npm dependencies
├── README.md
└── SKILL.md              # OpenClaw skill definition
```

## Output Quality

| Feature | Details |
|---------|---------|
| Styling | Tailwind CSS (via pawel-md2html) |
| Theme | Light mode (default for PDF) |
| Fonts | Noto Sans SC |
| Size | ~1MB (high quality) |
| Pages | Auto (full document) |

## Related Projects

- [pawel-md2html](https://github.com/twotreeszf/pawel-md2html) - HTML generator

## License

MIT

## Author

Pawel Balinski
