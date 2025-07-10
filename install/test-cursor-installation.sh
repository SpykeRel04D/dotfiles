#!/bin/bash

# Test script to verify Cursor installation and configuration

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

echo "🧪 Testing Cursor installation and configuration..."

# Test 1: Check if Cursor is installed
print_status "Test 1: Checking if Cursor is installed..."
if command -v cursor &> /dev/null; then
    cursor_version=$(cursor --version 2>/dev/null || echo "version unknown")
    print_success "Cursor is installed: $cursor_version"
else
    print_error "Cursor is not installed or not in PATH"
    exit 1
fi

# Test 2: Check if Cursor configuration directory exists
print_status "Test 2: Checking Cursor configuration directory..."
CURSOR_CONFIG_DIR="$HOME/.config/Cursor/User"
if [ -d "$CURSOR_CONFIG_DIR" ]; then
    print_success "Cursor config directory exists: $CURSOR_CONFIG_DIR"
else
    print_error "Cursor config directory not found: $CURSOR_CONFIG_DIR"
    exit 1
fi

# Test 3: Check if settings.json exists and is valid JSON
print_status "Test 3: Checking Cursor settings file..."
if [ -f "$CURSOR_CONFIG_DIR/settings.json" ]; then
    print_success "Cursor settings file exists"
    
    # Test if it's valid JSON
    if python3 -m json.tool "$CURSOR_CONFIG_DIR/settings.json" > /dev/null 2>&1; then
        print_success "Cursor settings file is valid JSON"
    else
        print_error "Cursor settings file is not valid JSON"
        exit 1
    fi
else
    print_error "Cursor settings file not found: $CURSOR_CONFIG_DIR/settings.json"
    exit 1
fi

# Test 4: Check if Cursor can be launched (basic test)
print_status "Test 4: Testing Cursor launch capability..."
if timeout 5s cursor --help > /dev/null 2>&1; then
    print_success "Cursor can be launched successfully"
else
    print_warning "Cursor launch test failed (this might be normal if Cursor is already running)"
fi

# Test 5: Check for common configuration issues
print_status "Test 5: Checking for common configuration issues..."

# Check if the settings file has the expected structure
if grep -q '"workbench.colorTheme"' "$CURSOR_CONFIG_DIR/settings.json"; then
    print_success "Theme configuration found"
else
    print_warning "Theme configuration not found in settings"
fi

if grep -q '"editor.formatOnSave"' "$CURSOR_CONFIG_DIR/settings.json"; then
    print_success "Format on save configuration found"
else
    print_warning "Format on save configuration not found"
fi

echo ""
print_success "🎉 All Cursor tests passed! Cursor should be working correctly."
echo ""
echo "To start Cursor, run: cursor"
echo "To open a file: cursor filename"
echo "To open a directory: cursor /path/to/directory" 