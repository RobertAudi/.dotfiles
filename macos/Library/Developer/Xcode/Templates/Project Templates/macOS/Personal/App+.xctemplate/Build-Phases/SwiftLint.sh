set -e

if [[ -d "/opt/homebrew/bin" ]]; then
  export PATH="$PATH:/opt/homebrew/bin"
fi

if command -v swiftlint > /dev/null; then
  swiftlint
else
  echo "error: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
  exit 127
fi
