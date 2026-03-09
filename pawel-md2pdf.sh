#!/usr/bin/env bash
# MD to PDF converter via pawel-md2html
# Usage: ./md2pdf.sh [input.md]
# Output: [input].pdf (next to source file)

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PAWEL_SKILL="$SCRIPT_DIR/../pawel-md2html"
WORKSPACE="$HOME/.openclaw/workspace"

# Check input file
if [ -z "$1" ]; then
  echo "Usage: $0 [input.md]"
  exit 1
fi

INPUT_MD="$1"
if [ ! -f "$INPUT_MD" ]; then
  echo "Error: File not found: $INPUT_MD"
  exit 1
fi

OUTPUT_PDF="${INPUT_MD%.md}.pdf"
OUTPUT_HTML="${INPUT_MD%.md}.html"

echo "📄 Converting: $INPUT_MD"
echo ""

# Step 1: Generate HTML via pawel-md2html
echo "Step 1/4: Generating HTML (pawel-md2html)..."
cd "$PAWEL_SKILL"
./build-html.sh "$INPUT_MD"
echo "✅ HTML generated: $OUTPUT_HTML"
echo ""

# Step 2: Start HTTP server
echo "Step 2/4: Starting HTTP server..."
cd "$WORKSPACE"
pkill -f "python3 -m http.server" 2>/dev/null || true
python3 -m http.server 8888 &>/tmp/httpserver.log &
SERVER_PID=$!
sleep 2
echo "✅ Server started (PID: $SERVER_PID)"
echo ""

# Step 3: Print to PDF (via browser)
echo "Step 3/4: Printing to PDF..."
echo "   Opening: http://localhost:8888/${OUTPUT_HTML#$WORKSPACE/}"
echo "   Output:  $OUTPUT_PDF"
echo ""
echo "   ⚠️  Browser will open. Please wait for PDF generation..."
echo ""

# Get relative path for URL
REL_HTML_PATH="${OUTPUT_HTML#$WORKSPACE/}"
URL="http://localhost:8888/$REL_HTML_PATH"

# Use OpenClaw browser tool (this part needs to be done via OpenClaw)
# For now, we'll open in default browser and let user print manually
if command -v open >/dev/null 2>&1; then
  open "$URL"
  echo ""
  echo "📋 Next steps (manual):"
  echo "   1. Browser opened with the HTML"
  echo "   2. Press Cmd+P to print"
  echo "   3. Select 'Save as PDF'"
  echo "   4. Save to: $OUTPUT_PDF"
  echo ""
  read -p "Press Enter after saving PDF..."
fi

# Step 4: Cleanup
echo ""
echo "Step 4/4: Cleaning up..."
kill $SERVER_PID 2>/dev/null || true
pkill -f "python3 -m http.server" 2>/dev/null || true
echo "✅ Server stopped"
echo ""

# Verify output
if [ -f "$OUTPUT_PDF" ]; then
  SIZE=$(ls -lh "$OUTPUT_PDF" | awk '{print $5}')
  echo "🎉 Success! PDF generated: $OUTPUT_PDF ($SIZE)"
else
  echo "⚠️  PDF not found. Please check if you saved it correctly."
  exit 1
fi
