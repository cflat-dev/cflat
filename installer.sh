#!/usr/bin/env bash
set -e

# Install locations
HEADER_DIR="/usr/local/include/cflat"
LIB_DIR="/usr/local/share/cflat"
BIN_DIR="/usr/local/bin"

echo "Installing CFlat..."

# 1. Install C headers
echo "Installing headers to $HEADER_DIR..."
sudo mkdir -p "$HEADER_DIR"
sudo cp -r include/* "$HEADER_DIR"

# 2. Install Lua compiler files
echo "Installing Lua compiler to $LIB_DIR..."
sudo mkdir -p "$LIB_DIR"
sudo cp cfc.lua "$LIB_DIR"
sudo cp parser.lua "$LIB_DIR"

# 3. Create launcher script
echo "Creating cfc launcher in $BIN_DIR..."
sudo tee "$BIN_DIR/cfc" > /dev/null <<EOF
#!/usr/bin/env bash
lua $LIB_DIR/cfc.lua "\$@"
EOF

sudo chmod +x "$BIN_DIR/cfc"

echo "CFlat installed successfully."
echo "You can now run: cfc <file>"
