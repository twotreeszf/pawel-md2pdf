---
name: pawel-md2pdf
description: Convert Markdown to PDF via pawel-md2html. Generates beautiful HTML first, then prints to PDF using browser. (Pawel's custom build)
---

# Markdown to PDF Converter

Convert Markdown documents to PDF using the **pawel-md2html** skill + browser print.

## Workflow

```
Markdown → pawel-md2html → HTML → Browser Print → PDF
```

## Usage

```bash
# Run the pawel-md2pdf skill
# This will:
# 1. Call pawel-md2html to generate HTML
# 2. Start local HTTP server
# 3. Open browser and print to PDF
# 4. Clean up

# Basic usage
./pawel-md2pdf.sh /path/to/input.md

# Output: /path/to/input.pdf (next to source .md file)
```

## Full Process

### Step 1: Generate HTML (pawel-md2html)

```bash
cd ~/.openclaw/workspace/skills/pawel-md2html
./build-html.sh /path/to/input.md
# Output: /path/to/input.html
```

### Step 2: Start HTTP Server

```bash
cd ~/.openclaw/workspace
python3 -m http.server 8888 &
```

### Step 3: Print to PDF (Browser)

```bash
# Via OpenClaw browser tool
browser(action=open, url="http://localhost:8888/input.html")
browser(action=pdf, fullPage=true, path="output.pdf")
```

### Step 4: Cleanup

```bash
pkill -f "python3 -m http.server"
```

## Example

```bash
# Convert oil price report
./md2pdf.sh ~/.openclaw/workspace/油价调整报告_20260310.md

# Output: ~/.openclaw/workspace/油价调整报告_20260310.pdf
```

## Output Quality

| Feature | Details |
|---------|---------|
| Styling | Tailwind CSS (via pawel-md2html) |
| Theme | Light mode (default for PDF) |
| Fonts | Noto Sans SC (Chinese optimized) |
| Size | ~1MB (high quality) |
| Pages | Auto (full document) |

## Dependencies

- pawel-md2html skill (must be installed)
- Node.js (for pawel-md2html)
- Python3 (for HTTP server)
- OpenClaw browser tool (for PDF print)

## Notes

- PDF is generated via browser print (not direct conversion)
- Requires OpenClaw browser capability
- HTTP server is started/stopped automatically
- Output PDF location: same directory as source .md file

## Related

- pawel-md2html: `~/.openclaw/workspace/skills/pawel-md2html/SKILL.md`
